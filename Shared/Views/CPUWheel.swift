//
//  CPUWheel.swift
//  MySwiftApp
//
//  Created by Abenx on 2020/6/29.
//

import SwiftUI

struct CPUWheel: View {
    @State private var cpu: Int = 0
    
    var timer = Timer.publish(every: 0.1, on: .current, in: .common).autoconnect()
    
    var body: some View {
        let gradient = AngularGradient(gradient: Gradient(colors: [.green, .yellow, .orange, .red]), center: .center, angle: .degrees(0))
        return Circle()
            .stroke(lineWidth: 2)
            .foregroundColor(.primary)
            .background(Circle().fill(gradient).clipShape(CPUClip(pct: Double(self.cpu))))
            .shadow(radius: 4)
            .overlay(CPULabel(pct: self.cpu))
            .onReceive(timer) { _ in
                withAnimation {
                    self.cpu = Int(Self.cpuUsage())
                }
            }
    }
    
    struct CPUClip: Shape {
        let pct: Double
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            let cp = CGPoint(x: rect.midX, y: rect.midY)
            
            path.move(to: cp)
            path.addArc(center: cp, radius: rect.height / 2, startAngle: .degrees(0), endAngle: .degrees(pct / 100.0 * 360.0), clockwise: false)
            path.closeSubpath()
            
            return path
        }
    }
    
    struct CPULabel: View {
        let pct: Int
        
        var body: some View {
            VStack {
                Text("\(self.pct) %")
                    .font(.largeTitle)
                    .fontWeight(.thin)
                Text("CPU")
                    .font(.body)
                    .fontWeight(.thin)
            }
            .transaction { $0.animation = nil }
        }
    }
    
    // Source for cpuUsage(): based on https://stackoverflow.com/a/44134397/7786555
    static func cpuUsage() -> Double {
        var kr: kern_return_t
        var task_info_count: mach_msg_type_number_t
        
        task_info_count = mach_msg_type_number_t(TASK_INFO_MAX)
        var tinfo = [integer_t](repeating: 0, count: Int(task_info_count))
        
        kr = task_info(mach_task_self_, task_flavor_t(TASK_BASIC_INFO), &tinfo, &task_info_count)
        if kr != KERN_SUCCESS {
            return -1
        }
        
        return [thread_act_t]().withUnsafeBufferPointer { bufferPointer in
            var thread_list: thread_act_array_t? = UnsafeMutablePointer(mutating: bufferPointer.baseAddress)
            var thread_count: mach_msg_type_number_t = 0
            defer {
                if let thread_list = thread_list {
                    vm_deallocate(mach_task_self_, vm_address_t(bitPattern: thread_list), vm_size_t(Int(thread_count) * MemoryLayout<thread_t>.stride))
                }
            }
            
            kr = task_threads(mach_task_self_, &thread_list, &thread_count)
            
            if kr != KERN_SUCCESS {
                return -1
            }
            
            var tot_cpu: Double = 0
            
            if let thread_list = thread_list {
                for j in 0..<Int(thread_count) {
                    var thread_info_count = mach_msg_type_number_t(THREAD_INFO_MAX)
                    var thinfo = [integer_t](repeating: 0, count: Int(thread_info_count))
                    kr = thread_info(thread_list[j], thread_flavor_t(THREAD_BASIC_INFO),
                                     &thinfo, &thread_info_count)
                    if kr != KERN_SUCCESS {
                        return -1
                    }
                    
                    let threadBasicInfo = convertThreadInfoToThreadBasicInfo(thinfo)
                    
                    if threadBasicInfo.flags != TH_FLAGS_IDLE {
                        tot_cpu += (Double(threadBasicInfo.cpu_usage) / Double(TH_USAGE_SCALE)) * 100.0
                    }
                } // for each thread
            }
            
            return tot_cpu
        }
    }
    
    static func convertThreadInfoToThreadBasicInfo(_ threadInfo: [integer_t]) -> thread_basic_info {
        var result = thread_basic_info()
        
        result.user_time = time_value_t(seconds: threadInfo[0], microseconds: threadInfo[1])
        result.system_time = time_value_t(seconds: threadInfo[2], microseconds: threadInfo[3])
        result.cpu_usage = threadInfo[4]
        result.policy = threadInfo[5]
        result.run_state = threadInfo[6]
        result.flags = threadInfo[7]
        result.suspend_count = threadInfo[8]
        result.sleep_time = threadInfo[9]
        
        return result
    }
}

struct CPUWheel_Previews: PreviewProvider {
    static var previews: some View {
        CPUWheel()
    }
}

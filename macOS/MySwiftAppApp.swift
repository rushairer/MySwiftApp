//
//  MySwiftAppApp.swift
//  Shared
//
//  Created by Abenx on 2020/6/26.
//

import SwiftUI

@main
struct MySwiftAppApp: App {
    var cpuWheelWindow = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
                                  styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                                  backing: .buffered,
                                  defer: false)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserData())
                .onAppear{
                    self.cpuWheelWindow.contentView = NSHostingView(rootView: CPUWheel().frame(width: 100, height: 100).padding())
                    self.cpuWheelWindow.makeKeyAndOrderFront(nil)
                }
        }
    }
}

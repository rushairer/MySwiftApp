//
//  HikeDetail.swift
//  MySwiftApp
//
//  Created by Abenx on 2020/6/27.
//

import SwiftUI

struct HikeDetail: View {
    let hike: Hike
    @State var dataToShow = \Hike.Observation.elevation
    
    var buttons = [
        ("Elevation", \Hike.Observation.elevation),
        ("Heart Rate", \Hike.Observation.heartRate),
        ("Pace", \Hike.Observation.pace),
    ]
    
    var body: some View {
        return VStack {
            HikeGraph(hike: hike, path: dataToShow)
                .frame(height: 200)
            
            HStack(spacing: 25) {
                ForEach(buttons, id: \.0) { value in
                    Text(value.0)
                        .font(.system(size: 15))
                        .foregroundColor(value.1 == self.dataToShow
                                            ? Color.gray
                                            : Color.accentColor)
                        .animation(nil)
                        .onTapGesture {
                            self.dataToShow = value.1
                            
                        }
                }
            }
        }
    }
}

struct HikeDetail_Previews: PreviewProvider {
    static var previews: some View {
        HikeDetail(hike: hikeData[0])
    }
}

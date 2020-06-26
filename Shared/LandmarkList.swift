//
//  LandmarkList.swift
//  MySwiftApp
//
//  Created by Abenx on 2020/6/26.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        List(landmarkData) { landmark in
            NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                LandmarkRow(landmark: landmark)
            }
        }
        .navigationBarTitle("Landmarks")
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 11 Pro Max", "iPhone 8", "iPad Pro (12.9-inch) (4th generation)"], id: \.self) { deviceName in
            NavigationView {
                LandmarkList()
            }
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}

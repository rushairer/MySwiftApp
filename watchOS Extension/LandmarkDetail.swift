//
//  LandmarkDetail.swift
//  watchOS Extension
//
//  Created by Abenx on 2020/6/27.
//

import SwiftUI

struct LandmarkDetail: View {
    @EnvironmentObject var userData: UserData

    var landmark: Landmark
    
    var landmarkIndex: Int {
        userData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }

    var body: some View {
        ScrollView {
            VStack {
                CircleImage(image: self.landmark.image.resizable())
                    .scaledToFit()
                
                Text(self.landmark.name)
                    .font(.headline)
                    .lineLimit(0)
                
                Toggle(isOn:
                        $userData.landmarks[self.landmarkIndex].isFavorite) {
                    Text("Favorite")
                }
                
                Divider()
                
                Text(self.landmark.park)
                    .font(.caption)
                    .bold()
                    .lineLimit(0)
                
                Text(self.landmark.state)
                    .font(.caption)
                
                Divider()
                
                WatchMapView(landmark: self.landmark)
                    .scaledToFit()
                    .padding()
            }
            .padding(16)
        }
        .navigationBarTitle("Landmarks")
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["Apple Watch Series 5 - 44mm", "Apple Watch Series 5 - 40mm"], id: \.self) { deviceName in
            let userData = UserData()
            LandmarkDetail(landmark: userData.landmarks[0])
                .environmentObject(userData)
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}

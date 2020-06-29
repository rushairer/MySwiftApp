//
//  LandmarkDetail.swift
//  Shared
//
//  Created by Abenx on 2020/6/26.
//

import SwiftUI

struct LandmarkDetail: View {
    @EnvironmentObject var userData: UserData
    var landmark: Landmark

    var landmarkIndex: Int {
        userData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }
    
    var body: some View {
        VStack {
            MapView(coordinate: landmark.locationCoordinate)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 300)
            CircleImage(image: landmark.image)
                .offset(y: -140)
                .padding(.bottom, -140)
            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.name)
                        .fontWeight(/*@START_MENU_TOKEN@*/.ultraLight/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .font(.largeTitle)
                    Button(action: {
                        self.userData.landmarks[self.landmarkIndex].isFavorite.toggle()
                    }) {
                        if self.userData.landmarks[self.landmarkIndex].isFavorite {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.yellow)
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(Color.gray)
                        }
                    }
                }
                HStack(alignment: .top) {
                    Text(landmark.park)
                        .font(.subheadline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.ultraLight/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Text(landmark.state)
                        .font(.subheadline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.ultraLight/*@END_MENU_TOKEN@*/)
                }
            }
            .padding()
            Spacer()
        }
        .navigationBarTitle(Text(landmark.name))
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: landmarkData[0])
            .environmentObject(UserData())
    }
}

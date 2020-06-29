//
//  LandmarkList.swift
//  MySwiftApp
//
//  Created by Abenx on 2020/6/26.
//

import SwiftUI

struct LandmarkList<DetailView: View>: View {
    @EnvironmentObject var userData: UserData
    
    let detailViewProducer: (Landmark) -> DetailView
    
    var body: some View {
        List {
            Toggle(isOn: $userData.showFavoritesOnly) {
                Text("Favorites only")
            }
            
            ForEach(userData.landmarks.filter({ (landmark) -> Bool in
                return !self.userData.showFavoritesOnly || landmark.isFavorite
            })) { landmark in

                NavigationLink(
                    destination: self.detailViewProducer(landmark).environmentObject(self.userData)) {
                    LandmarkRow(landmark: landmark)
                }
                
            }
        }
        .navigationBarTitle("Landmarks")
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList { LandmarkDetail(landmark: $0) }
            .environmentObject(UserData())
    }
}

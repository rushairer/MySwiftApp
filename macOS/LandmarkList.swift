//
//  LandmarkList.swift
//  macOS
//
//  Created by Abenx on 2020/6/28.
//

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject private var userData: UserData
    @Binding var selectedLandmark: Landmark?
    @Binding var filter: FilterType
    
    var body: some View {
        VStack {
            List(selection: $selectedLandmark) {
                ForEach(userData.landmarks.filter({ (landmark) -> Bool in
                    return (!userData.showFavoritesOnly || landmark.isFavorite)
                        && (self.filter == .all
                                || self.filter.category == landmark.category
                                || (self.filter.category == .featured && landmark.isFeatured))
                })) { landmark in
                    LandmarkRow(landmark: landmark).tag(landmark)
                }
            }.onChange(of: userData.showFavoritesOnly) { [userData] newState in
                print("LandmarkList:userData.showFavoritesOnly: \(userData.showFavoritesOnly)")
                print("LandmarkList:newState: \(newState)")
            }
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList(selectedLandmark: .constant(landmarkData[0]),
                     filter: .constant(.all))
            .environmentObject(UserData())
    }
}

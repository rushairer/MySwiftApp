//
//  UserData.swift
//  MySwiftApp
//
//  Created by Abenx on 2020/6/27.
//

import Combine
import SwiftUI

final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
    @Published var profile = Profile.default
}

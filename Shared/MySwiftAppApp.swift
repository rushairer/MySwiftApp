//
//  MySwiftAppApp.swift
//  Shared
//
//  Created by Abenx on 2020/6/26.
//

import SwiftUI

@main
struct MySwiftAppApp: App {
    var body: some Scene {
        WindowGroup {
            CategoryHome()
            .environmentObject(UserData())
        }
    }
}

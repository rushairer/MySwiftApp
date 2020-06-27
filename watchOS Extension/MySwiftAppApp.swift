//
//  MySwiftAppApp.swift
//  watchOS Extension
//
//  Created by Abenx on 2020/6/27.
//

import SwiftUI

@main
struct MySwiftAppApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "LandmarkNear")
    }
}

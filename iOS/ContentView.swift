//
//  ContentView.swift
//  iOS
//
//  Created by Abenx on 2020/6/28.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData

    var body: some View {
        CategoryHome()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

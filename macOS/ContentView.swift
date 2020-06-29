//
//  ContentView.swift
//  macOS
//
//  Created by Abenx on 2020/6/28.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedLandmark: Landmark?
    @EnvironmentObject var userData: UserData

    
    var body: some View {
        NavigationView {
            NavigationPrimary(selectedLandmark: $selectedLandmark)
            
            if selectedLandmark != nil {
                NavigationDetail(landmark: selectedLandmark!)
            }
        }
        .frame(minWidth: 700, minHeight: 300)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}

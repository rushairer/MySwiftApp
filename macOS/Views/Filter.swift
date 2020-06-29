//
//  Filter.swift
//  macOS
//
//  Created by Abenx on 2020/6/28.
//

import SwiftUI

struct Filter: View {
    @EnvironmentObject private var userData: UserData
    @Binding var filter: FilterType
    
    var body: some View {
        HStack {
            Picker(selection: $filter, label: EmptyView()) {
                ForEach(FilterType.allCases) { choice in
                    Text(choice.name).tag(choice)
                }
            }
            
            Spacer()
            
            Toggle(isOn: Binding(get: {
                userData.showFavoritesOnly
            }, set: { newVal in
                userData.showFavoritesOnly = newVal
            })) {
                Text("Favorites only")
            }.onChange(of: userData.showFavoritesOnly) { [userData] newState in
                print("Filter:userData.showFavoritesOnly: \(userData.showFavoritesOnly)")
                print("Filter:newState: \(newState)")
            }
        }
    }
}

struct FilterType: CaseIterable, Hashable, Identifiable {
    var name: String
    var category: Landmark.Category?
    
    init(_ category: Landmark.Category) {
        self.name = category.rawValue
        self.category = category
    }
    
    init(name: String) {
        self.name = name
        self.category = nil
    }
    
    static var all = FilterType(name: "All")
    
    static var allCases: [FilterType] {
        return [.all] + Landmark.Category.allCases.map(FilterType.init)
    }
    
    var id: FilterType {
        return self
    }
}

struct Filter_Previews: PreviewProvider {
    static var previews: some View {
        Filter(filter: .constant(.all))
            .environmentObject(UserData())
    }
}

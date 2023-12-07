//
//  ContentView.swift
//  SwiftBookApp
//
//  Created by Roman Khancha on 19.11.2023.
//

import SwiftUI

struct ContentView: View {
    
    var categories: [String: [ProductsResponse]] {
        .init(grouping: materialResponse, by: {$0.category.rawValue})
    }
    
    var body: some View {
        NavigationView {
            List {
                Cell(user: swiftbook).listRowInsets(EdgeInsets())
                ForEach(self.categories.keys.sorted(), id: \.self) { key in
                    ProductRow(categoryName: key, items: self.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
                
                NavigationLink(destination: TheacherList()) {
                    Text("Наши преподаватели")
                }
            }
            .navigationTitle("Homepage")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .dynamicTypeSize(.accessibility1)
    }
}

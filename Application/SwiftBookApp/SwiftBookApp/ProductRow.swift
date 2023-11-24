//
//  ProductRow.swift
//  SwiftBookApp
//
//  Created by Roman Khancha on 19.11.2023.
//

import SwiftUI

struct ProductRow: View {
    
    var categoryName: String
    var items: [ProductsResponse]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Text(categoryName)
                .padding(.leading, 15)
                .padding(.top, 5)
                .font(.headline)
            ScrollView(.horizontal) {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(items) { item in
                        NavigationLink(destination: DetailScreen(object: item)) {
                            ProductItem(object: item)
                        }
                    }
                }
            }
            .frame(height: 190)
        }
        .dynamicTypeSize(.small)
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(categoryName: materialResponse[0].category.rawValue, items: Array(materialResponse.prefix(3)))
    }
}

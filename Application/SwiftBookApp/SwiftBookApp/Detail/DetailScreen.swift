//
//  DetailScreen.swift
//  SwiftBookApp
//
//  Created by Roman Khancha on 21.11.2023.
//

import SwiftUI

struct DetailScreen: View {
    
    var object: ProductsResponse
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                VStack(spacing: 20.0) {
                    MainImage(object: object)
                    Text(object.name)
                        .font(.title)
                }
                LittleStack(object: object)
                
                VStack(alignment: .leading, spacing: 12.0) {
                    Text("Описание")
                        .font(.title)
                    Text(object.description)
                }
                Spacer()
            }
        }
        .padding()
    }
}

struct LittleStack: View {
    
    var object: ProductsResponse
    
    var body: some View {
        HStack(spacing: 30.0) {
            VStack {
                Text("\(object.lessons)")
                    .font(.title)
                Text("Lessons")
                    .font(.body)
                    .fontWeight(.medium)
            }
            VStack {
                Text("\(object.students)")
                    .font(.title)
                Text("Students")
                    .font(.body)
                    .fontWeight(.medium)
            }
        }
    }
}

struct MainImage: View {
    
    var object: ProductsResponse
    
    var body: some View {
        Image(object.image)
            .resizable()
            .frame(width: 170, height: 170)
            .cornerRadius(30)
            .overlay(RoundedRectangle(cornerRadius: 30)
                .stroke(.gray, lineWidth: 3))
            .shadow(radius: 10)
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreen(object: materialResponse[2])
    }
}

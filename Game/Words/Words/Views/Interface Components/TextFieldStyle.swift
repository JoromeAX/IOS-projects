//
//  TextFieldStyle.swift
//  Words
//
//  Created by Roman Khancha on 22.11.2023.
//

import SwiftUI

struct TextFieldStyle: View {
    
    var title: String
    @State var word: Binding<String>
    
    var body: some View {
        
        TextField(title, text: word)
            .frame(height: 50.0)
            .background(.white)
            .cornerRadius(30)
            .font(.title2)
            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

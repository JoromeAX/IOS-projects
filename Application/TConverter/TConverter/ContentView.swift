//
//  ContentView.swift
//  TConverter
//
//  Created by Roman Khancha on 16.11.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var temperatyre = 0.0
    @State private var isEditing = false
    @State private var celsiusLabel = "ºC"
    @State private var fahrenheitLabel = "ºF"
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Text("T-Converter")
                    .font(Font.custom("MarkerFelt-Wide", size: 30))
                    .foregroundColor(.white)
                Spacer()
                Text(String(Int(temperatyre)) + celsiusLabel)
                    .font(Font.custom("MarkerFelt-Wide", size: 40))
                    .foregroundColor(.white)
                Slider(value: $temperatyre,
                       in: 0...100,
                       onEditingChanged: { editing in
                    isEditing = editing
                })
                .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                Text(String((Int(temperatyre) * 9/5) + 32) + fahrenheitLabel)
                    .font(Font.custom("MarkerFelt-Wide", size: 40))
                    .foregroundColor(.white)
                Spacer()
            }
            .dynamicTypeSize(.accessibility1)
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

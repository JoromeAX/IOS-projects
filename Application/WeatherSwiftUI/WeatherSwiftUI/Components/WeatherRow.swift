//
//  WeatherRow.swift
//  WeatherSwiftUI
//
//  Created by Roman Khancha on 25.06.2023.
//

import SwiftUI

struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: logo)
                .font(.title)
                .frame(width: 25, height: 25)
                .padding()
                .background(Color(hue: 0.651, saturation: 0.502, brightness: 0.968, opacity: 0.622))
                .cornerRadius(50)
                .foregroundColor(.white)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.custom("CaviarDreams", size: 20))
                    .foregroundColor(.white)
                
                Text(value)
                    .font(.custom("CaviarDreams", size: 35))
                    .foregroundColor(.white)
            }
        }
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(logo: "thermometer", name: "Feels like", value: "8°")
    }
}

//
//  EnterView.swift
//  WeatherSwiftUI
//
//  Created by Roman Khancha on 25.06.2023.
//

import SwiftUI
import CoreLocationUI

struct EnterView: View {
    @EnvironmentObject var locationManager: LocationManager
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome")
                    .font(.custom("CaviarDreams", size: 75))
                
                Text("Please share your current location to get ther weather in your area")
                    .padding()
                    .font(.custom("CaviarDreams", size: 20))
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct EnterView_Previews: PreviewProvider {
    static var previews: some View {
        EnterView()
    }
}

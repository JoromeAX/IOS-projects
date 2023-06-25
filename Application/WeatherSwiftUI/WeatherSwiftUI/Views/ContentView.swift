//
//  ContentView.swift
//  WeatherSwiftUI
//
//  Created by Roman Khancha on 25.06.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else if locationManager.isLoading {
                LoadingView()
            } else {
                EnterView()
                    .environmentObject(locationManager)
            }
        }
        .background(Color(hue: 0.704, saturation: 0.822, brightness: 0.346))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

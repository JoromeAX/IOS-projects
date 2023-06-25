//
//  WeatherView.swift
//  WeatherSwiftUI
//
//  Created by Roman Khancha on 25.06.2023.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .font(.custom("CaviarDreams", size: 50))
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day()))")
                        .font(.custom("CaviarDreams", size: 25))
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            Image(systemName: "sun.max")
                                .font(.system(size: 50))
                            
                            Text(weather.weather[0].main)
                                .font(.custom("CaviarDreams", size: 30))
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        
                        Text(weather.main.feelsLike.roundDouble() + "°")
                            .font(.custom("CaviarDreams", size: 100))
                            .padding()
                    }
                    
                    Spacer()
                        .frame(height: 80)
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now")
                        .foregroundColor(.white)
                        .font(.custom("CaviarDreams", size: 25))
                        .padding(.bottom)
                    
                    HStack {
                        WeatherRow(logo: "thermometer.low", name: "Min Temp", value: weather.main.tempMin.roundDouble() + "°")
                        
                        Spacer()
                        
                        WeatherRow(logo: "thermometer.high", name: "Max Temp", value: weather.main.tempMax.roundDouble() + "°")
                    }
                    
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind speed", value: weather.wind.speed.roundDouble() + "m/s")
                        
                        Spacer()
                        
                        WeatherRow(logo: "humidity", name: "Humidity", value: weather.main.humidity.roundDouble() + "%")
                            .padding(17)
                    }
                }
                .padding()
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color(hue: 0.704, saturation: 0.822, brightness: 0.346))
                .background(Color(hue: 0.671, saturation: 0.607, brightness: 0.452))
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.704, saturation: 0.822, brightness: 0.346))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}

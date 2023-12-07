//
//  SecondView.swift
//  PassDataProgect
//
//  Created by Roman Khancha on 16.11.2023.
//

import SwiftUI

struct SecondView: View {
    
    @State private var showingDetail = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Intruder!")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                Text("Wrong Password")
                    .font(.headline)
                    .foregroundColor(.red)
                Spacer()
                Button("Get out of here!!!".uppercased()) {
                    self.showingDetail.toggle()
                }.fullScreenCover(isPresented: $showingDetail) {
                    ContentView()
                }
                .foregroundColor(.red)
                .cornerRadius(15)
                Spacer()
            }
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}

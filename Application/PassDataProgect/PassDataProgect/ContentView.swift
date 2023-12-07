//
//  ContentView.swift
//  PassDataProgect
//
//  Created by Roman Khancha on 16.11.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var loginTF = ""
    @State private var passwordTF = ""
    @State private var showingDetail = false
    
    var body: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Pass Data Project")
                    .font(.largeTitle)
                Spacer()
                TextField("Login", text: $loginTF)
                    .frame(width: 300.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                    .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                SecureField("Password", text: $passwordTF)
                    .frame(width: 300.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                    .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                Spacer()
                Button("Send") {
                    self.showingDetail.toggle()
                }
                .fullScreenCover(isPresented: $showingDetail, content: {
                    SecondView()
                })
                .frame(width: 100)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
                .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .dynamicTypeSize(.accessibility1)
            .foregroundColor(.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

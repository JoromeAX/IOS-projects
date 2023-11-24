//
//  ContentView.swift
//  Words
//
//  Created by Roman Khancha on 21.11.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var bigWord = ""
    @State var player1 = ""
    @State var player2 = ""
    
    @State var isShowedGame = false
    @State var isAlertPresented = false
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            VStack {
                Spacer()
                TitleText(title: "Word Game", player: .player1)
                Spacer()
                TextFieldStyle(title: "Введите длинное слово", word: $bigWord)
                    .padding(20)
                TextFieldStyle(title: "Имя Игрока 1", word: $player1)
                    .padding(.horizontal, 20)
                TextFieldStyle(title: "Имя Игрока 2", word: $player2)
                    .padding(.horizontal, 20)
                Spacer()
                Button {
                    
                    if bigWord.count > 7 {
                        isShowedGame.toggle()
                    } else {
                        isAlertPresented.toggle()
                    }
                } label: {
                    TitleText(title: "Старт", player: .player1)
                        .cornerRadius(30)
                        .padding(20)
                }
                .alert("Слишком короткое слово", isPresented: $isAlertPresented, actions: {
                    Text("Ок")
                })
                .fullScreenCover(isPresented: $isShowedGame) {
                    
                    let nam1 = player1 == "" ? "Игрок 1" : player1
                    let nam2 = player2 == "" ? "Игрок 1" : player2
                    
                    let player1 = Player(name: nam1)
                    let player2 = Player(name: nam2)
                    
                    let gameViewModel = GameViewModel(player1: player1,
                                                      player2: player2,
                                                      word: bigWord)
                    
                    GameView(viewModel: gameViewModel)
                }
                Spacer()
            }
        }
        .dynamicTypeSize(.medium)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

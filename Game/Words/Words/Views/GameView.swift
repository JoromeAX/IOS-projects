//
//  GameView.swift
//  Words
//
//  Created by Roman Khancha on 22.11.2023.
//

import SwiftUI

struct GameView: View {
    
    @State private var word = ""
    var viewModel: GameViewModel
    @State private var confirmPresent = false
    @State private var isAlertPresent = false
    @State var alertText = ""
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            VStack(spacing: 16.0) {
                HStack() {
                    Button {
                        confirmPresent.toggle()
                    } label: {
                        Text("Выход")
                            .padding(6)
                            .padding(.horizontal)
                            .background(Color("Button"))
                            .cornerRadius(30)
                            .padding(6)
                            .foregroundColor(.white)
                            .font(.custom("CourierNewPS-BoldMT", size: 18))
                    }
                    Spacer()
                }
                
                Text(viewModel.word.capitalized)
                    .font(.custom("CourierNewPS-BoldMT", size: 30))
                    .foregroundColor(.white)
                HStack(spacing: 12.0) {
                    VStack {
                        Text("\(viewModel.player1.score)")
                            .font(.custom("CourierNewPS-BoldMT", size: 60))
                            .foregroundColor(.white)
                        Text(viewModel.player1.name)
                            .font(.custom("CourierNewPS-BoldMT", size: 24))
                            .foregroundColor(.white)
                    }
                    .padding(20)
                    .frame(width: screen.width / 2.2,
                           height: screen.width / 2.2)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(30)
                    .shadow(color: viewModel.isFirst ? .red : .clear,
                            radius: 4,
                            x: 0,
                            y: 0)
                    VStack {
                        Text("\(viewModel.player2.score)")
                            .font(.custom("CourierNewPS-BoldMT", size: 60))
                            .foregroundColor(.white)
                        Text(viewModel.player2.name)
                            .font(.custom("CourierNewPS-BoldMT", size: 24))
                            .foregroundColor(.white)
                    }
                    .padding(20)
                    .frame(width: screen.width / 2.2,
                           height: screen.width / 2.2)
                    .background(Color("SecondPlayer"))
                    .cornerRadius(30)
                    .shadow(color: viewModel.isFirst ? .clear : .blue,
                            radius: 4,
                            x: 0,
                            y: 0)
                }
                
                TextFieldStyle(title: "Ваше слово...", word: $word)
                    .padding(.horizontal)
                Button {
                    
                    var score = 0
                    
                    do {
                        try score = viewModel.check(word: word)
                    } catch WordError.beforeWord {
                        alertText = "Это слово уже было!"
                        isAlertPresent.toggle()
                    } catch WordError.littleWord {
                        alertText = "Слишком короткое слово!"
                        isAlertPresent.toggle()
                    } catch WordError.sameWord {
                        alertText = "Ты написал тоже слово что и начальное!"
                        isAlertPresent.toggle()
                    } catch WordError.wrongWord {
                        alertText = "Такое слово не может быть составленно!"
                        isAlertPresent.toggle()
                    } catch WordError.nonExistentWord {
                        alertText = "Такое слово не существует"
                        isAlertPresent.toggle()
                    } catch {
                        alertText = "Неизвестая ошибка"
                        isAlertPresent.toggle()
                    }
                    
                    if score > 1 {
                        self.word = ""
                    }
                } label: {
                    Text("Готово!")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(Color("Button"))
                        .cornerRadius(30)
                        .font(.custom("CourierNewPS-BoldMT", size: 40))
                        .padding(.horizontal)
                }
                if viewModel.words.count != 0 {
                    List {
                        ForEach(0 ..< self.viewModel.words.count, id: \.description) { item in
                            
                            WordCell(word: self.viewModel.words[item])
                                .listRowBackground(Color.black)
                                .background(item % 2 == 0 ? Color("FirstPlayer") : Color("SecondPlayer"))
                                .listRowInsets(EdgeInsets())
                        }
                    }
                    .listStyle(.plain)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Spacer()
                }
            }
            .confirmationDialog("Вы уверенны, что хотите завершить игру?",
                                isPresented: $confirmPresent, titleVisibility: .visible) {
                
                Button(role: .destructive) {
                    self.dismiss()
                } label: {
                    Text("Да")
                }
                
                Button(role: .cancel) { } label: {
                    Text("Нет")
                }
            }.alert(alertText, isPresented: $isAlertPresent) {
                Text("Ок")
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(player1: Player(name: "Roma"),
                                          player2: Player(name: "Anton"),
                                          word: "Регокносцировка"))
    }
}

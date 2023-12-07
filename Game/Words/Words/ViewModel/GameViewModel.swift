//
//  GameViewModel.swift
//  Words
//
//  Created by Roman Khancha on 23.11.2023.
//

import Foundation
import UIKit

enum WordError: Error {
    case sameWord
    case beforeWord
    case littleWord
    case wrongWord
    case nonExistentWord
}

class GameViewModel: ObservableObject {
    
    @Published var player1: Player
    @Published var player2: Player
    @Published var words = [String]()
    let word: String
    var isFirst = true
    
    init(player1: Player, player2: Player, word: String) {
        self.player1 = player1
        self.player2 = player2
        self.word = word.lowercased()
    }
    
    func isWordCorrect(word: String) -> Bool {
        
        let textCheck = UITextChecker()
        let checkRange = NSMakeRange(0, word.count)
        let stringRange = textCheck.rangeOfMisspelledWord(in: word, range: checkRange, startingAt: 0, wrap:
        false, language: "ru")
        return stringRange.location == NSNotFound
    }
    
    func validate(word: String) throws {
        
        let word = word.lowercased()
        guard isWordCorrect(word: word) else {
            print("Такое слово не существует")
            throw WordError.nonExistentWord
        }
        
        guard word != self.word else {
            print("Ты написал тоже слово что и начальное!")
            throw WordError.sameWord
        }
        
        guard !(words.contains(word)) else {
            print("Это слово уже было!")
            throw WordError.beforeWord
        }
        
        guard word.count > 1 else {
            print("Слишком короткое слово!")
            throw WordError.littleWord
        }
        
        return
    }
    
    func wordToCharts(word: String) -> [Character] {
        
        var chars = [Character]()
        
        for char in word.lowercased() {
            chars.append(char)
        }
        
        return chars
    }
    
    func check(word: String) throws -> Int {
        
        do {
            try self.validate(word: word)
        } catch {
            throw error
        }
        
        var bigWordArray = wordToCharts(word: self.word)
        let smallWordArray = wordToCharts(word: word)
        var result = ""
        
        for char in smallWordArray {
            if bigWordArray.contains(char) {
                result.append(char)
                var i = 0
                while bigWordArray[i] != char {
                    i += 1
                }
                bigWordArray.remove(at: i)
            } else {
                throw WordError.wrongWord
            }
        }
        
        guard result == word.lowercased() else { return 0 }
        
        words.append(result)
        
        if isFirst {
            player1.add(score: result.count)
            print("Player 1 \(player1.score)")
        } else {
            player2.add(score: result.count)
            print("Player 2 \(player2.score)")
        }
        
        isFirst.toggle()
        
        return result.count
    }
}

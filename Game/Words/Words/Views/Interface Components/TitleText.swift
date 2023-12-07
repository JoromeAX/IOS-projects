//
//  TitleText.swift
//  Words
//
//  Created by Roman Khancha on 22.11.2023.
//

import SwiftUI

enum PlayerSide {
    case player1
    case player2
}

struct TitleText: View {
    
    var title: String
    var player: PlayerSide
    
    var body: some View {
        
        let text = Text(title)
            .font(.custom("CourierNewPS-BoldMT", size: 60))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
        
        switch player {
        case .player1:
            text.background(Color("FirstPlayer"))
        case .player2:
            text.background(Color("FirstPlayer"))
        }
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        TitleText(title: "", player: .player1)
    }
}

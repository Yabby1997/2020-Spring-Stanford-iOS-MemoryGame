//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by yabby on 2020/06/22.
//  Copyright © 2020 yabby. All rights reserved.
//

//viewmodel이라 swiftUI도 필요
import SwiftUI

//프로토콜을 지정해주어야 reactive하게 작동한다.
class EmojiMemoryGame: ObservableObject{
    //모델이 변화하면 Publish한다고 명시
    @Published private var model : MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String>{
        var emojis : Array<String> = ["👻", "🎃", "🕷", "🤡", "💀", "😈", "👿", "🤖", "👾", "☠️", "👽", "💩"]
        emojis.shuffle()
        print(emojis)
        return MemoryGame<String>(numberOfPairsOfCards : Int.random(in: 2 ..< 6)) {
            pairIndex in return emojis[pairIndex]
        }
    }
    
    //MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card>{          //멤버변수인 cards에 접근하면 model.cards를 반환해준다. private이기 떄문에 직접접근은 못함.
        model.cards
    }
    
    //MARK: - Intent(S)
    
    func choose(card : MemoryGame<String>.Card){         //멤버함수인 choose를 통해 model.choose를 수행한다. private이기 때문에 직접접근은 못함.
        //objectWillChange.send()                           //objet가 변할것이라고 알린다
        model.choose(card: card)
    }
}

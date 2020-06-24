//
//  MemoryGame.swift
//  Memorize
//
//  Created by yabby on 2020/06/22.
//  Copyright © 2020 yabby. All rights reserved.
//

//Model
import Foundation

struct MemoryGame<CardContent>{
    var cards : Array<Card>
    
    mutating func choose(card: Card){                                        //struct는 value이므로 copy된다. 그렇기때문에 인자로 받으면 copy를 받게되는것.
        print("card chosen : \(card)")                             //값을 바꾸게되면 그 때 copy한다. 스스로를 변형시키는 함수는 mutating 키워드가 붙어야함.
        let chosenIndex: Int = self.index(of: card)
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
    }
    
    //external/internal name을 사용함으로써 부르는쪽/불리는쪽에서 모두 가독성이 좋아진다.
    func index(of card: Card) -> Int{
        for index in 0..<self.cards.count {
            if self.cards[index].id == card.id{
                return index
            }
        }
        return 0 // TODO: bogus!!
    }
    
    //init은 기본적으로 mutating이다.
    init(numberOfPairsOfCards : Int, cardContentFactory: (Int) -> CardContent){
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id : pairIndex * 2))
            cards.append(Card(content: content, id : pairIndex * 2 + 1))
            cards.shuffle()
        }
    }
    
    struct Card : Identifiable{
        var isFaceUp : Bool = false
        var isMatched : Bool = false
        var content : CardContent
        var id : Int
    }
}

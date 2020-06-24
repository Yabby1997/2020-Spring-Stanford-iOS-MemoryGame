//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by yabby on 2020/06/22.
//  Copyright © 2020 yabby. All rights reserved.
//

//View. UI를 담당한다. 
import SwiftUI

//objectWillChange.send()가 호출될 때 마다 새롭게 업데이트 해주어야한다. 변화하는 카드만 업데이트 해주면 된다.
struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel : EmojiMemoryGame
    
    var body: some View {
        HStack(){
            ForEach(viewModel.cards){ card in
                CardView(card : card).onTapGesture{
                    self.viewModel.choose(card: card)
                }
            }
        }
        //modify not declare
        .padding()
        .foregroundColor(Color.orange)
    }
}

struct CardView : View{
    var card : MemoryGame<String>.Card
    
    var body: some View{
        //부모에 따라 유동적으로 작동한다.
        GeometryReader(content: { geometry in
            self.body(for : geometry.size)
        })
    }
    
    //size를 받았으므로 geometry.size -> size로 변경, self.도 제거할 수 있음.
    func body(for size : CGSize) -> some View{
        ZStack(){
            if card.isFaceUp{
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth : edgeLineWidth)
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                Text(self.card.content)
            }
            else{
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
        .font(Font.system(size: fontSize(for: size)))
        .aspectRatio(2/3, contentMode: .fit)
    }
    
    func fontSize(for size : CGSize) -> CGFloat{
        return min(size.width, size.height) * fontScalerFactor
    }

    // MARK: - Drawing Constants
    // 숫자들을 직접쓰는거보단 var이나 let으로 만들어두는것이 더 좋은 코딩스타일이다.
    let cornerRadius : CGFloat = 10.0
    let edgeLineWidth : CGFloat = 3
    let fontScalerFactor : CGFloat = 0.75
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel : EmojiMemoryGame())
    }
}

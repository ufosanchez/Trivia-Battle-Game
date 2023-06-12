//
//  LifeBar.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-05-24.
//

import SwiftUI

struct LifeBar: View {
    
    var color : Color = Color.red
    var width : CGFloat = 50
    var type_bar : String = "healt"
//    var amountAttack : Int
    
    var body: some View {
        
        HStack (){
            if(type_bar == "healt"){
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.red)
            }
            else{
                Image(systemName: "flame.fill")
                    .padding(.horizontal, 2.5)
                    .foregroundColor(Color.green)
            }
            
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .frame(width: 200, height: 20)
                    .foregroundColor(Color.black)
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .frame(width: Percentage(), height: 20)
                    .foregroundColor(color)
                
                if(type_bar == "healt"){
                    Text("HEALTH : \(String(format: "%.0f", self.width))")
                        .foregroundColor(Color.white)
                        .font(.custom("NerkoOne-Regular", size: 17))
                        .padding(.leading, 15)
                        .offset(y: -4)
                }
                else{
                    Text("DAMAGE : \(String(format: "%.0f", self.width))")
                        .foregroundColor(Color.white)
                        .font(.custom("NerkoOne-Regular", size: 17))
                        .padding(.leading, 15)
                        .offset(y: -4)
                }

            }
        }
        
    }
    func Percentage() -> CGFloat{
        if(self.type_bar == "healt"){
            return (width*200)/6400
        }
        return (width*200)/640
    }
}

struct LifeBar_Previews: PreviewProvider {
    static var previews: some View {
        LifeBar()
    }
}



//
//  DetailHero.swift
//  Model3D
//
//  Created by Arnulfo Sánchez on 2023-05-24.
//

import SwiftUI

struct DetailHero: View {
    
    let selectedHero : Hero
    var body: some View {
        
        let percentage = (CGFloat(selectedHero.healt)*200)/100
        
        ScrollView{
            
                VStack{
                    Text(selectedHero.name)
                        .bold()
                        .font(.system(size: 30))
                    
                    ZStack{
                        Gif_Hero(selectedHero.name.lowercased())
                            .frame(width: 15000, height: 220)
                        
                        VStack{
                            Bar(color: Color.red, width: CGFloat(selectedHero.healt), type_bar: "healt")
                            Bar(color: Color.green, width: CGFloat(selectedHero.attack), type_bar: "attack")
                        }
                        .frame(maxWidth: UIScreen.screenWidth, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.trailing, 50)
                        .padding(.top, 10)
                        
                        VStack{
                            Text("Type of Damage : \n\(selectedHero.dam_type)\n\nAbility : \n\(selectedHero.ability)")
                                .frame(width: 250, alignment: .leading)
                        }
                        .frame(maxWidth: UIScreen.screenWidth - 100, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.leading, 50)
                        .padding(.top, 10)
                    }
                    
                    Text("Description:")
                    Text(selectedHero.description)
                        .bold()
                        .frame(maxWidth: UIScreen.screenWidth - 100)
//                        .padding(.leading, 100)
                }
            
        }// List ends
        .navigationBarTitle("Details Champions")
        .listStyle(PlainListStyle())
        .background(LinearGradient( colors: [.red, .yellow], startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all))
        .scrollContentBackground(.hidden)
        
        
    }
}

//struct DetailHero_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailHero()
//    }
//}

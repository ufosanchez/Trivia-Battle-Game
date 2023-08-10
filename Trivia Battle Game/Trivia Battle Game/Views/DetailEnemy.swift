//
//  DetailEnemy.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-05-24.
//

import SwiftUI

struct DetailEnemy: View {
    
    let selectedEnemy : Enemy
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        ScrollView{
            
                VStack{
                    Text(selectedEnemy.name)
                        .bold()
                        .font(.custom("NerkoOne-Regular", size: 30))
                        .foregroundColor(.black)
                    
                    ZStack{
                        GifEnemy(selectedEnemy.name.lowercased())
                            .frame(width: 15000, height: 220)
                        
                        VStack{
                            LifeBar(color: Color.red, width: CGFloat(selectedEnemy.healt), type_bar: "healt")
                            LifeBar(color: Color.green, width: CGFloat(selectedEnemy.attack), type_bar: "attack")
                            
                            HStack(spacing: 10){
                                ForEach(selectedEnemy.typePokemon) { string in
                                    Image(string.nameType)
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                }
                            }
                            .padding(.top, 40)
                        }
                        .frame(maxWidth: UIScreen.screenWidth, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.trailing, 50)
                        .padding(.top, 10)
                        
                        VStack{
                            Text("Type of Damage : \n\(selectedEnemy.dam_type)\n\nAbility : \n\(selectedEnemy.ability)")
                                .frame(width: 250, alignment: .leading)
                                .font(.custom("NerkoOne-Regular", size: 18))
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: UIScreen.screenWidth, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.leading, 140)
                        .padding(.top, 10)
                    }
                    
                    Text("Description :")
                        .font(.custom("NerkoOne-Regular", size: 25))
                        .foregroundColor(.black)
                    Text(selectedEnemy.description)
                        .font(.custom("NerkoOne-Regular", size: 20))
                        .frame(maxWidth: UIScreen.screenWidth - 100)
                        .foregroundColor(.black)
//                        .padding(.leading, 100)
                }
            
        }// List ends
//        .navigationBarTitle("Details Champions")
        .listStyle(PlainListStyle())
        .background(LinearGradient( colors: [.red, .yellow], startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all))
        .scrollContentBackground(.hidden)
        
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Back  ")
                    }
                    .padding(5)
                    .foregroundColor(Color.white)
                    .background(Color.black.cornerRadius(25))
                }
            }
        }
    }
}

//struct DetailEnemy_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailEnemy()
//    }
//}

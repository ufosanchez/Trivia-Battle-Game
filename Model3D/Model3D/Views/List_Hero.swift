//
//  List_Hero.swift
//  Model3D
//
//  Created by Arnulfo Sánchez on 2023-05-23.
//

import SwiftUI

struct List_Hero: View {
    
    @State private var linkSelection : Int? = nil
    @State private var heroList = [Hero]()
    @State private var navigationHero : Hero = Hero()
    
    var body: some View {
        NavigationView{
            VStack{
                //                ZStack{
                
                NavigationLink(destination: ContentView(), tag: 1, selection: self.$linkSelection){}
                NavigationLink(destination: Equipment(), tag: 2, selection: self.$linkSelection){}
                NavigationLink(destination: DetailHero(selectedHero: navigationHero), tag: 3, selection: self.$linkSelection){}
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack{
                        ForEach(heroList) { currentHero in
                            VStack{
                                
                                Text(currentHero.name)
                                    .bold()
                                    .font(.system(size: 30))
                                
                                //                                    if(currentHero.name == "Lugia" || currentHero.name == "Dialga" || currentHero.name == "Charizard"){
                                //                                        Gif_Hero(currentHero.name.lowercased())
                                //                                            .frame(width: 12000)
                                //                                    }
                                //                                    else{
                                //                                        Gif_Hero(currentHero.name.lowercased())
                                //                                            .frame(width: 15000)
                                //                                    }
                                ZStack{
                                    Gif_Hero(currentHero.name.lowercased())
                                        .frame(width: 12000)
                                    
                                    VStack(spacing: 10){
                                        ForEach(currentHero.typePokemon) { string in
                                            Image(string.nameType)
                                                .resizable()
                                                .frame(width: 32, height: 32)
                                        }
                                    }
                                    .frame(maxWidth: (UIScreen.screenWidth)/3, alignment: .leading)
                                    .padding(.leading, 50)
                                }
                                
                                Bar(color: Color.red, width: CGFloat(currentHero.healt), type_bar: "healt")
                                Bar(color: Color.green, width: CGFloat(currentHero.attack), type_bar: "attack")
                                
                                HStack(spacing: 50){
                                    Button(action:{
                                        self.linkSelection = 2
                                    }){
                                        Text("Choose")
                                            .bold()
                                            .foregroundColor(.white)
                                            .padding(.vertical, 5)
                                            .padding(.horizontal, 10)
                                            .background(Capsule().stroke(Color.white, lineWidth: 2))
                                    }
                                    
                                    Button(action:{
                                        print("\(currentHero.name) selected")
                                        //                                        NavigationLink(destination: DetailHero(selectedHero: currentHero)){}
                                        navigationHero = currentHero
                                        self.linkSelection = 3
                                    }){
                                        Text("Details")
                                            .bold()
                                            .foregroundColor(.white)
                                            .padding(.vertical, 5)
                                            .padding(.horizontal, 10)
                                            .background(Capsule().stroke(Color.white, lineWidth: 2))
                                    }
                                }
                                .padding(.bottom, 5)
                            }// VStack ends
                            .frame(width: (UIScreen.screenWidth)/3)
                            .background(
                                Color.white.opacity(0.2)
                                    .cornerRadius(25)
                            )
                            .padding(.horizontal, 7)
                        }// ForEach ends
                    }// LazyHStack ends
                }// ScrollView ends
                //                }// ZStack ends
                
                                Button(action:{
                                    self.linkSelection = 1
                                }){
                                    Text("Play Now")
                                    // some chnages added
                                    //THANK YOU
                                }
                //
                //                Button(action:{
                //                    self.linkSelection = 2
                //                }){
                //                    Text("Equipment")
                //                }
            }// VStack ends
            .navigationBarTitle("Champions")
            .background(LinearGradient( colors: [.red, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all))
//                .ignoresSafeArea())
                
        }// NavigationView ends
        .onAppear(perform: {
            self.loadInitialData()
        })
        .navigationViewStyle(StackNavigationViewStyle())
    }// body ends
    
    private func loadInitialData(){
        var heroObj = Hero(name: "Zapdos", description: """
        Zapdos (Japanese: サンダー Thunder) is a dual-type Electric/Flying Legendary Pokémon introduced in Generation I.
        It is not known to evolve into or from any other Pokémon.
        In Galar, Zapdos has a dual-type Fighting/Flying regional form, introduced in The Crown Tundra expansion of the Pokémon Sword and Shield Expansion Pass.
        Along with Articuno and Moltres, it is one of the three Legendary birds of Kanto.
        """, healt: 10, attack: 10, dam_type: "Electric/Flying Legendary Pokémon", ability: "Lightning Rod", typePokemon: [TypePokemon(nameType: "Fire"), TypePokemon(nameType: "Flying")])
        self.heroList.append(heroObj)
        
        heroObj = Hero(name: "Venusaur", description: """
        Venusaur (Japanese: フシギバナ Fushigibana) is a dual-type Grass/Poison Pokémon introduced in Generation I.
        It evolves from Ivysaur starting at level 32. It is the final form of Bulbasaur.
        Venusaur has two other forms.
            \u{2022} It can Mega Evolve into Mega Venusaur using the Venusaurite.
            \u{2022} It can Gigantamax into Gigantamax Venusaur if it has the Gigantamax Factor for its Gigantamax form that was introduced in The Isle of Armor.
        Venusaur is the game mascot of Pokémon Green and its remake Pokémon LeafGreen, appearing on the box art of both games.
        """, healt: 10, attack: 10, dam_type: "Grass/Poison Pokémon", ability: "Overgrow", typePokemon: [TypePokemon(nameType: "Grass"), TypePokemon(nameType: "Poison")])
        self.heroList.append(heroObj)
        
        heroObj = Hero(name: "Suicune", description: """
        Suicune (Japanese: スイクン Suicune) is a Water-type Legendary Pokémon introduced in Generation II.
        It is not known to evolve into or from any other Pokémon.
        Along with Raikou and Entei, it is one of the Legendary beasts resurrected by Ho-Oh after the burning of the Brass Tower. Of the three Legendary beasts, Suicune is said to represent the rains that quenched the flames of the burning Brass Tower.
        Suicune is the game mascot of Pokémon Crystal, appearing on the boxart.
        It appears to be distantly related to the Paradox Pokémon Walking Wake.
        Suicune is pursued in the anime, Pokémon Adventures, Pokémon Crystal, and Pokémon HeartGold and SoulSilver by Eusine.
        """, healt: 10, attack: 10, dam_type: "Water-type Legendary Pokémon", ability: "Water Absorb", typePokemon: [TypePokemon(nameType: "Water")])
        self.heroList.append(heroObj)
        
        heroObj = Hero(name: "Raikou", description: """
        Raikou (Japanese: ライコウ Raikou) is an Electric-type Legendary Pokémon introduced in Generation II.
        It is not known to evolve into or from any other Pokémon.
        Along with Entei and Suicune, it is one of the Legendary beasts resurrected by Ho-Oh after the burning of the Brass Tower. Of the three Legendary beasts, Raikou is said to represent the lightning strike which ignited the fire that consumed the Brass Tower.
        """, healt: 10, attack: 10, dam_type: " Electric-type Legendary Pokémon", ability: "Volt Absorb", typePokemon: [TypePokemon(nameType: "Electric")])
        self.heroList.append(heroObj)
        
        heroObj = Hero(name: "Mewtwo", description: """
        Mewtwo (Japanese: ミュウツー Mewtwo) is a Psychic-type Legendary Pokémon introduced in Generation I.
        While it is not known to evolve into or from any other Pokémon, Mewtwo can Mega Evolve into two different forms:
            \u{2022} Mega Mewtwo X using Mewtwonite X.
            \u{2022} Mega Mewtwo Y using Mewtwonite Y.
        It is a member of the Mew duo along with Mew.
        """, healt: 10, attack: 10, dam_type: "Psychic-type Legendary Pokémon", ability: "Insomnia", typePokemon: [TypePokemon(nameType: "Psychic")])
        self.heroList.append(heroObj)
        
        heroObj = Hero(name: "Machamp", description: """
        Machamp (Japanese: カイリキー Kairiky) is a Fighting-type Pokémon introduced in Generation I.
        It evolves from Machoke when traded or when exposed to a Linking CordLA. It is the final form of Machop.
        Machamp can Gigantamax into Gigantamax Machamp if it has the Gigantamax Factor for its Gigantamax form.
        """, healt: 10, attack: 10, dam_type: "Fighting-type Pokémon", ability: "Steadfast", typePokemon: [TypePokemon(nameType: "Fighting")])
        self.heroList.append(heroObj)
        
        heroObj = Hero(name: "Lugia", description: """
        Lugia (Japanese: ルギア Lugia) is a dual-type Psychic/Flying Legendary Pokémon introduced in Generation II.
        It is not known to evolve into or from any other Pokémon.
        Lugia is the game mascot of Pokémon Silver, its remake Pokémon SoulSilver, and Pokémon XD: Gale of Darkness (as Shadow Lugia), appearing on the boxart of them all.
        Along with Ho-Oh, it is part of the tower duo. It is also the trio master of the Legendary birds.
        In Pokémon XD, Shadow Lugia, codenamed XD001, is a main part of the storyline, and Cipher's ultimate Shadow Pokémon.
        """, healt: 10, attack: 10, dam_type: "Psychic/Flying Legendary Pokémon", ability: "Multiscale", typePokemon: [TypePokemon(nameType: "Psychic"), TypePokemon(nameType: "Flying")])
        self.heroList.append(heroObj)
        
        heroObj = Hero(name: "Latios", description: """
        Latios (Japanese: ラティオス Latios) is a dual-type Dragon/Psychic Legendary Pokémon introduced in Generation III.
        While it is not known to evolve into or from any other Pokémon, Latios can Mega Evolve into Mega Latios using the Latiosite.
        It is a member of the eon duo along with Latias.
        """, healt: 10, attack: 10, dam_type: "Dragon/Psychic Legendary", ability: "Levitate", typePokemon: [TypePokemon(nameType: "Dragon"), TypePokemon(nameType: "Psychic")])
        self.heroList.append(heroObj)
        
        heroObj = Hero(name: "Latias", description: """
        Latias (Japanese: ラティアス Latias) is a dual-type Dragon/Psychic Legendary Pokémon introduced in Generation III.
        While it is not known to evolve into or from any other Pokémon, Latias can Mega Evolve into Mega Latias using the Latiasite.
        It is a member of the eon duo along with Latios.
        """, healt: 10, attack: 10, dam_type: "Dragon/Psychic Legendary Pokémon", ability: "Levitate", typePokemon: [TypePokemon(nameType: "Dragon"), TypePokemon(nameType: "Psychic")])
        self.heroList.append(heroObj)
        
        heroObj = Hero(name: "Gyarados", description: """
        Gyarados (Japanese: ギャラドス Gyarados) is a dual-type Water/Flying Pokémon introduced in Generation I.
        It evolves from Magikarp starting at level 20.
        Gyarados can Mega Evolve into Mega Gyarados using the Gyaradosite.
        """, healt: 10, attack: 10, dam_type: "Water/Flying Pokémon", ability: "Mold Breaker", typePokemon: [TypePokemon(nameType: "Water"), TypePokemon(nameType: "Flying")])
        self.heroList.append(heroObj)
        
        heroObj = Hero(name: "Greninja", description: """
        Greninja (Japanese: ゲッコウガ Gekkouga) is a dual-type Water/Dark Pokémon introduced in Generation VI.
        It evolves from Frogadier starting at level 36. It is the final form of Froakie.
        In Generation VII, Greninja with the Ability Battle Bond can transform into a special form known as Ash-Greninja after defeating an opponent during battle.
            \u{2022} Greninja with Battle Bond is a distinct form, and is unable to breed as it belongs to the No Eggs Discovered Egg Group, and alternate forms of Froakie and Frogadier with Battle Bond do not exist.
        In Pokémon Scarlet and Violet, Battle Bond's effect was altered to only increase Greninja's stats when defeating an opponent, and Ash-Greninja no longer exists.
        """, healt: 10, attack: 10, dam_type: "Water/Dark Pokémon", ability: "Battle Bond", typePokemon: [TypePokemon(nameType: "Water"), TypePokemon(nameType: "Dark")])
        self.heroList.append(heroObj)
        
        heroObj = Hero(name: "Entei", description: """
        Entei (Japanese: エンテイ Entei) is a Fire-type Legendary Pokémon introduced in Generation II.
        It is not known to evolve into or from any other Pokémon.
        Along with Raikou and Suicune, it is one of the Legendary beasts said to be resurrected by Ho-Oh after the burning of the Brass Tower. Out of the three beasts, Entei is said to represent the flames that burned the Brass Tower.
        """, healt: 10, attack: 10, dam_type: "Fire-type Legendary Pokémon", ability: "Flash Fire", typePokemon: [TypePokemon(nameType: "Fire")])
        self.heroList.append(heroObj)
        
        heroObj = Hero(name: "Dialga", description: """
        Dialga (Japanese: ディアルガ Dialga) is a dual-type Steel/Dragon Legendary Pokémon introduced in Generation IV.
        While it is not known to evolve into or from any other Pokémon, Dialga transforms into a second form, called its Origin Forme, while holding an Adamant Crystal.
        Dialga is the game mascot of Pokémon Diamond and its remake Pokémon Brilliant Diamond, appearing on the box art of both games in its standard form.
        Along with Palkia and Giratina, it is a member of the creation trio of Sinnoh, representing time. In the past, it was worshipped by the Diamond Clan under the name "almighty Sinnoh" (Japanese: シンオウさま Shin'ou-sama).
        """, healt: 10, attack: 10, dam_type: "Steel/Dragon Legendary Pokémon", ability: "Telepathy", typePokemon: [TypePokemon(nameType: "Steel"), TypePokemon(nameType: "Dragon")])
        self.heroList.append(heroObj)
        
        heroObj = Hero(name: "Charizard", description: """
        Charizard (Japanese: リザードン Lizardon) is a dual-type Fire/Flying Pokémon introduced in Generation I.
        It evolves from Charmeleon starting at level 36. It is the final form of Charmander.
        Charizard has three other forms.
        It can Mega Evolve into two forms:
            \u{2022} Mega Charizard X using the Charizardite X.
            \u{2022} Mega Charizard Y using the Charizardite Y.
        It can Gigantamax into Gigantamax Charizard if it has the Gigantamax Factor for its Gigantamax form.
        Charizard is the game mascot of Pokémon Red and its remake Pokémon FireRed, appearing on the box art of both games.
        """, healt: 10, attack: 10, dam_type: "Fire/Flying Pokémon", ability: "Solar Power", typePokemon: [TypePokemon(nameType: "Fire"), TypePokemon(nameType: "Flying")])
        self.heroList.append(heroObj)
        
        heroObj = Hero(name: "Blastoise", description: """
        Blastoise (Japanese: カメックス Kamex) is a Water-type Pokémon introduced in Generation I.
        It evolves from Wartortle starting at level 36. It is the final form of Squirtle.
        Blastoise has two other forms.
            \u{2022} It can Mega Evolve into Mega Blastoise using the Blastoisinite.
            \u{2022} It can Gigantamax into Gigantamax Blastoise if it has the Gigantamax Factor for its Gigantamax form that was introduced in The Isle of Armor.
        Blastoise is the game mascot of the Japanese and international versions of Pokémon Blue, appearing on the boxart of both games.
        """, healt: 10, attack: 10, dam_type: "Water-type Pokémon", ability: "Mega Launcher", typePokemon: [TypePokemon(nameType: "Water")])
        self.heroList.append(heroObj)
        
        heroObj = Hero(name: "Arceus", description: """
        Arceus (Japanese: アルセウス Arceus) is a Normal-type Mythical Pokémon introduced in Generation IV.
        While it is not known to evolve into or from any other Pokémon, Arceus will change type when it is holding a Plate or type-specific Z-Crystal.
        Arceus is known as "The Original One", as it is said that it created Sinnoh and Ransei, and possibly the entire Pokémon universe, along with the lake guardians and creation trio.
        It is the trio master of both the lake guardians and the creation trio.
        Arceus is featured prominently in Pokémon Legends: Arceus and plays a major role in its plot.
        """, healt: 10, attack: 10, dam_type: "Normal-type Mythical Pokémon", ability: "Multitype", typePokemon: [TypePokemon(nameType: "Normal")])
        self.heroList.append(heroObj)
        
    }
}// Lis_Hero ends

struct List_Hero_Previews: PreviewProvider {
    static var previews: some View {
        List_Hero()
    }
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

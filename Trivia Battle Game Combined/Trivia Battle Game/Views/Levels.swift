//
//  Levels.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-05-23.
//

import SwiftUI

struct Levels: View {
    
    @State private var linkSelection : Int? = nil
    @State private var enemyList = [Enemy]()
    @State private var navigationEnemy : Enemy = Enemy()
    @State private var currentUserLevel : Int = 50
    
    var singleton = Singleton.shared
    
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    @State private var modelList : [String] = ["Widowmaker", "JunkerQueen", "Tracer", "Doomfist"]
    @State private var baseList : [[Int]] = [[300, 100], [100, 300], [200, 200], [150, 250]]
    
    var body: some View {
//        NavigationView{
            VStack{
                //                ZStack{
                
                NavigationLink(destination: GameView(selectedEnemy: navigationEnemy).environmentObject(fireDBHelper), tag: 1, selection: self.$linkSelection){}
                NavigationLink(destination: DetailEnemy(selectedEnemy: navigationEnemy), tag: 2, selection: self.$linkSelection){}
                
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack{
                        ForEach(enemyList) { currentEnemy in
                            VStack{
                                
                                Text("Level : \(currentEnemy.level) - \(currentEnemy.name)")
                                    .bold()
//                                    .font(.system(size: 26))
                                    .font(.custom("NerkoOne-Regular", size: 25))
                                
                                ZStack{
                                    GifEnemy(currentEnemy.name.lowercased())
                                        .frame(width: 10500)
                                    
                                    VStack(spacing: 10){
                                        ForEach(currentEnemy.typePokemon) { string in
                                            Image(string.nameType)
                                                .resizable()
                                                .frame(width: 32, height: 32)
                                        }
                                    }
                                    .frame(maxWidth: (UIScreen.screenWidth)/3, alignment: .leading)
                                    .padding(.leading, 50)
                                    
//                                    Image(systemName: checkLevel(currentEnemy: currentEnemy) ? "" : "lock")
//                                        .resizable()
//                                        .frame(width: 60, height: 70)
                                    
                                }
                                
                                LifeBar(color: Color.red, width: CGFloat(currentEnemy.healt), type_bar: "healt")
                                LifeBar(color: Color.green, width: CGFloat(currentEnemy.attack), type_bar: "attack")
                                
                                HStack(spacing: 50){
                                    Button(action:{
                                        if(self.fireDBHelper.user.db_Level >= currentEnemy.level){
                                            self.linkSelection = 1
                                            navigationEnemy = currentEnemy
                                            singleton.enemySingleton = currentEnemy
                                            print("el singletonn 1 - \(singleton.enemySingleton.name)")
                                        }
                                    }){
                                        
                                        if(self.fireDBHelper.user.db_Level >= currentEnemy.level){
                                            Text("Play Now")
                                                .bold()
                                                .foregroundColor(.white)
                                                .padding(.vertical, 5)
                                                .padding(.horizontal, 10)
                                                .background(Capsule().stroke(Color.white, lineWidth: 2))
                                        } else {
                                            Text("No reached")
                                                .bold()
                                                .foregroundColor(.black)
                                                .padding(.vertical, 5)
                                                .padding(.horizontal, 10)
                                                .background(Capsule().stroke(Color.black, lineWidth: 2))
                                        }
                                    }
                                    .disabled(self.fireDBHelper.user.db_Level < currentEnemy.level ? true : false)
                                    
                                    Button(action:{
                                        print("\(currentEnemy.name) selected")
                                        navigationEnemy = currentEnemy
                                        self.linkSelection = 2
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
                                Color.white.opacity(0.2).cornerRadius(25)
                            )
                            .overlay((self.fireDBHelper.user.db_Level < currentEnemy.level) ? (RoundedRectangle(cornerRadius: 25).allowsHitTesting(false).frame(width: (UIScreen.screenWidth)/3)) .foregroundColor(Color.white.opacity(0.7)) : (RoundedRectangle(cornerRadius: 25).allowsHitTesting(false).frame(width: (UIScreen.screenWidth)/3)) .foregroundColor(Color.white.opacity(0.0)))
                            .overlay(
                                Image(systemName: checkLevel(currentEnemy: currentEnemy) ? "" : "lock")
                                    .resizable()
                                    .frame(width: 60, height: 70))
                            .padding(.horizontal, 7)
                        }// ForEach ends
                    }// LazyHStack ends
                }// ScrollView ends
                //                }// ZStack ends
                
            }// VStack ends
//            .navigationBarTitle("Champions")
            .background(LinearGradient( colors: [.red, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all))
//                .ignoresSafeArea())
//        }// NavigationView ends
        .onAppear(perform: {
            self.fireDBHelper.getProfile()
            
            singleton.heroSingleton = modelList[self.fireDBHelper.selectedIndex]
            singleton.attackChampion = self.baseList[self.fireDBHelper.selectedIndex][0] + (self.fireDBHelper.equipments.eWeapon * 10)
            singleton.healtChampion = self.baseList[self.fireDBHelper.selectedIndex][1] + (self.fireDBHelper.equipments.eHelmet * 50) + (self.fireDBHelper.equipments.eArmor * 50) + (self.fireDBHelper.equipments.eLegs * 50) + (self.fireDBHelper.equipments.eBoots * 50)
            
            print("champion number is \(self.fireDBHelper.selectedIndex)")
            print("champion name is \(singleton.heroSingleton)")
            print("champion attack is \(singleton.attackChampion)")
            print("champion healt is \( singleton.healtChampion)")
            
            
            
//            self.currentUserLevel = self.fireDBHelper.user.db_Level
            
            if(!singleton.loadData){
                self.loadInitialData()
                singleton.loadData = true
            }
        })
        .navigationViewStyle(StackNavigationViewStyle())
    }// body ends
    
    func checkLevel(currentEnemy : Enemy) -> Bool{
        if (self.self.fireDBHelper.user.db_Level >= currentEnemy.level){
            return true
        }
        return false
    }
    
    private func loadInitialData(){
        var enemyObj = Enemy(level: 1, name: "Zapdos", description: """
        Zapdos (Japanese: サンダー Thunder) is a dual-type Electric/Flying Legendary Pokémon introduced in Generation I.
        It is not known to evolve into or from any other Pokémon.
        In Galar, Zapdos has a dual-type Fighting/Flying regional form, introduced in The Crown Tundra expansion of the Pokémon Sword and Shield Expansion Pass.
        Along with Articuno and Moltres, it is one of the three Legendary birds of Kanto.
        """, healt: 1000, attack: 100, dam_type: "Electric/Flying Legendary Pokémon", ability: "Lightning Rod", typePokemon: [TypePokemon(nameType: "Fire"), TypePokemon(nameType: "Flying")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 2, name: "Charizard", description: """
        Charizard (Japanese: リザードン Lizardon) is a dual-type Fire/Flying Pokémon introduced in Generation I.
        It evolves from Charmeleon starting at level 36. It is the final form of Charmander.
        Charizard has three other forms.
        It can Mega Evolve into two forms :
            - Mega Charizard X using the Charizardite X.
            - Mega Charizard Y using the Charizardite Y.
        It can Gigantamax into Gigantamax Charizard if it has the Gigantamax Factor for its Gigantamax form.
        Charizard is the game mascot of Pokémon Red and its remake Pokémon FireRed, appearing on the box art of both games.
        """, healt: 1200, attack: 120, dam_type: "Fire/Flying Pokémon", ability: "Solar Power", typePokemon: [TypePokemon(nameType: "Fire"), TypePokemon(nameType: "Flying")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 3, name: "Venusaur", description: """
        Venusaur (Japanese: フシギバナ Fushigibana) is a dual-type Grass/Poison Pokémon introduced in Generation I.
        It evolves from Ivysaur starting at level 32. It is the final form of Bulbasaur.
        Venusaur has two other forms :
            - It can Mega Evolve into Mega Venusaur using the Venusaurite.
            - It can Gigantamax into Gigantamax Venusaur if it has the Gigantamax Factor for its Gigantamax form that was introduced in The Isle of Armor.
        Venusaur is the game mascot of Pokémon Green and its remake Pokémon LeafGreen, appearing on the box art of both games.
        """, healt: 1400, attack: 140, dam_type: "Grass/Poison Pokémon", ability: "Overgrow", typePokemon: [TypePokemon(nameType: "Grass"), TypePokemon(nameType: "Poison")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 4, name: "Blastoise", description: """
        Blastoise (Japanese: カメックス Kamex) is a Water-type Pokémon introduced in Generation I.
        It evolves from Wartortle starting at level 36. It is the final form of Squirtle.
        Blastoise has two other forms :
            - It can Mega Evolve into Mega Blastoise using the Blastoisinite.
            - It can Gigantamax into Gigantamax Blastoise if it has the Gigantamax Factor for its Gigantamax form that was introduced in The Isle of Armor.
        Blastoise is the game mascot of the Japanese and international versions of Pokémon Blue, appearing on the boxart of both games.
        """, healt: 1600, attack: 160, dam_type: "Water-type Pokémon", ability: "Mega Launcher", typePokemon: [TypePokemon(nameType: "Water")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 5, name: "Machamp", description: """
        Machamp (Japanese: カイリキー Kairiky) is a Fighting-type Pokémon introduced in Generation I.
        It evolves from Machoke when traded or when exposed to a Linking CordLA. It is the final form of Machop.
        Machamp can Gigantamax into Gigantamax Machamp if it has the Gigantamax Factor for its Gigantamax form.
        """, healt: 1800, attack: 180, dam_type: "Fighting-type Pokémon", ability: "Steadfast", typePokemon: [TypePokemon(nameType: "Fighting")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 6, name: "Suicune", description: """
        Suicune (Japanese: スイクン Suicune) is a Water-type Legendary Pokémon introduced in Generation II.
        It is not known to evolve into or from any other Pokémon.
        Along with Raikou and Entei, it is one of the Legendary beasts resurrected by Ho-Oh after the burning of the Brass Tower. Of the three Legendary beasts, Suicune is said to represent the rains that quenched the flames of the burning Brass Tower.
        Suicune is the game mascot of Pokémon Crystal, appearing on the boxart.
        It appears to be distantly related to the Paradox Pokémon Walking Wake.
        Suicune is pursued in the anime, Pokémon Adventures, Pokémon Crystal, and Pokémon HeartGold and SoulSilver by Eusine.
        """, healt: 2000, attack: 200, dam_type: "Water-type Legendary Pokémon", ability: "Water Absorb", typePokemon: [TypePokemon(nameType: "Water")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 7, name: "Raikou", description: """
        Raikou (Japanese: ライコウ Raikou) is an Electric-type Legendary Pokémon introduced in Generation II.
        It is not known to evolve into or from any other Pokémon.
        Along with Entei and Suicune, it is one of the Legendary beasts resurrected by Ho-Oh after the burning of the Brass Tower. Of the three Legendary beasts, Raikou is said to represent the lightning strike which ignited the fire that consumed the Brass Tower.
        """, healt: 2200, attack: 220, dam_type: " Electric-type Legendary Pokémon", ability: "Volt Absorb", typePokemon: [TypePokemon(nameType: "Electric")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 8, name: "Entei", description: """
        Entei (Japanese: エンテイ Entei) is a Fire-type Legendary Pokémon introduced in Generation II.
        It is not known to evolve into or from any other Pokémon.
        Along with Raikou and Suicune, it is one of the Legendary beasts said to be resurrected by Ho-Oh after the burning of the Brass Tower. Out of the three beasts, Entei is said to represent the flames that burned the Brass Tower.
        """, healt: 2400, attack: 240, dam_type: "Fire-type Legendary Pokémon", ability: "Flash Fire", typePokemon: [TypePokemon(nameType: "Fire")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 9, name: "Gyarados", description: """
        Gyarados (Japanese: ギャラドス Gyarados) is a dual-type Water/Flying Pokémon introduced in Generation I.
        It evolves from Magikarp starting at level 20.
        Gyarados can Mega Evolve into Mega Gyarados using the Gyaradosite.
        """, healt: 2600, attack: 260, dam_type: "Water/Flying Pokémon", ability: "Mold Breaker", typePokemon: [TypePokemon(nameType: "Water"), TypePokemon(nameType: "Flying")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 10, name: "Mewtwo", description: """
        Mewtwo (Japanese: ミュウツー Mewtwo) is a Psychic-type Legendary Pokémon introduced in Generation I.
        While it is not known to evolve into or from any other Pokémon, Mewtwo can Mega Evolve into two different forms :
            - Mega Mewtwo X using Mewtwonite X.
            - Mega Mewtwo Y using Mewtwonite Y.
        It is a member of the Mew duo along with Mew.
        """, healt: 2800, attack: 280, dam_type: "Psychic-type Legendary Pokémon", ability: "Insomnia", typePokemon: [TypePokemon(nameType: "Psychic")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 11, name: "Latios", description: """
        Latios (Japanese: ラティオス Latios) is a dual-type Dragon/Psychic Legendary Pokémon introduced in Generation III.
        While it is not known to evolve into or from any other Pokémon, Latios can Mega Evolve into Mega Latios using the Latiosite.
        It is a member of the eon duo along with Latias.
        """, healt: 3000, attack: 300, dam_type: "Dragon/Psychic Legendary", ability: "Levitate", typePokemon: [TypePokemon(nameType: "Dragon"), TypePokemon(nameType: "Psychic")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 12, name: "Latias", description: """
        Latias (Japanese: ラティアス Latias) is a dual-type Dragon/Psychic Legendary Pokémon introduced in Generation III.
        While it is not known to evolve into or from any other Pokémon, Latias can Mega Evolve into Mega Latias using the Latiasite.
        It is a member of the eon duo along with Latios.
        """, healt: 3200, attack: 320, dam_type: "Dragon/Psychic Legendary Pokémon", ability: "Levitate", typePokemon: [TypePokemon(nameType: "Dragon"), TypePokemon(nameType: "Psychic")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 13, name: "Lugia", description: """
        Lugia (Japanese: ルギア Lugia) is a dual-type Psychic/Flying Legendary Pokémon introduced in Generation II.
        It is not known to evolve into or from any other Pokémon.
        Lugia is the game mascot of Pokémon Silver, its remake Pokémon SoulSilver, and Pokémon XD: Gale of Darkness (as Shadow Lugia), appearing on the boxart of them all.
        Along with Ho-Oh, it is part of the tower duo. It is also the trio master of the Legendary birds.
        In Pokémon XD, Shadow Lugia, codenamed XD001, is a main part of the storyline, and Cipher's ultimate Shadow Pokémon.
        """, healt: 3400, attack: 340, dam_type: "Psychic/Flying Legendary Pokémon", ability: "Multiscale", typePokemon: [TypePokemon(nameType: "Psychic"), TypePokemon(nameType: "Flying")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 14, name: "Greninja", description: """
        Greninja (Japanese: ゲッコウガ Gekkouga) is a dual-type Water/Dark Pokémon introduced in Generation VI.
        It evolves from Frogadier starting at level 36. It is the final form of Froakie.
        In Generation VII, Greninja with the Ability Battle Bond can transform into a special form known as Ash-Greninja after defeating an opponent during battle.
            - Greninja with Battle Bond is a distinct form, and is unable to breed as it belongs to the No Eggs Discovered Egg Group, and alternate forms of Froakie and Frogadier with Battle Bond do not exist.
        In Pokémon Scarlet and Violet, Battle Bond's effect was altered to only increase Greninja's stats when defeating an opponent, and Ash-Greninja no longer exists.
        """, healt: 3600, attack: 360, dam_type: "Water/Dark Pokémon", ability: "Battle Bond", typePokemon: [TypePokemon(nameType: "Water"), TypePokemon(nameType: "Dark")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 15, name: "Dialga", description: """
        Dialga (Japanese: ディアルガ Dialga) is a dual-type Steel/Dragon Legendary Pokémon introduced in Generation IV.
        While it is not known to evolve into or from any other Pokémon, Dialga transforms into a second form, called its Origin Forme, while holding an Adamant Crystal.
        Dialga is the game mascot of Pokémon Diamond and its remake Pokémon Brilliant Diamond, appearing on the box art of both games in its standard form.
        Along with Palkia and Giratina, it is a member of the creation trio of Sinnoh, representing time. In the past, it was worshipped by the Diamond Clan under the name "almighty Sinnoh" (Japanese: シンオウさま Shin'ou-sama).
        """, healt: 3800, attack: 380, dam_type: "Steel/Dragon Legendary Pokémon", ability: "Telepathy", typePokemon: [TypePokemon(nameType: "Steel"), TypePokemon(nameType: "Dragon")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 16, name: "Arceus", description: """
        Arceus (Japanese: アルセウス Arceus) is a Normal-type Mythical Pokémon introduced in Generation IV.
        While it is not known to evolve into or from any other Pokémon, Arceus will change type when it is holding a Plate or type-specific Z-Crystal.
        Arceus is known as "The Original One", as it is said that it created Sinnoh and Ransei, and possibly the entire Pokémon universe, along with the lake guardians and creation trio.
        It is the trio master of both the lake guardians and the creation trio.
        Arceus is featured prominently in Pokémon Legends: Arceus and plays a major role in its plot.
        """, healt: 4000, attack: 400, dam_type: "Normal-type Mythical Pokémon", ability: "Multitype", typePokemon: [TypePokemon(nameType: "Normal")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 17, name: "Regirock", description: """
        Regirock (Japanese: レジロック Regirock) is a Rock-type Legendary Pokémon introduced in Generation III.
        It is not known to evolve into or from any other Pokémon.
        It is a member of the Legendary titans along with Regice, Registeel, Regieleki, and Regidrago.
        """, healt: 4200, attack: 420, dam_type: "Rock-type Legendary Pokémon", ability: "Sturdy", typePokemon: [TypePokemon(nameType: "Rock")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 18, name: "Regigigas", description: """
        Regigigas (Japanese: レジギガス Regigigas) is a Normal-type Legendary Pokémon introduced in Generation IV.
        It is not known to evolve into or from any other Pokémon.
        Regigigas is the master of the Legendary titans, serving as their creator.
        """, healt: 4400, attack: 440, dam_type: "Normal-type Legendary Pokémon", ability: "Slow Start", typePokemon: [TypePokemon(nameType: "Normal")])
        self.enemyList.append(enemyObj)

        enemyObj = Enemy(level: 19, name: "Regice", description: """
        Regice (Japanese: レジアイス Regice) is an Ice-type Legendary Pokémon introduced in Generation III.
        It is not known to evolve into or from any other Pokémon.
        It is a member of the Legendary titans along with Regirock, Registeel, Regieleki, and Regidrago.
        """, healt: 4600, attack: 460, dam_type: "Ice-type Legendary Pokémon", ability: "Ice Body", typePokemon: [TypePokemon(nameType: "Ice")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 20, name: "Rayquaza", description: """
        Rayquaza (Japanese: レックウザ Rayquaza) is a dual-type Dragon/Flying Legendary Pokémon introduced in Generation III.
        While it is not known to evolve into or from any other Pokémon, Rayquaza can Mega Evolve into Mega Rayquaza if it knows Dragon Ascent, but only if it is not holding a Z-Crystal. In Pokémon Omega Ruby and Alpha Sapphire, the Rayquaza featured in the Delta Episode must be caught (which requires it to eat the Meteorite) before the player can Mega Evolve any Rayquaza.
        Rayquaza is the game mascot of Pokémon Emerald, appearing on the boxart of the game. It serves to end the conflict between Kyogre and Groudon when Team Magma's leader Maxie and Team Aqua's leader Archie awakened them.
        Along with Kyogre and Groudon, Rayquaza is one of the super-ancient Pokémon, serving as the group's trio master. In Pokémon Omega Ruby and Alpha Sapphire, it plays an important role during the Delta Episode and is required to be caught there to fight Deoxys.
        """, healt: 4800, attack: 480, dam_type: "Dragon/Flying Legendary Pokémon", ability: "Air Lock", typePokemon: [TypePokemon(nameType: "Dragon"), TypePokemon(nameType: "Flying")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 21, name: "Palkia", description: """
        Palkia (Japanese: パルキア Palkia) is a dual-type Water/Dragon Legendary Pokémon introduced in Generation IV.
        While it is not known to evolve into or from any other Pokémon, Palkia transforms into a second form, called its Origin Forme, while holding a Lustrous Globe.
        (Specifics may differ in past games. Refer to Game data→Form data for these details.)
        Palkia is the game mascot of Pokémon Pearl and its remake Pokémon Shining Pearl, appearing on the box art of both games in its normal form.
        Along with Dialga and Giratina, it is a member of the creation trio of Sinnoh, representing space. In the past, it was worshipped by the Pearl Clan under the name "almighty Sinnoh" (Japanese: シンオウさま Shin'ou-sama).
        """, healt: 5000, attack: 500, dam_type: "Water/Dragon Legendary Pokémon", ability: "Telepathy", typePokemon: [TypePokemon(nameType: "Water"), TypePokemon(nameType: "Dragon")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 22, name: "Metagross", description: """
        Metagross (Japanese: メタグロス Metagross) is a dual-type Steel/Psychic pseudo-legendary Pokémon introduced in Generation III.
        It evolves from Metang starting at level 45. It is the final form of Beldum.
        Metagross can Mega Evolve into Mega Metagross using the Metagrossite.
        """, healt: 5200, attack: 520, dam_type: "Steel/Psychic pseudo-legendary Pokémon", ability: "Tough Claws", typePokemon: [TypePokemon(nameType: "Steel"), TypePokemon(nameType: "Psychic")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 23, name: "Kyogre", description: """
        Kyogre (Japanese: カイオーガ Kyogre) is a Water-type Legendary Pokémon introduced in Generation III.
        While it is not known to evolve into or from any other Pokémon, Kyogre can undergo Primal Reversion and become Primal Kyogre if it holds the Blue Orb.
        Kyogre possesses the ability to expand the oceans. In ancient times, it came into conflict with Groudon, a Pokémon with the ability to expand continents. In Pokémon Sapphire, Emerald, and Alpha Sapphire, Kyogre is sought after by Team Aqua as part of their plot to create more habitats for aquatic Pokémon by raising the sea level.
        Kyogre is the game mascot of Pokémon Sapphire and its remake, Pokémon Alpha Sapphire, with Kyogre appearing on the box art of Sapphire and Primal Kyogre appearing on the box art of Alpha Sapphire.
        Along with Groudon and Rayquaza, Kyogre is one of the super-ancient Pokémon.
        """, healt: 5400, attack: 540, dam_type: "Water-type Legendary Pokémon", ability: "Primordial Sea", typePokemon: [TypePokemon(nameType: "Water")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 24, name: "Heatran", description: """
        Heatran (Japanese: ヒードラン Heatran) is a dual-type Fire/Steel Legendary Pokémon introduced in Generation IV.
        It is not known to evolve into or from any other Pokémon.
        """, healt: 5600, attack: 560, dam_type: "Fire/Steel Legendary Pokémon", ability: "Flash Fire", typePokemon: [TypePokemon(nameType: "Fire"), TypePokemon(nameType: "Steel")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 25, name: "Groudon", description: """
        Groudon (Japanese: グラードン Groudon) is a Ground-type Legendary Pokémon introduced in Generation III.
        While it is not known to evolve into or from any other Pokémon, Groudon can undergo Primal Reversion and become Primal Groudon if it holds the Red Orb and thus become a dual-type Ground/Fire.
        Groudon possesses the ability to expand continents. In ancient times it came in conflict with Kyogre, a Pokémon with the ability to expand the oceans. In Pokémon Ruby, Emerald, and Omega Ruby, Groudon is sought after by Team Magma as a major part of their plot to create more habitats for land Pokémon by lowering the sea level.
        Groudon is the game mascot of Pokémon Ruby and its remake Pokémon Omega Ruby, with Groudon appearing on the box art of Ruby and Primal Groudon appearing on the box art of Omega Ruby.
        Along with Kyogre and Rayquaza, Groudon is one of the super-ancient Pokémon.
        """, healt: 5800, attack: 580, dam_type: "Ground-type Legendary Pokémon", ability: "Drought", typePokemon: [TypePokemon(nameType: "Ground")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 26, name: "Giratina", description: """
        Giratina (Japanese: ギラティナ Giratina) is a dual-type Ghost/Dragon Legendary Pokémon introduced in Generation IV.
        While it is not known to evolve into or from any other Pokémon, Giratina transforms from its standard form, called its Altered Forme, into a second form, called its Origin Forme, while holding a Griseous Core or while in its home, the Distortion World.
        (Specifics may differ in past games. Refer to Game data→Form data for these details.)
        Giratina's Origin Forme was officially revealed in early February 2008.
        Giratina is the game mascot of Pokémon Platinum, appearing on the boxart in its Origin Forme.
        Along with Dialga and Palkia, it is a member of the creation trio of Sinnoh, representing antimatter.
        """, healt: 6000, attack: 600, dam_type: "Ghost/Dragon Legendary Pokémon", ability: "Pressure", typePokemon: [TypePokemon(nameType: "Ghost"), TypePokemon(nameType: "Dragon")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 27, name: "Deoxys", description: """
        Deoxys (Japanese: デオキシス Deoxys) is a Psychic-type Mythical Pokémon introduced in Generation III.
        While it is not known to evolve into or from any other Pokémon, Deoxys has four forms: Normal Forme, Attack Forme, Defense Forme, and Speed Forme. It can change betweens its forms by interacting with certain meteorites.
        """, healt: 6200, attack: 620, dam_type: "Psychic-type Mythical Pokémon", ability: "Pressure", typePokemon: [TypePokemon(nameType: "Psychic")])
        self.enemyList.append(enemyObj)
        
        enemyObj = Enemy(level: 28, name: "Darkrai", description: """
        Darkrai (Japanese: ダークライ Darkrai) is a Dark-type Mythical Pokémon introduced in Generation IV.
        It is not known to evolve into or from any other Pokémon.
        It was officially revealed in February 2007.
        It is a member of the lunar duo with Cresselia.
        Darkrai is the last Pokémon in the Hisui Pokédex.
        """, healt: 6400, attack: 640, dam_type: "Dark-type Mythical Pokémon", ability: "Bad Dreams", typePokemon: [TypePokemon(nameType: "Dark")])
        self.enemyList.append(enemyObj)
    }
}// Levels View ends

struct Levels_Previews: PreviewProvider {
    static var previews: some View {
        Levels()
    }
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

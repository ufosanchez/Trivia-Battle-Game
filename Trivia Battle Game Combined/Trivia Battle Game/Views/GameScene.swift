//
//  3D_GameScene.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-05-12.
//

import Foundation
import SceneKit
import QuartzCore
import UIKit

class GameScene : SCNScene {
    
    var enemy = SCNNode()
    var medal = SCNNode()
    var champion = SCNNode()
    
    var singleton = Singleton.shared
    var enemySelected = "zapdos"
    
    convenience init(make:Bool){
        self.init()
        
        background.contents = UIColor.gray
        
        let scene = SCNScene(named: "3D_Game.scn")!
        
        let cam = scene.rootNode.childNode(withName: "camera", recursively: true)!
        
        rootNode.addChildNode(cam)
        
        stadium()
        monster()
        hero()
//        badge()
//        warrior()
//        background()
        
        //hero
        
//        zapdos()
//        venusaur()
//        suicune()
//        raikou()
//        mewtwo()
//        machamp()
//        lugia()
//        latios()
//        latias()
//        gyarados()
//        greninja()
//        entei()
//        dialga()
//        charizard()
//        blastoise()
//        arceus()
//        
//        //enemy
//        regirock()
//        regigigas()
//        regice()
//        rayquaza()
//        palkia()
//        metagross()
//        kyogre()
//        heatran()
//        groudon()
//        giratina()
//        deoxys()
//        darkrai()

    }
    
    //hero
    
    func stadium(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let stadium = scene.rootNode.childNode(withName: "stadium", recursively: true)!
        rootNode.addChildNode(stadium)
    }
    
    func monster(){
        let scene = SCNScene(named: "3D_Game.scn")!
        enemy = scene.rootNode.childNode(withName: singleton.enemySingleton.name.lowercased(), recursively: true)!
//        rootNode.addChildNode(enemy)
        
//        let move = SCNAction.move(to: SCNVector3(x: 0, y: 0, z: 3.685), duration: 3)
//        let move2 = SCNAction.rotate(by: .pi, around: SCNVector3(0, 1, 0), duration: 1)
//        let move3 = SCNAction.move(to: SCNVector3(x: 0, y: 0, z: -5.465 ), duration: 3)
//        let move4 = SCNAction.rotate(by: -(.pi), around: SCNVector3(0, 1, 0), duration: 1)
//        
//        let sequence = SCNAction.sequence([move, move2, move3, move4])
//        enemy.runAction(sequence)
        
        rootNode.addChildNode(enemy)
    }
    
    func badge(){
        let scene = SCNScene(named: "3D_Game.scn")!
        medal = scene.rootNode.childNode(withName: "zapdos", recursively: true)!
        rootNode.addChildNode(medal)
    }
    
    func hero(){
        let scene = SCNScene(named: "3D_Game.scn")!
        champion = scene.rootNode.childNode(withName: "widowmaker", recursively: true)!
        rootNode.addChildNode(champion)
    }
    
    func zapdos(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let zapdos = scene.rootNode.childNode(withName: "zapdos", recursively: true)!
        rootNode.addChildNode(zapdos)
    }
    
    func venusaur(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let venusaur = scene.rootNode.childNode(withName: "venusaur", recursively: true)!
        rootNode.addChildNode(venusaur)
    }
    
    func suicune(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let suicune = scene.rootNode.childNode(withName: "suicune", recursively: true)!
        rootNode.addChildNode(suicune)
    }
    
    func raikou(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let raikou = scene.rootNode.childNode(withName: "raikou", recursively: true)!
        rootNode.addChildNode(raikou)
    }
    
    func mewtwo(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let mewtwo = scene.rootNode.childNode(withName: "mewtwo", recursively: true)!
        rootNode.addChildNode(mewtwo)
    }
    
    func machamp(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let machamp = scene.rootNode.childNode(withName: "machamp", recursively: true)!
        rootNode.addChildNode(machamp)
    }

    func lugia(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let lugia = scene.rootNode.childNode(withName: "lugia", recursively: true)!
        rootNode.addChildNode(lugia)
    }
    
    func latios(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let latios = scene.rootNode.childNode(withName: "latios", recursively: true)!
        rootNode.addChildNode(latios)
    }
    
    func latias(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let latias = scene.rootNode.childNode(withName: "latias", recursively: true)!
        rootNode.addChildNode(latias)
    }

    func gyarados(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let gyarados = scene.rootNode.childNode(withName: "gyarados", recursively: true)!
        rootNode.addChildNode(gyarados)
    }

    func greninja(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let greninja = scene.rootNode.childNode(withName: "greninja", recursively: true)!
        rootNode.addChildNode(greninja)
    }

    func entei(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let entei = scene.rootNode.childNode(withName: "entei", recursively: true)!
        rootNode.addChildNode(entei)
    }

    func dialga(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let dialga = scene.rootNode.childNode(withName: "dialga", recursively: true)!
        rootNode.addChildNode(dialga)
    }

    func charizard(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let charizard = scene.rootNode.childNode(withName: "charizard", recursively: true)!
        rootNode.addChildNode(charizard)
    }

    func blastoise(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let blastoise = scene.rootNode.childNode(withName: "blastoise", recursively: true)!
        rootNode.addChildNode(blastoise)
    }

    func arceus(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let arceus = scene.rootNode.childNode(withName: "arceus", recursively: true)!
        rootNode.addChildNode(arceus)
    }
    
    //enemy
    
    func regirock(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let regirock = scene.rootNode.childNode(withName: "regirock", recursively: true)!
        rootNode.addChildNode(regirock)
    }
    
    func regigigas(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let regigigas = scene.rootNode.childNode(withName: "regigigas", recursively: true)!
        rootNode.addChildNode(regigigas)
    }
    
    func regice(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let regice = scene.rootNode.childNode(withName: "regice", recursively: true)!
        rootNode.addChildNode(regice)
    }
    
    func rayquaza(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let rayquaza = scene.rootNode.childNode(withName: "rayquaza", recursively: true)!
        rootNode.addChildNode(rayquaza)
    }
    
    func palkia(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let palkia = scene.rootNode.childNode(withName: "palkia", recursively: true)!
        rootNode.addChildNode(palkia)
    }
    
    func metagross(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let metagross = scene.rootNode.childNode(withName: "metagross", recursively: true)!
        rootNode.addChildNode(metagross)
    }
    
    func kyogre(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let kyogre = scene.rootNode.childNode(withName: "kyogre", recursively: true)!
        rootNode.addChildNode(kyogre)
    }
    
    func heatran(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let heatran = scene.rootNode.childNode(withName: "heatran", recursively: true)!
        rootNode.addChildNode(heatran)
    }
    
    func groudon(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let groudon = scene.rootNode.childNode(withName: "groudon", recursively: true)!
        rootNode.addChildNode(groudon)
    }
    
    func giratina(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let giratina = scene.rootNode.childNode(withName: "giratina", recursively: true)!
        rootNode.addChildNode(giratina)
    }
    
    func deoxys(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let deoxys = scene.rootNode.childNode(withName: "deoxys", recursively: true)!
        rootNode.addChildNode(deoxys)
    }
    
    func darkrai(){
        let scene = SCNScene(named: "3D_Game.scn")!
        let darkrai = scene.rootNode.childNode(withName: "darkrai", recursively: true)!
        rootNode.addChildNode(darkrai)
    }
    
    
    
}

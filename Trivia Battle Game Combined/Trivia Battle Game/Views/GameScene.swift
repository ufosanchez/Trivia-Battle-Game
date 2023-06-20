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
    
    func hero(){
        let scene = SCNScene(named: "3D_Game.scn")!
        champion = scene.rootNode.childNode(withName: singleton.heroSingleton.lowercased(), recursively: true)!
        rootNode.addChildNode(champion)
    }
    
    func badge(){
        let scene = SCNScene(named: "3D_Game.scn")!
        medal = scene.rootNode.childNode(withName: "zapdos", recursively: true)!
        rootNode.addChildNode(medal)
    }
}

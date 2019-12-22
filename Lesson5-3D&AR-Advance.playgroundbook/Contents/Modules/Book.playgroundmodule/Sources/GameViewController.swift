//
//  GameViewController.swift
//  3DSnake
//
//  Created by Michal Kowalski on 18.07.2017.
//  Copyright © 2017 PGS Software. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

final public class GameViewController: UIViewController {

    var gameController: GameController = GameController()
    var scnView:SCNView! = SCNView()
    override public func viewDidLoad() {
        super.viewDidLoad()

        scnView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)

        // create a new scene
        let scene = SCNScene(named: "main.scn")!
        self.view.addSubview(scnView)
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)

        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 10, z: 15)
        cameraNode.look(at: SCNVector3.init(0, 0, 0))
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 1)
        scene.rootNode.addChildNode(lightNode)

        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)

        scnView.scene = scene
        gameController.addToNode(rootNode: scene.rootNode)

        scnView.showsStatistics = true

        scnView.backgroundColor = UIColor.black

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_:)))
        swipeLeft.direction = .left
        scnView.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(_:)))
        swipeRight.direction = .right
        scnView.addGestureRecognizer(swipeRight)

    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gameController.reset()
        gameController.startGame()
    }

    override public var shouldAutorotate: Bool {
        return true
    }

    override public var prefersStatusBarHidden: Bool {
        return true
    }

    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    @objc func swipeLeft(_ sender: Any) {
        gameController.snake.turnLeft()
    }

    @objc func swipeRight(_ sender: Any) {
        gameController.snake.turnRight()
    }

}

//
//  ARmodelViewController.swift
//  Finalv1
//
//  Created by yoghurt on 2019/3/23.
//  Copyright © 2019 yoghurt. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
public class ARModelViewController: UIViewController,ARSCNViewDelegate {
    var sceneView: ARSCNView!
    var filename:String = "nypp"
    let filename_suffix : String = ".obj"
    override public func viewDidLoad() {
        super.viewDidLoad()
        sceneView = ARSCNView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        // Set the view's delegate
        sceneView.delegate = self
        self.view.addSubview(sceneView)
        let scene = SCNScene(named: filename+filename_suffix)!
        //Change the scale
        let modelScale:SCNNode? = scene.rootNode.childNodes.first
        modelScale?.transform = SCNMatrix4MakeScale(0.1, 0.1, 0.1)
        //modelScale?.eulerAngles = SCNVector3(deg2rad(90.0),0,0)
        
        // Set the scene to the view
        sceneView.scene = scene
        // Show statistics such as fps and timing information
        sceneView.allowsCameraControl = true
        //sceneView.showsStatistics = true
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    public func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    public func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    public func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    public func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
   /* func putOnFloor(anchor:ARPlaneAnchor)  {
        let scene = SCNScene(named: "nypp.obj")!
        //Change the scale
        let modelScale:SCNNode? = scene.rootNode.childNodes.first
        modelScale?.transform = SCNMatrix4MakeScale(0.1, 0.1, 0.1)
        modelScale?.geometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        modelScale?.position = SCNVector3(anchor.center.x,anchor.center.y,anchor.center.z)
        modelScale?.eulerAngles = SCNVector3(deg2rad(90.0),0,0)
        
        // Set the scene to the view
        sceneView.scene = scene
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        // Create a new scene
    }*/
    public func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let anchorPlane = anchor as? ARPlaneAnchor else {return }
        //putOnFloor(anchor: anchorPlane)
        
    }
}

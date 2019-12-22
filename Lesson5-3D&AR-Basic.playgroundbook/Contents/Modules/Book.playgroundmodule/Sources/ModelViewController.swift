import UIKit
import SceneKit
public class ModelViewController:UIViewController{
    public var filename:String = "nypp"
    let filename_suffix = ".obj"
    var mySceneView:SCNView!
    override public func viewDidLoad() {
        mySceneView = SCNView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        super.viewDidLoad()
        if filename == "nypp"{
            show_model(instrument_name: filename+filename_suffix)
        }
        self.view.addSubview(mySceneView)
    }
    
    private func show_model(instrument_name:String){
        //加载场景
        if let myScene = SCNScene(named: instrument_name){
            //加入相机视角，即我们初识从一个角度去看模型
            let cameraNode = SCNNode()
            cameraNode.camera = SCNCamera()
            cameraNode.position = SCNVector3(0, 0, 15)
            myScene.rootNode.addChildNode(cameraNode)
            
            //给物体打光，看起来真实
            let lightNode = SCNNode()
            lightNode.light = SCNLight()
            lightNode.light!.type = .omni
            lightNode.position = SCNVector3(0, 10, 10)
            myScene.rootNode.addChildNode(lightNode)
            
            //周围环境光
            let ambientLightNode = SCNNode()
            ambientLightNode.light = SCNLight()
            ambientLightNode.light!.type = .ambient
            ambientLightNode.light!.color = UIColor.darkGray
            myScene.rootNode.addChildNode(ambientLightNode)
            
            mySceneView.scene = myScene
            
            
            if filename == "nypp"{
                let modelScale:SCNNode? = myScene.rootNode.childNodes.first
                modelScale?.transform = SCNMatrix4MakeScale(10.0, 10.0, 10.0)
                modelScale?.eulerAngles = SCNVector3(45,45,45)
            }
            
            
            mySceneView.allowsCameraControl = true
            mySceneView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}

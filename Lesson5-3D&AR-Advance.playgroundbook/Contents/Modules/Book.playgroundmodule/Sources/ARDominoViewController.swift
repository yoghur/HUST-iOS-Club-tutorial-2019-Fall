import UIKit
import SceneKit
import ARKit


public class ARDominoViewController:UIViewController,ARSCNViewDelegate{
    var sceneView:ARSCNView!
    var removeButton = UIButton()
    var startButton = UIButton()
    
    
    var detectedPlanes:[String:SCNNode] = [:]
    var dominoes: [SCNNode] = []
    var previousDominoPosition: SCNVector3?
    let dominoColors: [UIColor] = [.red,.blue,.green,.yellow,.orange,.cyan,.magenta,.purple]
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        let scene = SCNScene()
        sceneView = ARSCNView()
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.scene = scene
        sceneView.scene.physicsWorld.timeStep = 1/200
        sceneView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(sceneView)
        //添加手势
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(screenPanned))
        setupButtons()
        sceneView.addGestureRecognizer(panGesture)
        addLights()
        
        
    }
    
    func setupButtons(){
        //UI布局
        self.view.addSubview(removeButton)
        self.view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.layer.cornerRadius = 8
        startButton.layer.masksToBounds = true
        startButton.leadingAnchor.constraint(equalTo: sceneView.leadingAnchor, constant: 0).isActive = true
        startButton.topAnchor.constraint(equalTo: sceneView.topAnchor, constant: 70).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        startButton.setTitle("Start", for: .normal)
        startButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        startButton.setTitleColor(.cyan, for: .normal)
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchDown)
        
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.layer.cornerRadius = 8
        removeButton.layer.masksToBounds = true
        removeButton.leadingAnchor.constraint(equalTo: sceneView.leadingAnchor, constant: 170).isActive = true
        removeButton.trailingAnchor.constraint(equalTo: sceneView.trailingAnchor, constant: -170).isActive = true
        removeButton.bottomAnchor.constraint(equalTo: sceneView.bottomAnchor, constant: -100).isActive = true
        removeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        removeButton.setTitle("Remove All Dominoes", for: .normal)
        removeButton.setTitleColor(.cyan, for: .normal)
        removeButton.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 0)
        removeButton.addTarget(self, action: #selector(removeAllDominoesButtonPressed), for: .touchDown)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    @objc func screenPanned(gesture:UIPanGestureRecognizer){
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        
        let location = gesture.location(in: sceneView)//获取手指到的当前位置
        guard let hitTestResult = sceneView.hitTest(location, types: .existingPlane).first else {return}
        guard let previousPesition = previousDominoPosition else {
            self.previousDominoPosition = SCNVector3Make(hitTestResult.worldTransform.columns.3.x,
                                                         hitTestResult.worldTransform.columns.3.y,
                                                         hitTestResult.worldTransform.columns.3.z)
            return
        }
        let currentPosition = SCNVector3Make(hitTestResult.worldTransform.columns.3.x,
                                             hitTestResult.worldTransform.columns.3.y,
                                             hitTestResult.worldTransform.columns.3.z)
        let minimumDistanceBetweenDominoes:Float = 0.03
        let distance = distanceBetween(point1: previousPesition, andPoint2: currentPosition)
        if distance >= minimumDistanceBetweenDominoes{
            //创建一个domino并随机赋色
            let dominoGeometry = SCNBox(width: 0.007, height: 0.06, length: 0.03, chamferRadius: 0.0)
            dominoGeometry.firstMaterial?.diffuse.contents = dominoColors.randomElement()
            let dominoNode = SCNNode(geometry: dominoGeometry)
            dominoNode.position = SCNVector3Make(currentPosition.x, currentPosition.y + 0.03, currentPosition.z)
            
            //旋转ddomino
            var currentAngle:Float = pointPairToBearingDegress(startingPoint: CGPoint(x: CGFloat(currentPosition.x), y: CGFloat(currentPosition.z)), secondPoint: CGPoint(x: CGFloat(previousPesition.x), y: CGFloat(previousPesition.z)))
            currentAngle *= .pi/180
            dominoNode.rotation = SCNVector4Make(0, 1, 0, -currentAngle)
            //物理属性
            dominoNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
            dominoNode.physicsBody?.mass = 2.0
            dominoNode.physicsBody?.friction = 0.8
            
            sceneView.scene.rootNode.addChildNode(dominoNode)
            dominoes.append(dominoNode)
            self.previousDominoPosition = currentPosition
        }
        
    }
    
    
    func addLights(){
        //directional light
        let directionalLight = SCNLight()
        directionalLight.type = .directional
        directionalLight.intensity = 500
        directionalLight.castsShadow = true
        directionalLight.shadowMode = .deferred
        directionalLight.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        let directionalLightNode = SCNNode()
        directionalLightNode.light = directionalLight
        
        //rotate light downwards
        directionalLightNode.rotation = SCNVector4Make(1, 0, 0, -Float.pi/3)
        sceneView.scene.rootNode.addChildNode(directionalLightNode)
        
        //ambient light
        let ambientLight = SCNLight()
        ambientLight.intensity = 50
        let ambientLightNode = SCNNode()
        ambientLightNode.light = ambientLight
        sceneView.scene.rootNode.addChildNode(ambientLightNode)
    }
    
    @objc func removeAllDominoesButtonPressed(){
        for domino in dominoes{
            domino.removeFromParentNode()
            self.previousDominoPosition = nil
        }
        dominoes = []
    }
    
    @objc func startButtonPressed(){
        guard let firstDomino = dominoes.first else {
            //fatalError("oops!")
            return
        }
        let power: Float = 0.7
        
        firstDomino.physicsBody?.applyForce(SCNVector3Make(firstDomino.worldRight.x * power,
                                                           firstDomino.worldRight.y * power,
                                                           firstDomino.worldRight.z * power),
                                            asImpulse: true)
    }
    
    func distanceBetween(point1:SCNVector3,andPoint2 point2:SCNVector3) -> Float{
        return hypotf(Float(point1.x - point2.x), Float(point1.z - point2.z))
    }
    
    public func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        //create planes to represent the floor
        guard let planeAnchor = anchor as? ARPlaneAnchor else {
            return
        }
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        plane.firstMaterial?.colorBufferWriteMask = .init(rawValue: 0)
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3Make(planeAnchor.center.x,
                                            planeAnchor.center.y,
                                            planeAnchor.center.z)
        planeNode.rotation = SCNVector4Make(1, 0, 0, -Float.pi/2.0)
        
        //physics
        let box = SCNBox(width: CGFloat(planeAnchor.center.x), height: CGFloat(planeAnchor.center.z), length: 0.001, chamferRadius: 0)
        planeNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: box, options: nil))
        node.addChildNode(planeNode)
        detectedPlanes[planeAnchor.identifier.uuidString] = planeNode
    }
    
    public func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        //update the planes size and position
        guard let planeAnchor = anchor as? ARPlaneAnchor else {
            return
        }
        guard let planeNode = detectedPlanes[planeAnchor.identifier.uuidString] else {
            return
        }
        let planeGeometry = planeNode.geometry as! SCNPlane
        planeGeometry.width = CGFloat(planeAnchor.extent.x)
        planeGeometry.height = CGFloat(planeAnchor.extent.z)
        planeNode.position = SCNVector3Make(planeAnchor.center.x,
                                            planeAnchor.center.y,
                                            planeAnchor.center.z)
        //update the physics shape
        let box = SCNBox(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z), length: 0.001, chamferRadius: 0)
        planeNode.physicsBody?.physicsShape = SCNPhysicsShape(geometry: box, options: nil)
    }
    
    func pointPairToBearingDegress(startingPoint:CGPoint,secondPoint endingPoint:CGPoint)->Float{
        let originPoint:CGPoint = CGPoint(x: startingPoint.x - endingPoint.x, y: startingPoint.y - endingPoint.y)
        let bearingRadians = atan2f(Float(originPoint.y), Float(originPoint.x))
        let bearingDegrees = bearingRadians * (180 / Float.pi)
        return bearingDegrees
    }
}

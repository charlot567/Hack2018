//
//  ViewController.swift
//  wow
//
//  Created by Alex Morin on 18-01-21.
//  Copyright © 2018 AlexMorin. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController {

    var sceneView: ARSCNView!
    
    var answerNode1 = SCNNode()
    var answerNode2 = SCNNode()
    var answerNode3 = SCNNode()
    
    var currentFact = String()
    
    var textNode = SCNNode()
    
    var answer1 = SCNText()
    var answer3 = SCNText()
    var answer2 = SCNText()
    var currentMission: Mission?
    var isDone = false;
    
    var text = SCNText()
    
    var statusLabel = UILabel()
    
    var backButtonView = UIButton()
    
    init(mission: Mission) {
        self.currentMission = mission
        super.init(nibName: nil, bundle: nil)
    }
    
    init(fact: String) {
        self.currentMission = nil
        self.currentFact = fact
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.currentMission = nil
        super.init(coder: aDecoder)
        sceneView = ARSCNView(frame: self.view.frame)
        self.view.addSubview(sceneView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView = ARSCNView(frame: view.frame)
        self.view.addSubview(sceneView)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        backButtonView = UIButton(frame: CGRect(x: 0, y: 0, width: kWidth, height: 70))
        backButtonView.addTarget(self, action: #selector(back), for: .touchUpInside)
        backButtonView.layer.zPosition = 1000
        self.sceneView.addSubview(backButtonView)
        
        let backButton = UIImageView()
        backButton.frame = CGRect(x: 20, y: 30, width: 40, height: 40)
        backButton.image = UIImage(named: "arrow")
        backButton.layer.zPosition = 1001
        backButtonView.addSubview(backButton)
        // Create a new scene
        //let scene = SCNScene(named: "art.scnassets/Chien.scn")!
        //sceneView.scene = scene
        //sceneView.scene.isPaused = true

        //  add new node to root node
        //self.sceneView.scene.rootNode.addChildNode(generateQuestionAR(Question: "This is the actual question, and that question is actually really really long thus it needs a lot of space that's for sure!", Answer: ["Answer 1", "Answer 2", "Answer 3"]))
        //self.sceneView.scene.rootNode.addChildNode(generateMessage(message: "This is a right answer of course you knew it was number 3 or maybe 2 it does not really matter!"))
        
        statusLabel.frame = CGRect(x: 5, y: self.view.frame.height*0.9, width: self.view.frame.width - 10, height: self.view.frame.height*0.1-24)
        statusLabel.backgroundColor = UIColor.lightGray
        statusLabel.textColor = UIColor.white;
        statusLabel.layer.cornerRadius = 3;
        statusLabel.clipsToBounds = true;
        statusLabel.text = "FIND_PLANE".lz();
        statusLabel.textAlignment = NSTextAlignment.center
        
        
        self.view.addSubview(statusLabel)
    }
    
    @objc func back() {
        print("back")
        
        var  vc = MenuViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    func generateMessage(message: String) -> SCNNode {
        text = SCNText(string: message, extrusionDepth: 2)
        //  create material
        let material = SCNMaterial()
        text.alignmentMode = kCAAlignmentCenter
        text.isWrapped = true
        text.containerFrame = CGRect(x: 0, y: 0, width: 140, height: 150)
        material.diffuse.contents = UIColor.black
        text.materials = [material]
        
        //Create Node object
        var textNode = SCNNode()
        textNode.scale = SCNVector3(x:0.002,y:0.002,z:0.002)
        textNode.geometry = text
        textNode.position = SCNVector3(x: -0.15, y:-0.108, z: -0.498)
        
        var plane = SCNPlane(width: 0.32, height: 0.35)
        plane.cornerRadius = 0.05;
        let material2 = SCNMaterial()
        
        material2.diffuse.contents = UIColor.white
        plane.materials = [material2]
        
        
        
        var planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3(x: -0.010, y:0.05, z: -0.50)
        
        
        var parentNode = SCNNode()
        parentNode.addChildNode(planeNode)
        parentNode.addChildNode(textNode)
        
        parentNode.position = SCNVector3(x: 0.27, y: 0.15, z: 0.47)
        
        return parentNode
    }
    
    func generateQuestionAR(Question: String, Answer:[Answer]) -> SCNNode {
        let textQuestion = SCNText(string: Question, extrusionDepth: 2)
        //  create material
        let material = SCNMaterial()
        textQuestion.alignmentMode = kCAAlignmentCenter
        textQuestion.isWrapped = true
        textQuestion.containerFrame = CGRect(x: 0, y: 0, width: 140, height: 150)
        material.diffuse.contents = UIColor.black
        textQuestion.materials = [material]
        
        //Create Node object
        textNode = SCNNode()
        textNode.scale = SCNVector3(x:0.002,y:0.002,z:0.002)
        textNode.geometry = textQuestion
        textNode.position = SCNVector3(x: -0.15, y:-0.040, z: -0.498)
        
        answerNode1 = SCNNode()
        answerNode2 = SCNNode()
        answerNode3 = SCNNode()
        
        if(Answer.count >= 1 ) {
            answer1 = SCNText(string: Answer[0].text!, extrusionDepth: 2)
            //  create material
            let material2 = SCNMaterial()
            answer1.alignmentMode = kCAAlignmentCenter
            answer1.isWrapped = true
            answer1.containerFrame = CGRect(x: 0, y: 0, width: 140, height: 100)
            material2.diffuse.contents = UIColor.blue
            answer1.materials = [material2]
            answerNode1.scale = SCNVector3(x:0.003,y:0.003,z:0.003)
            answerNode1.geometry = answer1
            answerNode1.position = SCNVector3(x: -0.22, y:-0.22, z: -0.498)
        }
        //Create Node object
        
        
        
        if(Answer.count >= 2) {
            answer2 = SCNText(string: Answer[1].text!, extrusionDepth: 2)
            //  create material
            let material3 = SCNMaterial()
            answer2.alignmentMode = kCAAlignmentCenter
            answer2.isWrapped = true
            answer2.containerFrame = CGRect(x: 0, y: 0, width: 140, height: 100)
            material3.diffuse.contents = UIColor.blue
            answer2.materials = [material3]
            
            
            //Create Node object
            
            answerNode2.scale = SCNVector3(x:0.003,y:0.003,z:0.003)
            answerNode2.geometry = answer2
            answerNode2.position = SCNVector3(x: -0.22, y:-0.28, z: -0.498)
        }
        
        
        
        if(Answer.count >= 3) {
            answer3 = SCNText(string: Answer[2].text!, extrusionDepth: 2)
            //  create material
            let material4 = SCNMaterial()
            answer3.alignmentMode = kCAAlignmentCenter
            answer3.isWrapped = true
            answer3.containerFrame = CGRect(x: 0, y: 0, width: 140, height: 100)
            material4.diffuse.contents = UIColor.blue
            answer3.materials = [material4]
            
            //Create Node object
            
            answerNode3.scale = SCNVector3(x:0.003,y:0.003,z:0.003)
            answerNode3.geometry = answer3
            answerNode3.position = SCNVector3(x: -0.22, y:-0.34, z: -0.498)
        }
        
        var plane = SCNPlane(width: 0.32, height: 0.45)
        let material2 = SCNMaterial()
        
        material2.diffuse.contents = UIColor.white
        plane.materials = [material2]
        plane.cornerRadius = 0.05;
        
        
        
        var planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3(x: -0.010, y:0.05, z: -0.52)
        
        var returnNode = SCNNode();
        returnNode.addChildNode(planeNode)
        returnNode.addChildNode(textNode)
        returnNode.addChildNode(answerNode1)
        returnNode.addChildNode(answerNode2)
        returnNode.addChildNode(answerNode3)
        
        returnNode.position = SCNVector3(x: 0.27, y: 0.2, z: 0.47)
        
        
        return returnNode
    }
    
    func changeQuestionText(text: String) {
        var text2 = SCNText(string: text, extrusionDepth: 2)
        //  create material
        let material = SCNMaterial()
        text2.alignmentMode = kCAAlignmentCenter
        text2.isWrapped = true
        text2.containerFrame = CGRect(x: 0, y: 0, width: 140, height: 150)
        material.diffuse.contents = UIColor.black
        text2.materials = [material]
    
        //Create Node object
        textNode.geometry = text2
    }
    
    func changeAnswerNode2Text(text: String) {
        var textans = SCNText(string: text, extrusionDepth: 2)
        //  create material
        let material4 = SCNMaterial()
        textans.alignmentMode = kCAAlignmentCenter
        textans.isWrapped = true
        textans.containerFrame = CGRect(x: 0, y: 0, width: 140, height: 100)
        material4.diffuse.contents = UIColor.blue
        textans.materials = [material4]
        
        //Create Node object
        answerNode2.geometry = textans
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as! UITouch
        if(touch.view == self.sceneView){
            let viewTouchLocation:CGPoint = touch.location(in: sceneView)

            guard let result = sceneView.hitTest(viewTouchLocation, options: nil).first else {
                return
            }
            
            if answerNode1.contains(result.node) { //myObjectNodes is declared as  Set<SCNNode>
                if(currentMission?.questions.answer[0].isCorrect)! {
                    answer1.materials[0].diffuse.contents = UIColor.green
                    changeQuestionText(text: (currentMission?.feedback.good!)!)
                } else {
                    answer1.materials[0].diffuse.contents = UIColor.red
                    changeQuestionText(text: (currentMission?.feedback.wrong!)!)
                }
                
                answerNode1.removeFromParentNode();
                answerNode3.removeFromParentNode();
                changeAnswerNode2Text(text: "Continuer".lz())
                isDone = true;
                
                
                
            } else if answerNode2.contains(result.node) {
                
                if(isDone) {
                    var  vc = MenuViewController()
                    self.present(vc, animated: true, completion: nil)
                    
                    ControllerUser.updateScore(score: self.currentMission!.reward)
                    ControllerMission.complete(mission: self.currentMission!)
                }
                
                
                if(currentMission?.questions.answer[1].isCorrect)! {
                    answer2.materials[0].diffuse.contents = UIColor.green
                    changeQuestionText(text: (currentMission?.feedback.good!)!)
                } else {
                    answer2.materials[0].diffuse.contents = UIColor.red
                    changeQuestionText(text: (currentMission?.feedback.wrong!)!)
                }
                
                answerNode1.removeFromParentNode();
                answerNode3.removeFromParentNode();
                changeAnswerNode2Text(text: "Continuer".lz())
                isDone = true;

            } else if answerNode3.contains(result.node) {
                
                
                if (currentMission?.questions.answer[2].isCorrect)! {
                    answer3.materials[0].diffuse.contents = UIColor.green
                    changeQuestionText(text: (currentMission?.feedback.good!)!)
                } else {
                    answer3.materials[0].diffuse.contents = UIColor.red
                    changeQuestionText(text: (currentMission?.feedback.wrong!)!)
                }
                
                answerNode1.removeFromParentNode();
                answerNode3.removeFromParentNode();
                changeAnswerNode2Text(text: "Continuer".lz())
                isDone = true;

            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
}
extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

extension ARViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // 1
        DispatchQueue.main.async {
            self.statusLabel.isHidden = true
        }
        
        
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // 2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        // 3
        plane.materials.first?.diffuse.contents = UIColor.lightGray.withAlphaComponent(0.30)
        
        // 4
        let planeNode = SCNNode(geometry: plane)
        
        // 5
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,y,z)
        planeNode.eulerAngles.x = -.pi / 2
        
        // 6
        node.addChildNode(planeNode)
        
        
        //On ajoute notre chien...
        
        guard let dogScene = SCNScene(named: "art.scnassets/Chien.scn"),
            let dogNode = dogScene.rootNode.childNode(withName: "Chien", recursively: false)
            
           
            else {
                print("Error")
                return }
        
        let user = UserDefaults.standard
        var val = user.value(forKey: "SKINVALUE") as? String
        
        if(val == nil) {
            val = "2"
        }
        
        if(val! == "1") {
            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named: "1.png")
            dogNode.geometry?.materials = [material]
        }
        if(val! == "2") {
            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named: "2.png")
            dogNode.geometry?.materials = [material]
        }
        if(val! == "3") {
            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named: "3.png")
            dogNode.geometry?.materials = [material]
        }
        if(val! == "4") {
            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named: "4.png")
            dogNode.geometry?.materials = [material]
        }
        
        
        
        
        
        dogNode.position = SCNVector3(x,y,z)
        node.addChildNode(dogNode)
        
        
        if(currentMission != nil) {
            node.addChildNode(generateQuestionAR(Question: (currentMission?.questions.title!)!, Answer: (currentMission?.questions.answer)!))
        } else if(currentFact != "") {
            node.addChildNode(generateMessage(message: currentFact))
        }
        
        
        //node.addChildNode(generateMessage(message: "This is a right answer of course you knew it was number 3 or maybe 2 it does not really matter!"))
        
        sceneView.scene.isPaused = true
        
        
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // 1
        guard let planeAnchor = anchor as?  ARPlaneAnchor,
            let planeNode = node.childNodes.first,
            let plane = planeNode.geometry as? SCNPlane
            else { return }
        
        // 2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
        
        // 3
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x, y, z)
    }
}

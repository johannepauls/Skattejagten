//
//  SkatteJagtViewController.swift
//  Skattejagt
//
//  Created by Johanne Kristine Kappel Pauls on 06/06/2018.
//  Copyright © 2018 Johanne Kristine Kappel Pauls. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import EstimoteProximitySDK

class SkatteJagtViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    @IBOutlet weak var logTextView: UITextView!
    
    var proximityObserver: EPXProximityObserver?
    var proximityZones = [EPXProximityZone]()
    var cylinder = SCNCylinder()
    var node = SCNNode()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        

        
        
        let cloudCredentials: EPXCloudCredentials = (UIApplication.shared.delegate as! AppDelegate).cloudCredentials
        proximityObserver = EPXProximityObserver(credentials: cloudCredentials, errorBlock: { error in
            print("proximity observer error: \(error)") })
        defineProximityZones()
        if let proximityObserver = proximityObserver {
            proximityObserver.startObserving(proximityZones)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func createImage() {
        cylinder = SCNCylinder(radius: 0.1, height: 0.7)
        node = SCNNode(geometry: cylinder)
        
        // assign image
        cylinder.firstMaterial?.diffuse.contents = UIImage(named: "boy-kopi.png")
        
        node.position = SCNVector3(0, 0, -1.5)
        
        sceneView.scene.rootNode.addChildNode(node)
        
    }
    
    func removeImage() {
        node.removeFromParentNode()
    }
    
    
    func defineProximityZones() {
        let behandlingsrum = "behandling"
        let behandlingIT = EPXProximityZone(range: .near, attachmentKey: "room", attachmentValue: behandlingsrum)
       
        behandlingIT.onEnterAction = { attachment in
            self.logAction(message: "Entering \(behandlingsrum)")
            self.createImage()
        }
        
        behandlingIT.onExitAction = { attachment in
            self.logAction(message: "Exiting \(behandlingsrum)")
            self.removeImage()
        }
        
        let gang = "gang"
        let gangIT = EPXProximityZone(range: .near, attachmentKey: "room", attachmentValue: gang)
        
        gangIT.onEnterAction = { attachment in
            self.logAction(message: "Entering \(gang)")
            self.createImage()
        }
        gangIT.onExitAction = { attachment in
            self.logAction(message: "Exiting \(gang)")
            self.removeImage()
        }
        
        let venterum = "venterum"
        let venteIT = EPXProximityZone(range: .near, attachmentKey: "room", attachmentValue: venterum)
        
       venteIT.onEnterAction = { attachment in
            self.logAction(message: "Entering \(venterum)")
            self.createImage()
        }
        
        venteIT.onExitAction = { attachment in
            self.logAction(message: "Exiting \(venterum)")
            self.removeImage()
        }
        proximityZones.append(gangIT)
        proximityZones.append(behandlingIT)
        proximityZones.append(venteIT)
    }
    
    private func logAction(message: String) {
        print(message)
        let timeStamp = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
        logTextView.text = "\n" + timeStamp + ": " + message + logTextView.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

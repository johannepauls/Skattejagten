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
        
        createImage()
        
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
        
        let cylinder = SCNCylinder(radius: 0.1, height: 0.7)
        let node = SCNNode(geometry: cylinder)
        
        // assign image
        cylinder.firstMaterial?.diffuse.contents = UIImage(named: "boy-kopi.png")
        
        node.position = SCNVector3(0, 0, -1.5)
        
        sceneView.scene.rootNode.addChildNode(node)
        
    }
    
    
    func defineProximityZones() {
        let healthCareDepartment = "Healthcare"
        let zoneHealthcare = EPXProximityZone(range: .near, attachmentKey: "department", attachmentValue: healthCareDepartment)
        zoneHealthcare.onEnterAction = { attachment in
            self.logAction(message: "Entering \(healthCareDepartment)")
        }
        zoneHealthcare.onExitAction = { attachment in
            self.logAction(message: "Exiting \(healthCareDepartment)")
        }
        zoneHealthcare.onChangeAction = { attachments in
            let rooms = attachments.compactMap { $0.payload["room"]}
            self.logAction(message: "Nearby \(healthCareDepartment) rooms: \(rooms)")
        }
        
        let iTDepartment = "EIT"
        let zoneIT = EPXProximityZone(range: .near, attachmentKey: "department", attachmentValue: iTDepartment)
        zoneIT.onEnterAction = { attachment in
            self.logAction(message: "Entering \(iTDepartment)")
        }
        zoneIT.onExitAction = { attachment in
            self.logAction(message: "Exiting \(iTDepartment)")
        }
        zoneIT.onChangeAction = { attachments in
            let rooms = attachments.compactMap { $0.payload["room"]}
            self.logAction(message: "Nearby \(iTDepartment) rooms: \(rooms)")
        }
        
        proximityZones.append(zoneHealthcare)
        proximityZones.append(zoneIT)
        
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  HomeViewController.swift
//  Skattejagten
//
//  Created by Johanne Kristine Kappel Pauls on 15/06/2018.
//  Copyright © 2018 Johanne Kristine Kappel Pauls. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    
    @IBAction func afspilLyd(_ sender: UIButton) {
        audioPlayer.play()
    }
    
    
    @IBAction func tapToLaunch(_ sender: UITapGestureRecognizer) {
        launchHelicopter()
    }
    
    @IBAction func tapboy(_ sender: UITapGestureRecognizer) {
        launchTapboy()
    }
    
    
    @IBOutlet weak var helicopterImageView: UIImageView!
    @IBOutlet weak var boylaunch: UIImageView!
    @IBOutlet weak var hospital: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = Bundle.main.url(forResource:"DrengTale", withExtension:"mp3")
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer.prepareToPlay()
        }catch let error as NSError {
            print(error.debugDescription)
        }
        
        helicopterImageView.isUserInteractionEnabled = true
        boylaunch.isUserInteractionEnabled = true
        hospital.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    func launchHelicopter() {
        
        UIView.animate(withDuration: 3.0, delay: 0.5, options: [.curveEaseInOut, .autoreverse, .repeat, .allowUserInteraction], animations: {
            self.helicopterImageView.transform = CGAffineTransform(translationX: 0.0, y: -100.0)
        }, completion: {_ in
            //                self.helicopterImageView.transform = .identity
        }
        )
        
        
        
    }
    
    func launchTapboy () {
        UIView.animate(withDuration: 3.0, delay: 0.0, options: [], animations:{
            self.boylaunch.transform = CGAffineTransform(translationX: +280.0, y: -30.0)
            self.boylaunch.frame.size.height -= 170
            self.boylaunch.frame.size.width -= 160
            
        }
            , completion: {_ in
                
        }
            
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let hospitalViewcontroller = storyboard.instantiateViewController(withIdentifier: "HospitalVCID")
            self.present(hospitalViewcontroller, animated: true, completion: nil)}
        
        
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

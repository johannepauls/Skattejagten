//
//  HomepageViewController.swift
//  Skattejagten
//
//  Created by Caroline Pilegaard on 12/06/2018.
//  Copyright © 2018 Johanne Kristine Kappel Pauls. All rights reserved.
//

import UIKit

class ViewControllerHome: UIViewController {
    
    
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
        helicopterImageView.isUserInteractionEnabled = true
        boylaunch.isUserInteractionEnabled = true
        hospital.isUserInteractionEnabled = true
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
            self.boylaunch.transform = CGAffineTransform(translationX: +267.0, y: -55.0)
            //CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.boylaunch.frame.size.height -= 140
            self.boylaunch.frame.size.width -= 150
            
        }
            , completion: {_ in
                //                self.helicopterImageView.transform = .identity
        }
        )
        
        
    }
    
}



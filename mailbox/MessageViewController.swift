//
//  MessageViewController.swift
//  mailbox
//
//  Created by Jayne Vidheecharoen on 9/26/14.
//  Copyright (c) 2014 Jayne Vidheecharoen. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var messageImageView: UIImageView!

    var imageCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func onPanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        var location = gestureRecognizer.locationInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            imageCenter = messageImageView.center
        } else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            messageImageView.center.x = translation.x + imageCenter.x
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            
        }
        
    
    }

}

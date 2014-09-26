//
//  MailboxViewController.swift
//  mailbox
//
//  Created by Jayne Vidheecharoen on 9/26/14.
//  Copyright (c) 2014 Jayne Vidheecharoen. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedimageView: UIImageView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var messageView: UIView!
    
    var imageCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: 320, height: 1380)
        messageView.backgroundColor = UIColor(red: (86/256), green: (185/256), blue: (217/256), alpha: 1)
        
    }

    @IBAction func onTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func onPanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        
        var location = gestureRecognizer.locationInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            imageCenter = messageImageView.center
        } else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            messageImageView.center.x = translation.x + imageCenter.x
            
            println("\(translation)")
            
            // color changing
            UIView.animateWithDuration(0.2, animations: {

                // red
                if translation.x > 60{
                    self.messageView.backgroundColor = UIColor(red: (181/256), green: (26/256), blue: (0/256), alpha: 1)
                // yellow
                } else if translation.x < 60{
                    self.messageView.backgroundColor = UIColor(red: (255/256), green: (248/256), blue: (84/256), alpha: 1)
                }
            }, completion:nil)
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            
           // move the message back if not dragged past trigger
            UIView.animateWithDuration(0.2, animations: {
                
                if translation.x < 70{
                    self.messageImageView.center.x = (320/2)
                } else if translation.x > 70{
                    self.messageImageView.center.x = (320/2)
                }
                
            }, completion: nil)

        }

        
    }
}

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
    @IBOutlet weak var archiveIconImageView: UIImageView!
    @IBOutlet weak var deleteIconImageView: UIImageView!
    @IBOutlet weak var listIconImageView: UIImageView!
    @IBOutlet weak var laterIconImageView: UIImageView!
    
    
    
    var imageCenter: CGPoint!
    
    // set up colors here
    let greyColor = UIColor(red: (223/256), green: (228/256), blue: (232/256), alpha: 1)
    let redColor = UIColor(red: (233/256), green: (85/256), blue: (59/256), alpha: 1)
    let yellowColor = UIColor(red: (250/256), green: (211/256), blue: (51/256), alpha: 1)
    let brownColor = UIColor(red: (215/256), green: (165/256), blue: (51/256), alpha: 1)
    let greenColor = UIColor(red: (116/256), green: (215/256), blue: (104/256), alpha: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: 1380)
        messageView.backgroundColor = greyColor

    }

    @IBAction func onTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func onPanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        var location = gestureRecognizer.locationInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        
        //dragging
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            imageCenter = messageImageView.center
        } else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            messageImageView.center.x = translation.x + imageCenter.x
            
            println("\(translation)")
            
            // color changing
            UIView.animateWithDuration(0.1, animations: {

             
                if translation.x > 60{
                    //red
                    self.messageView.backgroundColor = self.greenColor
                    self.archiveIconImageView.center.x = translation.x - 30
                    
                } else if translation.x < -60{
                    // yellow
                    self.messageView.backgroundColor = self.yellowColor
                    self.laterIconImageView.center.x = translation.x + 350
                    
                } else if (translation.x > -60) && (translation.x < 60){
                    //grey
                    self.messageView.backgroundColor = self.greyColor
                }
                
            }, completion:nil)
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            
           // move the message back if not dragged past trigger
            UIView.animateWithDuration(0.2, animations: {
                
                
                self.archiveIconImageView.center.x = 30
                self.laterIconImageView.center.x = 350
                
                self.messageImageView.center.x = 160
                
                //colors
                self.messageView.backgroundColor = self.greyColor
                
            }, completion: nil)

        }

        
    }
}

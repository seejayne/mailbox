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
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var archiveFeed: UIImageView!
    @IBOutlet weak var laterFeed: UIImageView!
    
    var imageCenter: CGPoint!
    var mainContentCenter: CGPoint!
    var modalUp = false
    
    // set up colors here
    let greyColor = UIColor(red: (223/256), green: (228/256), blue: (232/256), alpha: 1)
    let redColor = UIColor(red: (233/256), green: (85/256), blue: (59/256), alpha: 1)
    let yellowColor = UIColor(red: (250/256), green: (211/256), blue: (51/256), alpha: 1)
    let brownColor = UIColor(red: (215/256), green: (165/256), blue: (51/256), alpha: 1)
    let greenColor = UIColor(red: (116/256), green: (215/256), blue: (104/256), alpha: 1)
    let blueColor = UIColor(red: (112/256), green: (197/256), blue: (224/256), alpha: 1)
    
    // start up stuff
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize.height = feedimageView.frame.height + messageImageView.frame.height + 165
        archiveFeed.frame.origin.x = 320
        laterFeed.frame.origin.x = -320

    }
    // set message background color and icon alphas
    func setBackcolorAlpha (backColor: UIColor, archAlpha: CGFloat, latAlpha: CGFloat, delAlpha: CGFloat, lisAlpha: CGFloat){
        
        // message background color
        self.messageView.backgroundColor = backColor
        
        // alpha (1,1,0,0)
        self.archiveIconImageView.alpha = archAlpha
        self.laterIconImageView.alpha = latAlpha
        self.deleteIconImageView.alpha = delAlpha
        self.listIconImageView.alpha = lisAlpha
    }
    // set icon positions
    func setIconPosition (archPos: CGFloat, latPos: CGFloat, delPos: CGFloat, lisPos: CGFloat){
        self.archiveIconImageView.center.x = archPos
        self.laterIconImageView.center.x = latPos
        self.deleteIconImageView.center.x = delPos
        self.listIconImageView.center.x = lisPos
    }
    // move the feed up
    func shiftFeed(){
        self.feedimageView.center.y = 678
        self.scrollView.contentSize.height = feedimageView.frame.height
    }
    // sets the position and alpha of segment options
    func setSegmentVisuals(segColor: UIColor, scrollX: CGFloat, archiveX: CGFloat, laterX: CGFloat, scrollAlpha: CGFloat, archiveAlpha: CGFloat, laterAlpha: CGFloat ){
        
        segmentedControl.tintColor = segColor
        scrollView.frame.origin.x = scrollX
        archiveFeed.frame.origin.x = archiveX
        laterFeed.frame.origin.x = laterX
        
        scrollView.alpha = scrollAlpha
        archiveFeed.alpha = archiveAlpha
        laterFeed.alpha = laterAlpha
    }

    // Toggle between segment views
    @IBAction func onSegmentChanged(sender: UISegmentedControl) {
        var selectedSeg = sender.selectedSegmentIndex
        println(selectedSeg)
        var segTint = sender.tintColor
        
        UIView.animateWithDuration(0.3, animations: {
            if selectedSeg == 0 {
                self.setSegmentVisuals(self.yellowColor, scrollX: 320, archiveX: 320, laterX: 0, scrollAlpha: 0, archiveAlpha: 0, laterAlpha: 1)
            } else if selectedSeg == 1{
                self.setSegmentVisuals(self.blueColor, scrollX: 0, archiveX: 320, laterX: -320, scrollAlpha: 1, archiveAlpha: 0, laterAlpha: 0)
            } else if selectedSeg == 2{
                self.setSegmentVisuals(self.greenColor, scrollX: -320, archiveX: 0, laterX: -320, scrollAlpha: 0, archiveAlpha: 1, laterAlpha: 0)
            }
        })
    
        
        //var selectedSegmentIndex: Int
        //var tintColor: UIColor
    }
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        if modalUp{
            UIView.animateWithDuration(0.5, animations: {
                self.rescheduleView.alpha = 0
                self.listView.alpha = 0
                self.shiftFeed()
                }, completion: nil)
        }
    }
    
    // Page edge thing didnt really work, using a regular pan instead.
    @IBAction func onNavPan(sender: UIPanGestureRecognizer) {
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began{
            self.mainContentCenter = mainContentView.center
        } else if sender.state == UIGestureRecognizerState.Changed{
            if mainContentView.center.x >= 160 {
                self.mainContentView.center.x = translation.x + mainContentCenter.x
            } else {
                self.mainContentView.center.x = 160
            }
        } else if sender.state == UIGestureRecognizerState.Ended{
            
            UIView.animateWithDuration(0.3, animations:{
                if velocity.x > 0 {
                    self.mainContentView.center.x = 450
                } else {
                    self.mainContentView.center.x = 160
                }
            })
        }
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
            
            // archive
            if (translation.x > 60) && (translation.x < 260){
                self.setBackcolorAlpha(self.greenColor, archAlpha: 1, latAlpha: 0, delAlpha: 0, lisAlpha: 0)
                self.setIconPosition( translation.x - 30, latPos: 290, delPos: translation.x - 30, lisPos: 260)
                // later
            } else if (translation.x < -60) && (translation.x > -260) {
                self.setBackcolorAlpha(self.yellowColor,archAlpha: 0, latAlpha: 1, delAlpha: 0, lisAlpha: 0)
                self.setIconPosition( 30, latPos: translation.x + 350, delPos: 260, lisPos: translation.x +  350)
                // delete
            } else if (translation.x > 260) {
                self.setBackcolorAlpha(self.redColor,archAlpha: 0, latAlpha: 0, delAlpha: 1, lisAlpha: 0)
                self.setIconPosition( translation.x - 30, latPos: 290, delPos: translation.x - 30, lisPos: 260)
                // list
            } else if (translation.x < -260){
                self.setBackcolorAlpha(self.brownColor,archAlpha: 0, latAlpha: 0, delAlpha: 0, lisAlpha: 1)
                self.setIconPosition(30, latPos: translation.x + 350, delPos: 260, lisPos: translation.x + 350)
                // none
            } else if (translation.x > -60) && (translation.x < 60){
                self.setBackcolorAlpha(self.greyColor,archAlpha: 1, latAlpha: 1, delAlpha: 0, lisAlpha: 0)
                self.setIconPosition(30, latPos: 290, delPos: 260, lisPos: 260)
                
            }
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            
           // decide what to do
           UIView.animateWithDuration(0.4, animations: {
   
            // none
            if (translation.x < 60) && (translation.x > -60){
                self.messageImageView.center.x = 160
                self.setBackcolorAlpha(self.greyColor,archAlpha: 1, latAlpha: 1, delAlpha: 0, lisAlpha: 0)
                self.setIconPosition(30, latPos: 290, delPos: 260, lisPos: 260)
                
            // archive
            } else if (translation.x > 60) && (translation.x < 260){
                self.messageImageView.center.x = 520
                self.setBackcolorAlpha(self.greenColor,archAlpha: 1, latAlpha: 0, delAlpha: 0, lisAlpha: 0)
                self.setIconPosition(340, latPos: 290, delPos: 260, lisPos: 260)
                self.shiftFeed()
                
            // delete
            } else if (translation.x > 260){
                self.messageImageView.center.x = 520
                self.setBackcolorAlpha(self.redColor,archAlpha: 0, latAlpha: 0, delAlpha: 1, lisAlpha: 0)
                self.setIconPosition(30, latPos: 290, delPos: 340, lisPos: 260)
                self.shiftFeed()
                
            // later
            } else if (translation.x > -260) && (translation.x < -60){
                self.messageImageView.center.x = -520
                self.setBackcolorAlpha(self.yellowColor,archAlpha: 0, latAlpha: 0, delAlpha: 0, lisAlpha: 0)
                self.setIconPosition(30, latPos: -30, delPos: 260, lisPos: 260)
                self.rescheduleView.alpha = 1
                self.modalUp = true

            //list
            } else if (translation.x < -260) {
                self.messageImageView.center.x = -520
                self.setBackcolorAlpha(self.brownColor,archAlpha: 0, latAlpha: 0, delAlpha: 0, lisAlpha: 0)
                self.setIconPosition(30, latPos: 290, delPos: 260, lisPos: -30)
                self.listView.alpha = 1
                self.modalUp = true
            }
            
            }, completion: nil)

        }
        
    }
}

//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Baula Xu on 6/30/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    var newlyCreatedFaceOriginalScale: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        trayDownOffset = 160
        trayUp = trayView.center
        trayDown = CGPoint(x:trayView.center.x, y: trayView.center.y + trayDownOffset)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanTray(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        if sender.state == .Began {
            trayOriginalCenter = trayView.center
        } else if sender.state == .Changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y:trayOriginalCenter.y + translation.y)
        } else if sender.state == .Ended {
            let velocity = sender.velocityInView(view)
            if velocity.y > 0 { // moving down
                UIView.animateWithDuration(0.3, animations: { 
                    self.trayView.center = self.trayDown
                })
            } else {
                UIView.animateWithDuration(0.3, animations: { 
                    self.trayView.center = self.trayUp
                })
            }
            
        } else {
            print("wtf")
        }
    }
    
    @IBAction func didPanFace(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        if sender.state == .Began{
            var imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("didPanCanvasFace:"))
            newlyCreatedFace.userInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: Selector("didPinchFace:"))
            newlyCreatedFace.addGestureRecognizer(pinchGestureRecognizer)
            
            UIView.animateWithDuration(0.4, animations: {
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1.5, 1.5)
            })
            
        }
        else if sender.state == .Changed{
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        else if sender.state == .Ended{
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: { 
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: { (Bool) in
                    
            })
        }
        else{
            print("lol")
        }
        
    }
    
    func didPanCanvasFace(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        if sender.state == .Began {
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            UIView.animateWithDuration(0.4, animations: {
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1.5, 1.5)
                })
        }else if sender.state == .Changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        } else if sender.state == .Ended {
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: { (Bool) in
                    
            })
            
        } else {
            print("bleh")
        }
    }
    
    func didPinchFace(sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
        if sender.state == .Began {
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalScale = newlyCreatedFace.contentScaleFactor
        } else if sender.state == .Changed {
            newlyCreatedFace.contentScaleFactor = scale
        } else if sender.state == .Ended {
            
        }
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

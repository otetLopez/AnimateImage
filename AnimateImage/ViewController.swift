//
//  ViewController.swift
//  AnimateImage
//
//  Created by otet_tud on 1/8/20.
//  Copyright © 2020 otet_tud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var timer = Timer()
    var x : CGFloat = 0
    var y : CGFloat = 0
    var initialX : CGFloat = 0
    var initialY : CGFloat = 0
    var curr_x : CGFloat = 0
    var curr_y : CGFloat = 0
    var direction : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        x = imageView.frame.origin.x
        y = imageView.frame.origin.y
        curr_x = x
        curr_y = y
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(animate), userInfo: nil, repeats: true)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
            swipeRight.direction = UISwipeGestureRecognizer.Direction.right
            view.addGestureRecognizer(swipeRight)
            
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
            swipeRight.direction = UISwipeGestureRecognizer.Direction.left
            view.addGestureRecognizer(swipeLeft)
        
        //UIView.animateWithDu
    }
    
    @objc func animate() {
        let width = imageView.frame.size.width
        let height = imageView.frame.size.height
        
        self.imageView.frame = CGRect(x: curr_x, y: curr_y, width: width, height: height)
        curr_y += 150

        if curr_y > view.safeAreaLayoutGuide.layoutFrame.size.height {
            timer.invalidate()
            curr_y = view.safeAreaLayoutGuide.layoutFrame.size.height
        }
        
    }
    
    @objc func swiped (gesture: UISwipeGestureRecognizer) {
        initialX = imageView.frame.origin.x
        initialY = imageView.frame.origin.y
        
        let swipeGesture = gesture as UISwipeGestureRecognizer
        switch swipeGesture.direction {
        case UISwipeGestureRecognizer.Direction.right:
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(animateClockwise), userInfo: nil, repeats: true)
        case UISwipeGestureRecognizer.Direction.left:
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(animateCounterClockwise), userInfo: nil, repeats: true)
            //imageView.animateWithDuration()
    
        default:
            break
        }
    }
    
    @objc func animateCounterClockwise() {
        //print("Swiped left and we are turing Counter Clockwise")
        let width = imageView.frame.size.width
        let height = imageView.frame.size.height
        
        let maxW = view.safeAreaLayoutGuide.layoutFrame.size.width
        let maxH = view.safeAreaLayoutGuide.layoutFrame.size.height
        
        self.imageView.frame = CGRect(x: curr_x, y: curr_y, width: width, height: height)
            
            if curr_y == y {
                if curr_x != x {
                    curr_x -= 50
                    
                    if curr_x <= x {
                        curr_x = x
                    }
                } else if curr_x == x {
                    curr_y += 50
                }

            } else if curr_y == maxH {
                if curr_x != maxW-50 {
                    curr_x += 50
                    if curr_x >= maxW-50 {
                        curr_x = maxW-50
                    }
                } else {
                    curr_y -= 50
                }
                
            } else {
                if curr_x == x {
                    curr_y += 50
                    if curr_y >= maxH {
                        curr_y = maxH
                    }
                } else {
                    curr_y -= 50
                    if curr_y <= y {
                        curr_y = y
                    }
                }
            }
            if curr_y >= initialY && curr_x == initialX {
                self.imageView.frame = CGRect(x: curr_x, y: curr_y, width: width, height: height)
                timer.invalidate()
            }
    }
    
    @objc func animateClockwise() {
        let width = imageView.frame.size.width
        let height = imageView.frame.size.height
        
        let maxW = view.safeAreaLayoutGuide.layoutFrame.size.width
        let maxH = view.safeAreaLayoutGuide.layoutFrame.size.height
        //print("Swiped right and we are turing Clockwise with \(maxW) \(maxH).")
      
        self.imageView.frame = CGRect(x: curr_x, y: curr_y, width: width, height: height)
        
        if curr_y == y {
            if curr_x != maxW-50 {
                curr_x += 50
                if curr_x >= maxW {
                    curr_x = maxW-50
                    print("Reached Max")
                }
            } else {
                curr_y += 50
            }
        } else if curr_y > y  {
            if curr_x == maxW-50 && curr_y != maxH {
                print("Should be here")
                curr_y += 50
              if curr_y >= maxH {
                  curr_y = maxH
              }
            } else if curr_x != x {
                curr_x -= 50
                if curr_x <= x {
                curr_x = x
                }
            } else {
                curr_y -= 50
                if curr_y <= y {
                    curr_y = y
                }
            }
        }
        if curr_y >= initialY && curr_x == initialX {
            self.imageView.frame = CGRect(x: curr_x, y: curr_y, width: width, height: height)
            timer.invalidate()
        }
    }

}


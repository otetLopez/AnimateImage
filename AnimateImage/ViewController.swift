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
    var curr_y : CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        curr_y = imageView.frame.origin.y
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(animate), userInfo: nil, repeats: true)
    }
    
    @objc func animate() {
        let width = imageView.frame.size.width
        let height = imageView.frame.size.height
        let x = imageView.frame.origin.x
        let y = imageView.frame.origin.y
        
        self.imageView.frame = CGRect(x: x, y: curr_y, width: width, height: height)
        curr_y += 150
        
        let guide = view.safeAreaLayoutGuide
        let heightMax = guide.layoutFrame.size.height
        print("The max height is \(heightMax)")
        if curr_y > guide.layoutFrame.size.height {
            timer.invalidate()
        }
        
    }


}


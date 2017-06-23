//
//  ViewController.swift
//  ShadowImageView
//
//  Created by olddonkey on 2017/4/29.
//  Copyright © 2017年 olddonkey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var shadowImage: ShadowImageView!
    @IBOutlet weak var shadowAlphaSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func sliderDidChange(_ sender: UISlider) {
        shadowImage.shadowAlpha = CGFloat(sender.value)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


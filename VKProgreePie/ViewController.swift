//
//  ViewController.swift
//  VKProgreePie
//
//  Created by Vamshi Krishna on 28/11/17.
//  Copyright © 2017 VamshiKrishna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var showImageSwitch: UISwitch!
    @IBOutlet weak var showPercentSwitch: UISwitch!
    
    @IBOutlet weak var radialView: RadialProgressView!
    @IBOutlet weak var percentageSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        percentageSlider.value = Float(radialView.ringProgress)
    }

    @IBAction func percentSliderMoved(_ sender: Any) {
        radialView.ringProgress = CGFloat(percentageSlider.value)
    }
    
    @IBAction func showImageClicked(_ sender: Any) {
        radialView.showBackgroundImage = showImageSwitch.isOn
    }
    
    @IBAction func showPercentSwitchClicked(_ sender: Any) {
        radialView.showPercentage = showPercentSwitch.isOn
    }
}


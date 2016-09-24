//
//  ViewController.swift
//  AmuesmentParkPassGenerator
//
//  Created by Safwat Shenouda on 22/09/16.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    testData()
        
    }
    
    func testData() {
        
        let p = ParkSystem()
        p.plugData()
        
    }

    
}


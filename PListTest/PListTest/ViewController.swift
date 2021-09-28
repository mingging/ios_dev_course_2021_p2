//
//  ViewController.swift
//  PListTest
//
//  Created by minimani on 2021/09/28.
//

import UIKit

class ViewController: UIViewController {
    
    var bts:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "bts", ofType: "plist") {
            if let bts = NSArray(contentsOfFile: path) {
                if let member = bts[0] as? [String:String] {
                    print(member["stage_name"])
                }
            }
        }
    }


}


//
//  ViewController.swift
//  ActivityTest
//
//  Created by minimani on 2021/10/15.
//

import UIKit
import ProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var indicatro: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatro.hidesWhenStopped = true
        let indicator1 = UIActivityIndicatorView(frame:
                                                    CGRect(x: 0, y: 0, width: 50, height: 50))
        indicator1.center = self.view.center
        indicator1.hidesWhenStopped = true
        indicator1.color = .red
        self.view.addSubview(indicator1)
        indicator1.startAnimating()
    }

    @IBAction func actAnimate(_ sender: UIButton) {
        if indicatro.isAnimating {
            indicatro.stopAnimating()
        } else {
            indicatro.startAnimating()
        }
        
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show("Some text...")

    }
    
    @IBAction func changeProgress(_ sender: UISlider) {
        ProgressHUD.dismiss()
    }
    
    @IBAction func changeProgressValue(_ sender: UISlider) {
        let value = sender.value
        print(value)
        ProgressHUD.showProgress(CGFloat(value))
    }
    
}


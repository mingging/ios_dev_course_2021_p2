//
//  ViewController.swift
//  BarcodeScannerTest
//
//  Created by minimani on 2021/10/15.
//

import UIKit
import BarcodeScanner

class ViewController: UIViewController, BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate {
    
    @IBOutlet weak var lblBarcode: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("로딩")
    }

    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {

        lblBarcode.text = code
        controller.reset()
        controller.dismiss(animated: true, completion: nil)
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        
    }
    
    @IBAction func actBarcodeScan(_ sender: UIButton) {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        
        present(viewController, animated: true)
    }
}


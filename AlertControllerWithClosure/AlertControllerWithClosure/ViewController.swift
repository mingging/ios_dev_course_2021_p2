//
//  ViewController.swift
//  AlertControllerWithClosure
//
//  Created by minimani on 2021/10/13.
//

import UIKit

class ViewController: UIViewController  {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func actAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: "나타났다", message: "뭘 원하는가", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "확인", style: .default) { _ in
            print("확인했음")
        }
        
        let action2 = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("취소했냐?")
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        present(alert, animated: true) {
            print("얼럿 등장!")
        }
    
    }
    
}


//
//  ViewController.swift
//  AlertControllerTest
//
//  Created by minimani on 2021/09/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func afterPresent() {
        print("after present alert")
    }
    
    func afterOkAction(action: UIAlertAction) {
        print(action.title!)
    }
    
    func afterCancelAction(action: UIAlertAction) {
        print(action.title!)
    }
    
    func afterDestAction(action: UIAlertAction) {
        print(action.title!)
    }

    @IBAction func actAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: "Title", message: "message message", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "확인", style: .default, handler: afterOkAction)
        let action2 = UIAlertAction(title: "취소", style: .cancel, handler: afterCancelAction)
        let action3 = UIAlertAction(title: "삭제", style: .destructive, handler: afterDestAction)
        
        let action4 = UIAlertAction(title: "후행클로져", style: .default) { action in
            print("action4")
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(action4)
        present(alert, animated: true, completion: afterPresent)
        
    }
    
}


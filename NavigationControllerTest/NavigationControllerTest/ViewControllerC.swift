//
//  ViewControllerC.swift
//  NavigationControllerTest
//
//  Created by minimani on 2021/09/27.
//

import UIKit

class ViewControllerC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actToRoot(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    @IBAction func actPopTo(_ sender: UIButton) {
        // if let
//        if let viewControllers = self.navigationController?.viewControllers {
//            for viewController in viewControllers {
//                if viewController is ViewControllerA {
//                    self.navigationController?.popToViewController(viewController, animated: true)
//                }
//            }
//        }
        
        // guard let
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllers {
            // viewControllerA 일 때만 코드 실행
            if let vc = viewController as? ViewControllerA {
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func toYellow(_ sender: UIButton) {
        if let yellowVC = self.storyboard?.instantiateViewController(identifier: "yellow") {
            self.navigationController?.pushViewController(yellowVC, animated: true)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

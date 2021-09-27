//
//  DetailViewController.swift
//  IdolApp
//
//  Created by minimani on 2021/09/27.
//

import UIKit

class DetailViewController: UIViewController {

    var info:[String:String]?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let info = self.info else {return}
        
        if let imageName = info["img"] {
            imageView.image = UIImage(named: imageName)
        }
        
        lblTitle.text = info["title"]
        // Do any additional setup after loading the view.
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

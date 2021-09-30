//
//  ViewController.swift
//  UIImagePickerControllerTest
//
//  Created by minimani on 2021/09/29.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let picker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }


    @IBAction func takePicture(_ sender: UIButton) {
        let alert = UIAlertController(title: "이미지", message: "촬영하기와 이미지 불러오기 중 선택해주세요", preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: "촬영하기", style: .default) { _ in
            self.picker.sourceType = .savedPhotosAlbum
            self.present(self.picker, animated: true)

        }
        
        let photoLibraryAction = UIAlertAction(title: "이미지 불러오기", style: .default) { _ in
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true)

        }
        alert.addAction(cameraAction)
        alert.addAction(photoLibraryAction)
        present(alert, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {return}
        
        imageView.image = image
        dismiss(animated: true)
    }
    
}


//
//  HomeViewController.swift
//  EasyFilter
//
//  Created by Emre Çelik on 19.06.2020.
//  Copyright © 2020 Emre Çelik. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var cameraCardView: CardView!
    @IBOutlet weak var galleryCardView: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: Camera Button
    @IBAction func cameraTouchDown(_ sender: UIButton) {
        cameraCardView.animateButtonDown()
    }
    
    @IBAction func cameraTouchUpOutside(_ sender: UIButton) {
        cameraCardView.animateButtonUp()
    }
    
    @IBAction func cameraTouchUpInside(_ sender: UIButton) {
        cameraCardView.animateButtonUp()
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = false
        vc.delegate = self
        present(vc, animated: true)
    }
    
    //MARK: Gallery Button
    @IBAction func galleryTouchDown(_ sender: UIButton) {
        galleryCardView.animateButtonDown()
    }
    
    @IBAction func galleryTouchUpOutside(_ sender: UIButton) {
        galleryCardView.animateButtonUp()
    }
    
    @IBAction func galleryTouchUpInside(_ sender: UIButton) {
        galleryCardView.animateButtonUp()
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        let vc = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            vc.delegate = self
            vc.sourceType = .savedPhotosAlbum
            vc.allowsEditing = false
            present(vc, animated: true, completion: nil)
        }
    }
    
}

//MARK: ImagePicker Extension
extension HomeViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let selectionVC = storyboard.instantiateViewController(withIdentifier: "SelectionViewController") as! SelectionViewController
        selectionVC.originalImage = image
        selectionVC.image = image.aspectFittedToMaxLengthImage(maxLength: CGFloat(1000), compressionQuality: 0.5)
        self.navigationController?.pushViewController(selectionVC, animated: true)
    }
}

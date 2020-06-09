//
//  SelectionViewController.swift
//  EasyFilter
//
//  Created by Emre Çelik on 9.06.2020.
//  Copyright © 2020 Emre Çelik. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    let inputImage = UIImage(named: "dog")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filter = Filter()
        imageView.image = inputImage.getFilteredImage(filter: filter)
    }

    @IBAction func randomClicked(_ sender: Any) {
        let filter = Filter()
        imageView.image = inputImage.getFilteredImage(filter: filter)
    }
}

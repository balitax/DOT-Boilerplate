//
//  GalleryUploadViewController.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 07/12/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import UIKit

class GalleryUploadViewController: DOTBaseViewController {

    @IBOutlet weak var titleofGallery: UITextField!
    @IBOutlet weak var detailofGallery: UITextField!
    @IBOutlet weak var imageToDisplay: UIImageView!
    @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!
    
    var imageSelected = #imageLiteral(resourceName: "cover")
    var images = [#imageLiteral(resourceName: "cover"), #imageLiteral(resourceName: "cover")]
    
    lazy var galleryViewModel: GalleryViewModel = {
        return GalleryViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Gallery"
        
        self.galleryViewModel.showAlertClosure = { [weak self]() in
            DispatchQueue.main.async {
                if let message = self?.galleryViewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
        
        self.galleryViewModel.updateLoadingStatus = { [weak self]() in
            let isLoading = self?.galleryViewModel.isLoading ?? false
            if isLoading {
                self?.indicatorLoading.startAnimating()
            } else {
                self?.indicatorLoading.stopAnimating()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.previousIcon()
    }
    
    @IBAction func didChooseGallery(_ sender: UIButton) {
       self.didChooseImage(self)
    }
    
    @IBAction func didSaveGallery(_ sender: UIButton) {
        guard let titleGallery = self.titleofGallery.text else {
            return
        }
        
        guard let descriptionGallery = self.detailofGallery.text else {
            return
        }
        
        if titleGallery.isEmpty {
            self.showAlert("Please input title of gallery")
        } else if descriptionGallery.isEmpty {
            self.showAlert("Please input description of gallery")
        } else {
            self.galleryViewModel.uploadGallery(titleGallery, description: descriptionGallery, image:images)
        }
        
    }

}

extension GalleryUploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //PickerView Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageSelected = pickedImage
            self.imageToDisplay.image = pickedImage
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        print("picker cancel.")
    }
    
}

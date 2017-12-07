//
//  GalleryViewModel.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 07/12/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class GalleryViewModel {
    
    let galleryService: GalleryServiceProtocol
    private var gallery: Gallery = Gallery()
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    init(galleryService: GalleryServiceProtocol = GalleryService()) {
        self.galleryService = galleryService
    }
    
    func uploadGallery(_ title: String, description: String, image: [UIImage]) {
        self.isLoading = true
        galleryService.uploadGallery(title, description: description, images: image) { (response, error) in
            
            self.isLoading = false
            if let error = response?.error {
                self.alertMessage = error
            } else {
                self.alertMessage = "Success upload with link: \(response!.link!)"
                self.galleryFetch(response!)
            }
            
        }
    }
    
    func galleryFetch(_ gallery: Gallery) {
        self.gallery = gallery
    }
    
}

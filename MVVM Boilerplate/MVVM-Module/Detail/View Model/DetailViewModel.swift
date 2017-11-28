//
//  DetailViewModel.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 28/11/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import Foundation
import ObjectMapper


class DetailViewModel {
    
    let detailPostService: DetailPostServiceProtocol
    
    private var post: Post = Post()
    
    private var cellViewModel: DetailPostListCellViewModel = DetailPostListCellViewModel(titleValue: "", bodyValue: "") {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
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
    
    var numberOfCells: Int {
        return 1
    }
    
    var selectedPost: Post?
    
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    
    init(detailPostServices: DetailPostServiceProtocol = DetailPostService()) {
        self.detailPostService = detailPostServices
    }
    
    func initFetch(idPost: Int) {
        self.isLoading = true
        detailPostService.fetchDetailPost(id: idPost) { (post, error) in
            self.isLoading = false
            if let error = error {
                self.alertMessage = error.rawValue
            } else {
                self.detailPostfetchProcess(post!)
            }
        }
    }
    
    func getCellViewModel() -> DetailPostListCellViewModel {
        return cellViewModel
    }
    
    func createCellViewModel( _ post: Post) -> DetailPostListCellViewModel {
        return DetailPostListCellViewModel(titleValue: post.title!, bodyValue: post.body!)
    }
    
    private func detailPostfetchProcess(_ posts: Post) {
        self.post               = posts
        let cellModel           =  createCellViewModel(post)
        self.cellViewModel      = cellModel
    }
    
}

struct DetailPostListCellViewModel {
    let titleValue: String
    let bodyValue: String
}

//
//  PostViewModel.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 27/11/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import Foundation
import ObjectMapper


class PostViewModel {
    
    let postService: PostServiceProtocol
    
    private var post: [Post] = [Post]()
    
    private var cellViewModel: [PostListCellViewModel] = [PostListCellViewModel]() {
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
        return cellViewModel.count
    }
    
    var selectedPost: Post?
    
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?

    
    init(postServices: PostServiceProtocol = PostService()) {
        self.postService = postServices
    }
    
    func initFetch() {
        self.isLoading = true
        postService.fetchPost { (post, error) in
            self.isLoading = false
            if let error = error {
                self.alertMessage = error.rawValue
            } else {
                self.postfetchProcess(post!)
            }
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath) -> PostListCellViewModel {
        return cellViewModel[indexPath.row]
    }
    
    func createCellViewModel(_ post: Post) -> PostListCellViewModel {
        return PostListCellViewModel(postName: post.title!)
    }
    
    private func postfetchProcess(_ posts: [Post]) {
        self.post = posts
        var vms = [PostListCellViewModel]()
        for post in posts {
            vms.append(createCellViewModel(post))
        }
        self.cellViewModel = vms
    }
    
}

extension PostViewModel {
    func postPressed(at indexPath: IndexPath) -> Post {
        let post = self.post[indexPath.row]
        return post
    }
}


struct PostListCellViewModel {
    let postName: String
}

//
//  HomeViewController.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 27/11/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import UIKit
import ESPullToRefresh

class HomeViewController: DOTBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicators: UIActivityIndicatorView!
    
    lazy var postViewModel: PostViewModel = {
        return PostViewModel()
    }()
    
    private let refreshControl = UIRefreshControl()
    
    deinit {
        self.tableView.es.stopLoadingMore()
        self.tableView.es.stopPullToRefresh()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        self.tableView.register(HomeTableViewCell.register(), forCellReuseIdentifier: "home")
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        addSystemButtonNavbarOnLeft(sender: #selector(self.uploadGallery), type: UIBarButtonSystemItem.add)
        initViewModel()
        initRefreshControll()
    }
    
    fileprivate func initRefreshControll() {
        self.tableView.es.addPullToRefresh {
            self.initViewModel()
            self.tableView.es.stopPullToRefresh()
        }
    }
    
    @objc func uploadGallery() {
        self.pushNavigation(GalleryUploadViewController())
    }
    
    @objc func initViewModel() {
        self.postViewModel.showAlertClosure = { [weak self]() in
            DispatchQueue.main.async {
                if let message = self?.postViewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
        
        self.postViewModel.updateLoadingStatus = { [weak self]() in
            let isLoading = self?.postViewModel.isLoading ?? false
            if isLoading {
                self?.indicators.startAnimating()
            } else {
                self?.indicators.stopAnimating()
            }
        }
        
        self.postViewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self?.refreshControl.endRefreshing()
                self?.tableView.reloadData()
            })
        }
        
        self.postViewModel.initFetch()
        
    }
   
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "home", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        let cellVM = self.postViewModel.getCellViewModel(at: indexPath)
        cell.postName.text = cellVM.postName
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailPostViewController()
        detail.getValue = self.postViewModel.postPressed(at: indexPath)
        self.pushNavigation(detail)
    }
    
    
}

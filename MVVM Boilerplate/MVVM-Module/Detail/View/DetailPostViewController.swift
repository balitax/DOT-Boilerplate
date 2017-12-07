//
//  DetailPostViewController.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 28/11/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import UIKit

class DetailPostViewController: DOTBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // VARIABLES
    var getValue: Post?
    
    lazy var detailViewModel: DetailViewModel = {
        return DetailViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.title = "Detail Post"
        
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(DetailTableViewCell.register(), forCellReuseIdentifier: "detail")
        
        addSystemButtonNavbarOnRight(sender: #selector(self.didBookmarkPost(_:)), type: UIBarButtonSystemItem.bookmarks)
        initVM()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.previousIcon()
    }
    
    @objc func didBookmarkPost(_ sender: UIBarButtonItem) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showAlert("Post Successfully Bookmarked")
        }
    }
    
    @objc func initVM() {
        
        self.detailViewModel.showAlertClosure = { [weak self]() in
            DispatchQueue.main.async {
                if let message = self?.detailViewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
        
        self.detailViewModel.updateLoadingStatus = { [weak self]() in
            let isLoading = self?.detailViewModel.isLoading ?? false
            
            
        }
        
        self.detailViewModel.reloadTableViewClosure = { [weak self]() in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        self.detailViewModel.initFetch(idPost: getValue!.id!)
        
    }

}

extension DetailPostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detail", for: indexPath) as? DetailTableViewCell else {
            return UITableViewCell()
        }
        
        let data = self.detailViewModel.getCellViewModel()
        
        cell.titlePost.text = data.titleValue
        cell.bodyPost.text = data.bodyValue
        
        return cell
    }
    
}

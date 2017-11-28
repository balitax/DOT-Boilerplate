//
//  HomeTableViewCell.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 27/11/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postName: UILabel!
    
    static func register() -> UINib {
        return UINib(nibName: "HomeTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

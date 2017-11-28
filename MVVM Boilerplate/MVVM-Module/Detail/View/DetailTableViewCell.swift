//
//  DetailTableViewCell.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 28/11/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titlePost: UILabel!
    @IBOutlet weak var bodyPost: UILabel!
    
    static func register() -> UINib {
        return UINib(nibName: "DetailTableViewCell", bundle: nil)
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

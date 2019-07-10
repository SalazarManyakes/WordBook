//
//  WBListTableViewCell.swift
//  WordBook
//
//  Created by summer on 2019/7/9.
//  Copyright © 2019 summer. All rights reserved.
//

import UIKit

class WBListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellBackground: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var wordNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackground.layer.cornerRadius = 10
        cellBackground.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }


}

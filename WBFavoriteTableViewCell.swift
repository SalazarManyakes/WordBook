//
//  WBFavoriteTableViewCell.swift
//  WordBook
//
//  Created by summer on 2019/7/9.
//  Copyright © 2019 summer. All rights reserved.
//

import UIKit

class WBFavoriteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bkgImageView: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var favWordNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bkgImageView.layer.cornerRadius = 10
        bkgImageView.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }


}

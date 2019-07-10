//
//  WBFavoriteImageViewController.swift
//  WordBook
//
//  Created by summer on 2019/7/9.
//  Copyright © 2019 summer. All rights reserved.
//

import UIKit

class WBFavoriteImageViewController: UIViewController {

    
    var favImage: Data!
    
    @IBOutlet weak var favImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(data: favImage)
        favImageView.image = image
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

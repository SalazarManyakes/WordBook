//
//  WBFavoriteDetailViewController.swift
//  WordBook
//
//  Created by summer on 2019/7/9.
//  Copyright © 2019 summer. All rights reserved.
//

import UIKit

class WBFavoriteDetailViewController: UIViewController {

    var getFavWord: String!
    var getFavDetail: String!
    var getFavImageData: Data!
    
    @IBOutlet weak var favWordLabel: UILabel!
    @IBOutlet weak var favDetailTextView: UITextView!
    @IBOutlet weak var favImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favDetailTextView.text = getFavDetail
        self.favDetailTextView.isEditable = false
        
        favWordLabel.text = getFavWord
        
        let image = UIImage(data: getFavImageData)
        favImageView.image = image
        
        favDetailTextView.layer.borderColor = UIColor.black.cgColor
        favDetailTextView.layer.borderWidth = 2.0
        
        
    }
    
    @IBAction func favImageTapped(_ sender: Any) {
        performSegue(withIdentifier: "favImage", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "favImage") {
            let favImageVC: WBFavoriteImageViewController = (segue.destination as? WBFavoriteImageViewController)!
            
            favImageVC.favImage = getFavImageData
        }
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

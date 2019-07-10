//
//  WBDetailViewController.swift
//  WordBook
//
//  Created by summer on 2019/7/9.
//  Copyright © 2019 summer. All rights reserved.
//

import UIKit
import RealmSwift

class WBDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var getWord: String!
    var getDetail: String!
    var getImageData: Data!
    var getId: Int!
    var pickImage: UIImage!
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTextView.text = getDetail
        self.detailTextView.isEditable = false
        wordLabel.text = getWord
        let image = UIImage(data: getImageData)
        detailImage.image = image
        
        detailTextView.layer.borderColor = UIColor.black.cgColor
        detailTextView.layer.borderWidth = 2.0
        detailTextView.tintColor = UIColor.red
        
        let keyboardToorBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        keyboardToorBar.barStyle = UIBarStyle.default
        keyboardToorBar.sizeToFit()
        
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let endButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.endTapped))
        keyboardToorBar.items = [spacer, endButton]
        detailTextView.inputAccessoryView = keyboardToorBar
        
    }
    @objc func endTapped() {
        self.view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func tapImageButton(_ sender: Any) {
        performSegue(withIdentifier: "image", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "image") {
            let ImageVC: WBImageViewController = (segue.destination as? WBImageViewController)!
            
            ImageVC.getImage = getImageData
        }
    }
    
    @IBAction func editButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Edit", message: "It is possible to edit", preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(buttonOk)
        self.present(alert, animated: true, completion: nil)
        detailTextView.isEditable = true
    }
    
    @IBAction func updateButton(_ sender: Any) {
        detailTextView.isEditable = false
        if detailImage.image == pickImage {
            let pickData = pickImage!.pngData()
            let realm = try! Realm()
            let editObj = WBWordObject()
            editObj.imageData = pickData!
            editObj.wordName = getWord
            editObj.wordDetail = detailTextView.text
            editObj.id = getId
            try! realm.write {
                realm.add(editObj, update: true)
            }
        }else{
            let realm = try! Realm()
            let editObj = WBWordObject()
            editObj.wordName = getWord
            editObj.imageData = getImageData
            editObj.wordDetail = detailTextView.text
            editObj.id = getId
            try! realm.write {
                realm.add(editObj, update: true)
            }
        }
        let alert = UIAlertController(title: "Update", message: "Edit has been updated", preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(buttonOk)
        
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func imageChangeButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerView = UIImagePickerController()
            pickerView.sourceType = .photoLibrary
            pickerView.delegate = self
            self.present(pickerView, animated: true)
            
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        pickImage = image
        self.detailImage.image = pickImage
        self.dismiss(animated: true, completion: nil)
        
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

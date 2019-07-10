//
//  WBFavoriteListViewController.swift
//  WordBook
//
//  Created by summer on 2019/7/9.
//  Copyright © 2019 summer. All rights reserved.
//

import UIKit
import RealmSwift

class WBFavoriteListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate  {

    var favList: [WBFavoriteObject] = []
    var selectFavWord: String!
    var selectFavDetail: String!
    var selectFavImage: Data!
    
    @IBOutlet weak var favListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favListTableView.delegate = self
        favListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let realm = try! Realm()
        let favObj = realm.objects(WBFavoriteObject.self)
        favList = []
        favObj.forEach { (favWord) in
            favList.append(favWord)
        }
        favListTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! WBFavoriteTableViewCell
        cell.favWordNameLabel.text = favList[indexPath.row].favName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let destructiveAction = UIContextualAction(style: .destructive, title: "") { (action, view, completiton) in
            
            let realm = try! Realm()
            try! realm.write {
                realm.delete(self.favList[indexPath.row])
            }
            completiton(true)
        }
        destructiveAction.image = UIImage(named: "dustBox")
        
        let configuration = UISwipeActionsConfiguration(actions: [destructiveAction])
        return configuration
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectFavWord = favList[indexPath.row].favName
        selectFavImage = favList[indexPath.row].favImage
        
        performSegue(withIdentifier: "toFavDetail", sender: favList[indexPath.row].favDetail)
        favListTableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toFavDetail") {
            let favDetailVC: WBFavoriteDetailViewController = (segue.destination as? WBFavoriteDetailViewController)!
            favDetailVC.getFavDetail = (sender as! String)
            favDetailVC.getFavWord = selectFavWord
            favDetailVC.getFavImageData = selectFavImage
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

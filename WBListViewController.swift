//
//  WBListViewController.swift
//  WordBook
//
//  Created by summer on 2019/7/9.
//  Copyright © 2019 summer. All rights reserved.
//

import UIKit
import RealmSwift

class WBListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating  {

    var myWordList: [WBWordObject] = []
    var selectWord: String!
    var selectImage: Data!
    var selectId: Int!
    
    var searchController = UISearchController()
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    
    
    
    //    private var cellHeights: [CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        listTableView.delegate = self
        listTableView.dataSource = self
        searchSet()
        definesPresentationContext = true
        
        
    }
    func searchSet() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
    }
    func updateSearchResults(for SearchController: UISearchController) {
        let predicate = NSPredicate(format: "wordName CONTAINS %@", searchController.searchBar.text!)
        let realm = try! Realm()
        let wordObj = realm.objects(WBWordObject.self).filter(predicate)
        myWordList = []
        wordObj.forEach { (word) in
            myWordList.append(word)
        }
        listTableView.reloadData()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        let realm = try! Realm()
        let wordObj = realm.objects(WBWordObject.self)
        myWordList = []
        wordObj.forEach { (word) in
            myWordList.append(word)
        }
        listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! WBListTableViewCell
        cell.wordNameLabel.text = myWordList[indexPath.row].wordName
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myWordList.count
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal, title: "check") { (action, view, completionHandler) in
            
            let realm = try! Realm()
            let favWord = realm.objects(WBFavoriteObject.self).sorted(byKeyPath: "id", ascending: false)
            var addId: Int = 1
            if favWord.count > 0 {
                addId = favWord[0].id + 1
            }
            let addFavoWord = WBFavoriteObject()
            addFavoWord.id = addId
            addFavoWord.favName = self.myWordList[indexPath.row].wordName
            addFavoWord.favDetail = self.myWordList[indexPath.row].wordDetail
            addFavoWord.favImage = self.myWordList[indexPath.row].imageData
            
            try! realm.write {
                realm.add(addFavoWord, update: true)
            }
            let alert = UIAlertController(title: "Success", message: "Registered in CheckList", preferredStyle: .alert)
            let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(buttonOk)
            
            self.present(alert, animated: true, completion: nil)
            
            
            completionHandler(true)
        }
        favoriteAction.image = UIImage(named: "favorite")
        favoriteAction.backgroundColor = UIColor.darkGray
        
            let destructiveAction = UIContextualAction(style: .destructive, title: "delete") { (action, view, completionHandler) in
                let realm = try! Realm()
                try! realm.write {
                    realm.delete(self.myWordList[indexPath.row])
                }
                
                completionHandler(true)
            }

        
        destructiveAction.image = UIImage(named: "dustBox")
        
        let configuration = UISwipeActionsConfiguration(actions: [favoriteAction, destructiveAction])
        return configuration
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectWord = myWordList[indexPath.row].wordName
        
        selectImage = myWordList[indexPath.row].imageData
        
        selectId = myWordList[indexPath.row].id
        
        
        
        
        performSegue(withIdentifier: "toDetailViewController", sender: myWordList[indexPath.row].wordDetail)
        
        listTableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetailViewController") {
            let detailVC : WBDetailViewController = (segue.destination as? WBDetailViewController)!
            detailVC.getDetail = (sender as! String)
            detailVC.getWord = selectWord
            detailVC.getImageData = selectImage
            detailVC.getId = selectId
            
            
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

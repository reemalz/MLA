//
//  SearchTableViewCell.swift
//  MLA1
//
//  Created by njoool  on 19/11/2017.
//  Copyright © 2017 njoool . All rights reserved.
//

import UIKit
import Firebase
class SearchViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchBarDelegate{
    
    
    
    @IBOutlet weak var Header: UINavigationItem!
    @IBOutlet var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    let userID = Auth.auth().currentUser?.uid
    var ref : DatabaseReference!
    var dbHandle:DatabaseHandle?
    var usersArray=[String:Any]()
    var filteredUsers=[String:Any]()
    var usersArrayN=[NSDictionary?]()
    var filteredUsersN=[NSDictionary?]()
    var id = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        self.searchController.searchBar.barTintColor = UIColor.darkGray
        self.tableView.register(UITableViewCell.self , forCellReuseIdentifier: "recell")
        tableView.delegate = self
        tableView.dataSource = self
        
        //set database ref
        ref = Database.database().reference()
        dbHandle = ref?.child("Users").queryOrdered(byChild: "Username").observe(.value, with: { (snapshot) in
            if let getData = snapshot.value as? [String:Any] {
                self.usersArray=getData
                self.tableView.reloadData()
                self.filteredUsers = self.usersArray
            }
            else{print("oooppps!!!!!")}
            
            for (key,value) in self.usersArray{
                var user=value as! NSDictionary
                    self.usersArrayN.append(user)
            }
            
            for (key,value) in self.filteredUsers{
                var user=value as! NSDictionary
                self.filteredUsersN.append(user)
            }})
        
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != ""{
            return filteredUsersN.count
        }
        else{
            return self.usersArrayN.count}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! SearchTableViewCell
        let user : NSDictionary?
        
        if searchController.isActive && searchController.searchBar.text != ""{
            
            user = filteredUsersN[indexPath.row]
        }
        else
        {
            user = self.usersArrayN[indexPath.row]
        }
        
        
        cell.Title?.text = user?["Username"] as? String
        cell.details?.text = user?["Email"] as? String
        if let pic=user?["Pic"] as? String{
            let url=URL(string:pic)
            cell.Pic?.setImageWith(url!)}
        return(cell)
    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        var i:Int=0
        if searchController.searchBar.text == "" {
            filteredUsers=usersArray
            filteredUsersN=usersArrayN
            self.tableView.reloadData()
        } else {
            self.filteredUsers = self.usersArray.filter{ user in
                let username = usersArrayN[i]!["Username"] as! String
                i = 1+i
                return(username.lowercased().contains(searchController.searchBar.text!.lowercased()))
            }
            filteredUsersN=[NSDictionary]()
            for (key,value) in filteredUsers{
                var user=value as! NSDictionary
                filteredUsersN.append(user)
                
            }
            self.tableView.reloadData()
        }
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let cell=tableView.cellForRow(at:indexPath) as! SearchTableViewCell
        let user = filteredUsersN[indexPath.row]
        if( (user!["UID"] as! String) == (userID!)){
            performSegue(withIdentifier:"tab", sender:SearchTableViewCell())
        }
        else {
            self.id = indexPath.row
            performSegue(withIdentifier:"profile", sender:SearchTableViewCell())}
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier=="tab"{
                    let tabbarController = segue.destination as! UITabBarController
                    tabbarController.selectedIndex = 3
                    
 //                   let vc = self.storyboard?.instantiateViewController(withIdentifier: "tab")
   //                  self.present(vc!, animated: true, completion: nil)
                    
                }
                else if segue.identifier=="profile"{
                    let user = self.usersArrayN[self.id]
                let controller = segue.destination as! ProfilePageViewController
                    controller.WantedUser = user!}
                
        
        
    }
}




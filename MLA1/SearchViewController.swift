//
//  SearchTableViewCell.swift
//  MLA1
//
//  Created by njoool  on 19/11/2017.
//  Copyright © 2017 njoool . All rights reserved.
//

import UIKit
import Firebase
import Foundation

class SearchViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchBarDelegate{
    let imageURL:String="https://image.tmdb.org/t/p/w500"
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
    var Movieresults=[NSDictionary?]()
    var id = Int()
    let movie = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&query")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSearchResultsAPI( movie: movie!)
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
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {return 1}
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != ""{
            return self.Movieresults.count
        }
        else{return self.usersArrayN.count}
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! SearchTableViewCell
        let user : NSDictionary?

        if searchController.isActive && searchController.searchBar.text != ""{
            user = self.Movieresults[indexPath.row]

        }
        else
        {
            user = self.usersArrayN[indexPath.row]
        }
        
        cell.Title?.text = user?["original_title"] as? String
        
        if let pic=user!["poster_path"] as? String{
        let url=URL(string:imageURL+pic)
            cell.Pic.setImageWith(url!)}
        cell.index=indexPath.row
        let tag=user!["id"] as! Int
            cell.id=tag
        return(cell)
        
        
        //    cell.Title?.text = user?["Username"] as? String
        //   cell.details?.text = user?["Email"] as? String
    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text != "" {
            let search = (searchController.searchBar.text!.lowercased()).replacingOccurrences(of: " ", with: "+") as String
            updateSearchResultsAPI( movie: URL(string: "https://api.themoviedb.org/3/search/movie?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&query=\(search)")!
            )
    //        self.tableView.reloadData()
        }
        
 
 }
    
    func updateSearchResultsAPI(movie: URL) {
        let task = URLSession.shared.dataTask(with: movie){ data,respons,error in
            if error != nil
            {print ("ERROR")}
            else{
                self.Movieresults=[NSDictionary]()
                if let content = data{
                    do
                    { let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let movies=myJson["results"] as? [NSDictionary]
                        {self.Movieresults = movies
                                  DispatchQueue.main.async {
                                     self.tableView.reloadData()}
                        }}
                    catch{}
                    
                }}}
        task.resume()
    }
    
    
  //////////////////////////////////////// go to movie page ///////////////////////////////////
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier:"chosenMovie", sender:SearchTableViewCell())
        }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier=="chosenMovie"{
                    let page=segue.destination as! MoviePageViewController
                    let cell=sender as! SearchTableViewCell
                    let object = self.Movieresults[cell.index]
                    page.id=object!["id"] as! Int}
        
        }
}




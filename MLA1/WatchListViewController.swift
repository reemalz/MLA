//
//  WatchListViewController.swift
//  MLA1
//
//  Created by user2 on ١١ صفر، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ njoool . All rights reserved.
//

import UIKit

class WatchListViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier:"cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    
   // var WatchList = [String]()
   var WatchList = ["a","b","c"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (WatchList.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)
            /*UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = WatchList[indexPath.row]*/
        
        cell.backgroundColor = UIColor.black
        return(cell)
    }
    



}

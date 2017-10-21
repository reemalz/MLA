//
//  MainPageViewController.swift
//  MLA1
//
//  Created by rano2 on 10/22/17.
//  Copyright © 2017 njoool . All rights reserved.
//

//
//  MainPageController.swift
//  MLA
//
//  Created by njoool  on 10/12/17.
//  Copyright © 2017 njoool . All rights reserved.
//

import UIKit
import AFNetworking
class MainPageController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var Action: UICollectionView!
    @IBOutlet weak var Drama: UICollectionView!
    @IBOutlet weak var Horror: UICollectionView!
    @IBOutlet weak var Documentray: UICollectionView!
    @IBOutlet weak var Adventure: UICollectionView!
    @IBOutlet weak var Mystery: UICollectionView!
    /////////////////////////////////////////////
    let imageURL:String="https://image.tmdb.org/t/p/w500"
    var DramaResult:NSArray=[]; var ActionResult:NSArray=[]; var HorrorResult:NSArray=[]
    var AdventureResult:NSArray=[]; var DocumentrayResult:NSArray=[]; var MysteryResult:NSArray=[]
    let action_url = URL(string: "https://api.themoviedb.org/3/genre/28/movies?sort_by=created_at.asc&include_adult=false&language=en-US&api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
    let Drama_url = URL(string: "https://api.themoviedb.org/3/genre/18/movies?sort_by=created_at.asc&include_adult=false&language=en-US&api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
    let Horror_url = URL(string: "https://api.themoviedb.org/3/genre/27/movies?sort_by=created_at.asc&include_adult=false&language=en-US&api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
    let Documentary_url = URL(string: "https://api.themoviedb.org/3/genre/99/movies?sort_by=created_at.asc&include_adult=false&language=en-US&api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
    let Adventure_url = URL(string: "https://api.themoviedb.org/3/genre/12/movies?sort_by=created_at.asc&include_adult=false&language=en-US&api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
    let Mystery_url = URL(string: "https://api.themoviedb.org/3/genre/9648/movies?sort_by=created_at.asc&include_adult=false&language=en-US&api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Drama.delegate=self
        Drama.dataSource=self
        Action.delegate=self
        Action.dataSource=self
        Horror.delegate=self
        Horror.dataSource=self
        Documentray.delegate=self
        Documentray.dataSource=self
        Adventure.delegate=self
        Adventure.dataSource=self
        Mystery.delegate=self
        Mystery.dataSource=self
        
        /////////Action posters////////////////
        
        
        let task = URLSession.shared.dataTask(with:action_url!) { (data, response, error) in
            if error != nil
            {print ("ERROR")}
            else{
                if let content = data{
                    do
                    { let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let movies = myJson["results"] as? NSArray
                            
                        {self.setAction(data: movies)}}
                    catch{}
                }}}
        task.resume()
        //////////////Drama posters////////////
        let task2 = URLSession.shared.dataTask(with:Drama_url!) { (data2, response2, error2) in
            if error2 != nil
            {print ("ERROR")}
            else{
                if let content2 = data2{
                    do
                    { let myJson2 = try JSONSerialization.jsonObject(with: content2, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let movies2 = myJson2["results"] as? NSArray
                            
                        {self.setDrama(data: movies2)}}
                    catch{}
                }}}
        task2.resume()
    
    ////////////////Horror posters//////////////
        let task3 = URLSession.shared.dataTask(with:Horror_url!) { (data3, response3, error3) in
            if error3 != nil
            {print ("ERROR")}
            else{
                if let content3 = data3{
                    do
                    { let myJson3 = try JSONSerialization.jsonObject(with: content3, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let movies3 = myJson3["results"] as? NSArray
                        {self.setHorror(data: movies3)}}
                    catch{}
                }}}
        task3.resume()
    ////////////////Documentray posters//////////////
        let task4 = URLSession.shared.dataTask(with:Documentary_url!) { (data4, response4, error4) in
            if error4 != nil
            {print ("ERROR")}
            else{
                if let content4 = data4{
                    do
                    { let myJson4 = try JSONSerialization.jsonObject(with: content4, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let movies4 = myJson4["results"] as? NSArray
                        {self.setDocumentray(data: movies4)}}
                    catch{}
                }}}
        task4.resume()
    ////////////////Adventure posters//////////////
        let task5 = URLSession.shared.dataTask(with:Adventure_url!) { (data5, response5, error5) in
            if error5 != nil
            {print ("ERROR")}
            else{
                if let content5 = data5{
                    do
                    { let myJson5 = try JSONSerialization.jsonObject(with: content5, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let movies5 = myJson5["results"] as? NSArray
                        {self.setAdventure(data: movies5)}}
                    catch{}
                }}}
        task5.resume()
        
    ////////////////Mystery posters//////////////
        let task6 = URLSession.shared.dataTask(with:Mystery_url!) { (data6, response6, error6) in
            if error6 != nil
            {print ("ERROR")}
            else{
                if let content6 = data6{
                    do
                    { let myJson6 = try JSONSerialization.jsonObject(with: content6, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let movies6 = myJson6["results"] as? NSArray
                        {self.setMystery(data:movies6)}}
                    catch{}
                }}}
        task6.resume()
    ///////////////////////////////////// end of viewDidLoad
    }
    override func viewWillAppear(_ animated: Bool) {
        scrollView.delegate=self
        scrollView.isScrollEnabled=true
        scrollView.contentSize.height=2050
        scrollView.contentSize.width=500
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {return 15}
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {return 1}
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.Action{
            let cell:CollectionViewCell=collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
            let movie=self.ActionResult[indexPath.row] as! NSDictionary
             let movie_P=movie["poster_path"] as! String
             let url=URL(string:imageURL+movie_P)
            cell.pImage.setImageWith(url!)
             let tag=movie["id"] as! Int
             cell.pImage.tag=tag
            return cell}
        else if  collectionView == self.Drama{
            let cell:CollectionViewCell2=collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewCell2
            let movie=self.DramaResult[indexPath.row] as! NSDictionary
             let movie_P=movie["poster_path"] as! String
             let url=URL(string:imageURL+movie_P)
             cell.pImage.setImageWith(url!)
             let tag=movie["id"] as! Int
             cell.pImage.tag=tag
            return cell }
        else if collectionView == self.Horror{
            let cell:CollectionViewCell3=collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! CollectionViewCell3
            let movie=self.HorrorResult[indexPath.row] as! NSDictionary
            let movie_P=movie["poster_path"] as! String
            let url=URL(string:imageURL+movie_P)
            cell.pImage.setImageWith(url!)
            let tag=movie["id"] as! Int
            cell.pImage.tag=tag
            return cell}
            
        else  if collectionView == self.Documentray{
            let cell:CollectionViewCell4=collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath) as! CollectionViewCell4
            let movie=self.DocumentrayResult[indexPath.row] as! NSDictionary
            let movie_P=movie["poster_path"] as! String
            let url=URL(string:imageURL+movie_P)
            cell.pImage.setImageWith(url!)
            let tag=movie["id"] as! Int
            cell.pImage.tag=tag
            return cell}
            
        else if collectionView == self.Adventure{
            let cell:CollectionViewCell5=collectionView.dequeueReusableCell(withReuseIdentifier: "cell5", for: indexPath) as! CollectionViewCell5
            let movie=self.AdventureResult[indexPath.row] as! NSDictionary
            let movie_P=movie["poster_path"] as! String
            let url=URL(string:imageURL+movie_P)
            cell.pImage.setImageWith(url!)
            let tag=movie["id"] as! Int
            cell.pImage.tag=tag
            return cell}
        else  {
            let cell:CollectionViewCell6=collectionView.dequeueReusableCell(withReuseIdentifier: "cell6", for: indexPath) as! CollectionViewCell6
            let movie=self.MysteryResult[indexPath.row] as! NSDictionary
            let movie_P=movie["poster_path"] as! String
            let url=URL(string:imageURL+movie_P)
            cell.pImage.setImageWith(url!)
            let tag=movie["id"] as! Int
            cell.pImage.tag=tag
            return cell}
    }
    func setAction(data:NSArray){self.ActionResult=data}
    func setDrama (data:NSArray){self.DramaResult=data}
    func setDocumentray (data:NSArray){self.DocumentrayResult=data}
    func setAdventure (data:NSArray){self.AdventureResult=data}
    func setMystery (data:NSArray){self.MysteryResult=data}
    func setHorror (data:NSArray){self.HorrorResult=data}
    
    
}


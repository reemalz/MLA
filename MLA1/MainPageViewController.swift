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
    var DramaResult:[NSDictionary] = []; var ActionResult:[NSDictionary] = [];
    var HorrorResult:[NSDictionary] = []; var AdventureResult:[NSDictionary] = [];
    var DocumentrayResult:[NSDictionary] = []; var MysteryResult:[NSDictionary] = [];
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
LoadAction()
//////////////Drama posters////////////
LoadDrama()
////////////////Horror posters//////////////
LoadHorror()
////////////////Documentray posters//////////////
LoadDocumentray()
////////////////Adventure posters//////////////
LoadAdventure()
////////////////Mystery posters//////////////
LoadMystery()
    ///////////////////////////////////// end of viewDidLoad
    }
    override func viewWillAppear(_ animated: Bool) {
        scrollView.delegate=self
        scrollView.isScrollEnabled=true
        scrollView.contentSize.height=2050
        scrollView.contentSize.width=500
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { if collectionView == Action{return ActionResult.count}
    else if collectionView == Drama {return DramaResult.count}
    else if collectionView == Horror{return HorrorResult.count}
    else if collectionView == Documentray {return DocumentrayResult.count}
    else if collectionView == Adventure {return AdventureResult.count}
    else{ return MysteryResult.count}
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {return 1}
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.Action{
            let cell:CollectionViewCell=collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
            let movie=self.ActionResult[indexPath.row]
             let movie_P=movie["poster_path"] as! String
             let url=URL(string:imageURL+movie_P)
            cell.pImage.setImageWith(url!)
             let tag=movie["id"] as! Int
                cell.pImage.tag=tag
            return cell}
        else if  collectionView == self.Drama{
            let cell:CollectionViewCell2=collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewCell2
            let movie=self.DramaResult[indexPath.row]
             let movie_P=movie["poster_path"] as! String
             let url=URL(string:imageURL+movie_P)
             cell.pImage.setImageWith(url!)
             let tag=movie["id"] as! Int
                cell.pImage.tag=tag
            return cell }
        else if collectionView == self.Horror{
            let cell:CollectionViewCell3=collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! CollectionViewCell3
            let movie=self.HorrorResult[indexPath.row]
            let movie_P=movie["poster_path"] as! String
            let url=URL(string:imageURL+movie_P)
            cell.pImage.setImageWith(url!)
            let tag=movie["id"] as! Int
            cell.pImage.tag=tag
            return cell}
            
        else  if collectionView == self.Documentray{
            let cell:CollectionViewCell4=collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath) as! CollectionViewCell4
            let movie=self.DocumentrayResult[indexPath.row]
            let movie_P=movie["poster_path"] as! String
            let url=URL(string:imageURL+movie_P)
            cell.pImage.setImageWith(url!)
            let tag=movie["id"] as! Int
            cell.pImage.tag=tag
            return cell}
            
        else if collectionView == self.Adventure{
            let cell:CollectionViewCell5=collectionView.dequeueReusableCell(withReuseIdentifier: "cell5", for: indexPath) as! CollectionViewCell5
            let movie=self.AdventureResult[indexPath.row]
           let movie_P=movie["poster_path"] as! String
            let url=URL(string:imageURL+movie_P)
            cell.pImage.setImageWith(url!)
            let tag=movie["id"] as! Int
            cell.pImage.tag=tag
            return cell}
        else  {
            let cell:CollectionViewCell6=collectionView.dequeueReusableCell(withReuseIdentifier: "cell6", for: indexPath) as! CollectionViewCell6
            let movie=self.MysteryResult[indexPath.row]
            let movie_P=movie["poster_path"] as! String
            let url=URL(string:imageURL+movie_P)
            cell.pImage.setImageWith(url!)
            let tag=movie["id"] as! Int
            cell.pImage.tag=tag
            return cell}
        
    }
    
    func LoadAction() {
        let task = URLSession.shared.dataTask(with: action_url!){ data,respons,error in
            if error != nil
            {print ("ERROR")}
            else{
                if let content = data{
                    do
                    { let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let movies=myJson["results"] as? [NSDictionary]
                        {self.ActionResult = movies
                       DispatchQueue.main.async {self.Action.reloadData()}}}
                    catch{}
                    
                }}}
        task.resume()}
    
   func LoadDrama() {
        let task = URLSession.shared.dataTask(with: Drama_url!){ data,respons,error in
            if error != nil
            {print ("ERROR")}
            else{
                if let content = data{
                    do
                    { let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let movies=myJson["results"] as? [NSDictionary]
                        {self.DramaResult=movies
                            DispatchQueue.main.async { self.Drama.reloadData()}
                        }}
                    catch{}
                    
                }}}
        task.resume()}
    
    func LoadHorror() {
        let task = URLSession.shared.dataTask(with: Horror_url!){ data,respons,error in
            if error != nil
            {print ("ERROR")}
            else{
                if let content = data{
                    do
                    { let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let movies=myJson["results"] as? [NSDictionary]
                        {
                            self.HorrorResult=movies
                            DispatchQueue.main.async { self.Horror.reloadData()}
                        }}
                    catch{}
                    
                }}}
        task.resume()}
    
    
    func LoadDocumentray() {
        let task = URLSession.shared.dataTask(with: Documentary_url!){ data,respons,error in
            if error != nil
            {print ("ERROR")}
            else{
                if let content = data{
                    do
                    { let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let movies=myJson["results"] as? [NSDictionary]
                        {
                            self.DocumentrayResult=movies
                            DispatchQueue.main.async { self.Documentray.reloadData()}}}
                    catch{}
                    
                }}}
        task.resume()}
    
    func LoadAdventure() {
        let task = URLSession.shared.dataTask(with: Adventure_url!){ data,respons,error in
            if error != nil
            {print ("ERROR")}
            else{
                if let content = data{
                    do
                    { let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let movies=myJson["results"] as? [NSDictionary]
                        {
                            self.AdventureResult=movies
                            DispatchQueue.main.async { self.Adventure.reloadData()}}}
                    catch{}
                    
                }}}
        task.resume()}
    
    func LoadMystery() {
        let task = URLSession.shared.dataTask(with: Mystery_url!){ data,respons,error in
            if error != nil
            {print ("ERROR")}
            else{
                if let content = data{
                    do
                    { let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let movies=myJson["results"] as? [NSDictionary]
                        {
                            self.MysteryResult=movies
                            DispatchQueue.main.async { self.Mystery.reloadData()}}}
                    catch{}
                    
                }}}
        task.resume()}
    
    
   /* func setAction(data:[NSDictionary]){self.ActionResult=data}
   func setDrama (data:[NSDictionary]){self.DramaResult=data}
   func setDocumentray (data:NSArray){self.DocumentrayResult=data}
    func setAdventure (data:NSArray){self.AdventureResult=data}
   func setMystery (data:NSArray){self.MysteryResult=data}
    func setHorror (data:NSArray){self.HorrorResult=data}*/
    
    
}


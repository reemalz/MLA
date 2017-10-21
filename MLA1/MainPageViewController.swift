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
import Alamofire
import AlamofireImage
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
        
        //////////////Drama posters////////////
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scrollView.delegate=self
        scrollView.isScrollEnabled=true
        scrollView.contentSize.height=2050
        scrollView.contentSize.width=500
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {return 10}
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {return 1}
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.Action{
            let cell:CollectionViewCell=collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
            /*let movie=self.ActionResult[indexPath.row] as! NSDictionary
             let movie_P=movie["poster_path"] as! String
             let url=URL(string:imageURL+movie_P)
             cell.pImage.af_setImage(withURL:url!)
             let tag=movie["id"] as! Int
             cell.pImage.tag=tag*/
            return cell}
        else if  collectionView == self.Drama{
            let cell:CollectionViewCell2=collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewCell2
            
            /*let movie=self.ActionResult[indexPath.row] as! NSDictionary
             let movie_P=movie["poster_path"] as! String
             let url=URL(string:imageURL+movie_P)
             cell.pImage.af_setImage(withURL:url!)
             let tag=movie["id"] as! Int
             cell.pImage.tag=tag*/
            return cell }
        else if collectionView == self.Horror{
            let cell:CollectionViewCell3=collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! CollectionViewCell3
            return cell}
            
        else  if collectionView == self.Documentray{
            let cell:CollectionViewCell4=collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath) as! CollectionViewCell4
            return cell}
            
        else if collectionView == self.Adventure{
            let cell:CollectionViewCell5=collectionView.dequeueReusableCell(withReuseIdentifier: "cell5", for: indexPath) as! CollectionViewCell5
            return cell}
        else  {
            let cell:CollectionViewCell6=collectionView.dequeueReusableCell(withReuseIdentifier: "cell6", for: indexPath) as! CollectionViewCell6
            return cell}
    }
    func setAction(data:NSArray){self.ActionResult=data}
    func setDrama (data:NSArray){self.DramaResult=data}
    func setDocumentray (data:NSArray){self.DramaResult=data}
    func setAdventure (data:NSArray){self.AdventureResult=data}
    func setMystery (data:NSArray){self.MysteryResult=data}
    func setHorror (data:NSArray){self.HorrorResult=data}
    
    
}


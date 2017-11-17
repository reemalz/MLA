//
//  MoviePageViewController.swift
//  MLA1
//
//  Created by user2 on ٩ صفر، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ njoool . All rights reserved.
//

import UIKit
import AFNetworking
import FirebaseDatabase
import FirebaseAuth

class MoviePageViewController:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet var RatingStars: [UIButton]!
    var id=Int();//movie ID
    var Curl2=URL(string:"")
    var Movie_Cast:[NSDictionary] = [];
    var title1:String?
    var Rate:Int=0
    var mPoster=String()
    var dbHandle:DatabaseHandle!
    @IBOutlet weak var mName: UILabel!
    let image:String="https://image.tmdb.org/t/p/w500"
    @IBOutlet weak var Poster: UIImageView!
    @IBOutlet weak var Plot: UILabel!
    @IBOutlet weak var Cast_result: UICollectionView!
    let ref : DatabaseReference! = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    @IBOutlet var StatusView: UIView!
    @IBOutlet weak var AddB: UIButton!
    var keys = [String]();

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dbHandle = ref?.child("Watchlists/Users/\(userID!)").observe(.value, with: { (snapshot) in
            if let data = snapshot.value as? [String:Any]
            {
                for (key,value) in data{
                    self.keys.append(key)}
                if let movie=data["\(self.id)"] as? NSDictionary{
                    
                    self.AddB.backgroundColor=UIColor.lightGray
                    if (movie["Status"]as?String)=="Completed"{
                        self.AddB.setTitle("Completed", for: .normal)}
                    else {self.AddB.setTitle("Plan to Watch", for: .normal)}
                    let rate=movie.value(forKey:"Rate") as? String
                    let isEqual = ((rate == "-") || (rate == "0") || (rate == nil))
                    if (isEqual == false){
                        let m=Int(rate!)
                        for star in self.RatingStars {
                            if star.tag <= m!{
                                star .setTitle("★", for: UIControlState.normal )}
                            else {star .setTitle("☆", for: UIControlState.normal )}
                            
                        }}
                    
                }
            }})
        
        
    }
    
    /////////////////// page//////////////
    override func viewDidAppear(_ animated: Bool) {
        Cast_result.delegate=self
        Cast_result.dataSource=self
        /////////////////////// loading the movie's data /////////////////////
        let Murl = URL(string:"https://api.themoviedb.org/3/movie/\(id)?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")
        if id != 0 {
        let task = URLSession.shared.dataTask(with:Murl!){ data,respons,error in
            if error != nil
            {print ("ERROR")}
            else{
                if let content = data{
                    do
                    { let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        DispatchQueue.main.async{self.mName.text=(myJson["original_title"] as! String)}
                        let pPath=myJson["poster_path"] as! String
                        self.mPoster=pPath
                        let purl=URL(string:self.image+pPath)
                        DispatchQueue.main.async {self.Poster.setImageWith(purl!)}
                        self.title1=myJson["original_title"] as? String
                        DispatchQueue.main.async { self.Plot.text=myJson["overview"] as? String}
                        }
                    catch{}}}}
               task.resume()
        /////////////////// Loading the cast data ///////////////////////////
         Curl2 = URL(string:"https://api.themoviedb.org/3/movie/\(id)/credits?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
            let task2 = URLSession.shared.dataTask(with:Curl2!){ data,respons,error in
                if error != nil
                {print ("ERROR")}
                else{
                    if let content = data{
                        do
                        { let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            DispatchQueue.main.async{
                                if let mCast=myJson["cast"] as? [NSDictionary]
                                {self.Movie_Cast=mCast
                                DispatchQueue.main.async { self.Cast_result.reloadData()}}}}
                        catch{}}}}
            task2.resume()
        }
        else {print("error!!")}

        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("movie count \(Movie_Cast.count)")
        return Movie_Cast.count}
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CollectionViewCell7=collectionView.dequeueReusableCell(withReuseIdentifier: "cell7", for: indexPath) as! CollectionViewCell7
        let actor=self.Movie_Cast[indexPath.row]
        let actor_name=actor["name"] as! String
        cell.Cast_name.text=actor_name
        if  let actor_img=actor["profile_path"] as? String{
        let url=URL(string:image+actor_img)
        cell.pImage.setImageWith(url!)
        }
        return cell
    }
    
    ///////////////// Rate action///////////////
    @IBAction func RateMovie(_ sender: UIButton) {
        self.Rate = sender.tag
        
        for star in RatingStars {
            if star.tag<=self.Rate{
                star .setTitle("★", for: UIControlState.normal )}
            else{star .setTitle("☆", for: UIControlState.normal )}} }

////////////////////// add watch-list btn/////////////////

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        StatusView.removeFromSuperview()
    }
    
    
    func open() {
       self.view.addSubview(StatusView)
        StatusView.center = self.view.center
    }

    @IBAction func Plan(_ sender: Any) {
        self.AddB.backgroundColor = UIColor.lightGray
        AddB.setTitle("Plan to Watch", for: .normal)
        StatusView.removeFromSuperview()
      
        //add the movie to the current users's watchlist
        ref.child("Watchlists").child("Users").child(userID!).child("\(id)").setValue(["Title":title1!, "Status": "Plan to Watch","Rate": String(self.Rate), "Poster":(image+mPoster)])
    }
    
    @IBAction func Complete(_ sender: Any) {
        self.AddB.backgroundColor = UIColor.lightGray
        AddB.setTitle("Complete", for: .normal)
        StatusView.removeFromSuperview()
       
                print("hellloooooo im current user")
        self.ref.child("Watchlists").child("Users").child(userID!).child("\(self.id)").setValue(["Title":self.title1!, "Status": "Completed", "Rate": String(self.Rate),"Poster":(image+mPoster)])
    }
    

    
    @IBAction func OpenStatus(_ sender: UIButton) {
        open()
    }
    





}


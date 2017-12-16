//
//  Top50ViewController.swift
//  MLA1
//
//  Created by user2 on ١٠ ربيع١، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ njoool . All rights reserved.
//

import UIKit
import AFNetworking

class Top20ViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource {
    
    @IBOutlet weak var CollectionView: UICollectionView!
    var movies1:[NSDictionary] = []
    let page1 = URL(string:"https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")
    let imageURL:String="https://image.tmdb.org/t/p/w500"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CollectionView.delegate = self
        self.CollectionView.dataSource = self
        //***********************
        let task = URLSession.shared.dataTask(with: page1!){data,respons,error in
            if error != nil
            {print ("ERROR")}
            else{
                if let content = data{
                    do
                    { let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let movies=myJson["results"] as? [NSDictionary]
                        {self.movies1 = movies
                            DispatchQueue.main.async {self.CollectionView.reloadData()}}}
                    catch{}
                    
                }}}
        task.resume()
        
        //*********************
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCell", for: indexPath) as! Top20CollectionCell
        let m=self.movies1[indexPath.row] as! NSDictionary
        var poster = m["poster_path"] as?String
        if (poster != nil){
            let url = URL(string:imageURL+poster!)
            cell.ImgView.setImageWith(url!)
            cell.id = m["id"] as! Int
        }
        else{
        }
        //  let poster = m["poster_path"] as! String
        //  print(poster);
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier:"top" , sender:(Any).self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movie = segue.destination as! MoviePageViewController
        if  let cell = sender as? Top20CollectionCell {movie.id=cell.id}
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


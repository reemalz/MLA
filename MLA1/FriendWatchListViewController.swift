




import UIKit
import AFNetworking
import FirebaseDatabase
import FirebaseAuth

class FriendWatchListViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{


    @IBOutlet weak var tableView: UITableView!
    var WantedUser = NSDictionary()
    var ref : DatabaseReference!
    var dbHandle:DatabaseHandle?
    var user_movies=[String:Any]()
    var keys = [String]();
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier:"cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        //set database ref
        ref = Database.database().reference()
        
        //retrieve movies in user's watchlist and listen for changes
        let userID=WantedUser["UID"] 
        dbHandle = ref?.child("Watchlists/Users/\(userID!)").observe(.value, with: { (snapshot) in
            if let getData = snapshot.value as? [String:Any] {
                self.user_movies=getData
                for (key,value) in getData{
                    self.keys.append(key)
                }
                // self.keys.sort()
                self.tableView.reloadData()
                
            }
            else{print("oooppps!!!!!")}
        })
    }
    
    
    
    //var WatchList:[NSDictionary] = [];
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user_movies.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! TableViewCellWatchList
        if let data=self.user_movies[keys[indexPath.row]] as? [String:Any]{
            // print("data \(data!["Poster"])")
            let url=URL(string:data["Poster"] as! String)
            cell.pImage.setImageWith(url!)
            cell.Title.text="\((data["Title"])!)"
            cell.Status.text="\((data["Status"])!)"
            if (data["Rate"] as? Int) != 0{
                cell.Your_Rating.text="\((data["Rate"])!)/5"}
            else {cell.Your_Rating.text="-/5"}
            cell.id=Int(keys[indexPath.row])!
        }
        cell.backgroundColor = UIColor.black
        return(cell)
    }
    @IBAction func Redo(_ sender: Any) {
        performSegue(withIdentifier: "RedoProfile", sender: "")
    }
    
    /////////////go to movie page////////////////
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier:"watchF", sender:(Any).self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RedoProfile"{
            let controller = segue.destination as? ProfilePageViewController
            controller?.WantedUser = WantedUser}
        else{ let movie=segue.destination as! MoviePageViewController
            if  let cell = sender as? TableViewCellWatchList{movie.id=cell.id}
        }
    }
}


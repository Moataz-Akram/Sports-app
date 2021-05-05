//
//  FavouritesViewController.swift
//  Sports app
//
//  Created by Moataz on 20/04/2021.
//

import UIKit
import CoreData
import SDWebImage
class FavouritesViewController: UITableViewController {
    var leaguesArray : [Dictionary<String,Any>] = []
    let appDelegatee = UIApplication.shared.delegate as! AppDelegate
    var FavViewModel = FavLeaguesViewModel()
    var leagueIdPressed : String!
    var leagueStrPressed : String!
    var league : LeaugeDetail = LeaugeDetail()
    var leagueD : LeagueDetailsViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        leagueD = LeagueDetailsViewController()
        FavViewModel.bindFavLeaguesWithView = {
            self.didReciveLeague()
        }

    }
    @objc func notify(notification : Notification){
        leaguesArray = []
        FavViewModel.getDataFromCoreData(appDelegate: appDelegatee)
        self.tableView.reloadData()
        print("reload done -------------------------------------")
    }
   override func viewWillAppear(_ animated: Bool) {
    
    
    NotificationCenter.default.addObserver(self, selector: #selector(notify(notification:)), name: .notifyOther, object: nil)
    
    leaguesArray = []
    FavViewModel.getDataFromCoreData(appDelegate: appDelegatee)
    self.tableView.reloadData()
       
    }
  
//    override func viewWillAppear(_ animated: Bool) {
//
//        leaguesArray = []
//        FavViewModel.getDataFromCoreData(appDelegate: appDelegatee)
//        self.tableView.reloadData()
//    }
    func didReciveLeague(){
        self.leaguesArray = self.FavViewModel.FavLeaguesArray!
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leaguesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesCell", for: indexPath) as! FavLeaguesCustomCell
        let x = leaguesArray[indexPath.row]
        cell.youtubeBtn.isHidden = true
        cell.leaguesName.text = x["name"] as? String
        cell.youtube = x["youtube"] as? String
        if let imgStr = x["badge"]{
            cell.badgeImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.badgeImg.sd_setImage(with: URL(string: imgStr as! String), placeholderImage: UIImage(named: "placeholder"))
        }
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.cornerRadius = 15.0
        cell.layer.masksToBounds = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63.0
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let x = leaguesArray[indexPath.row]
        leagueIdPressed = x["id"] as? String
        leagueStrPressed = x["name"] as? String
        league.idLeague = x["id"] as? String
        league.strLeague = x["name"] as? String
        if FavViewModel.isNetworkReachable() {
            performSegue(withIdentifier: "navigateToLeagueDetailFromFav", sender: self)
        }else{
            let alert = UIAlertController(title: "No Internet Connection", message: "Leagues details data not available.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navigateToLeagueDetailFromFav"{
            let leagueDetailScreen = segue.destination as! LeagueDetailsViewController
            leagueDetailScreen.leagueId = leagueIdPressed
            leagueDetailScreen.leagueStr = leagueStrPressed
            leagueDetailScreen.league = self.league
        }
    }
   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let x = leaguesArray[indexPath.row]
            self.leaguesArray.remove(at: indexPath.row)
            FavViewModel.deleteFav(id: x["id"] as! String, appDelegate: appDelegatee)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

}

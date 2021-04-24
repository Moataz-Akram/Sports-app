//
//  LeaguesViewController.swift
//  Sports app
//
//  Created by Moataz on 20/04/2021.
//

import UIKit
import Alamofire
import SDWebImage

class LeaguesViewController: UITableViewController {
    @IBOutlet var searchBar: UITableView!
    let viewModel = AllLeaguesViewModel()
    var leagues = [LeaugeDetail]()
    var leaguesSearch = [LeaugeDetail]()
    var isFiltered = false
    var sport : String = "Soccer"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        viewModel.bindLeaguesToView = {
            self.didReciveLeague()
        }
        viewModel.getAllLeagues(sportName: sport)
    }
    
    func didReciveLeague(){
        leagues = viewModel.leaguesDetailCompleted
        print("from view controller")
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltered {
            return leaguesSearch.count
        }
        return leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaguesCell", for: indexPath) as! LeaugeCustomCell
        
        var league : LeaugeDetail!
        if isFiltered {
            league = leaguesSearch[indexPath.row]
        }else{
            league = leagues[indexPath.row]
        }
        
        cell.leaugeName.text = league.strLeague
        cell.youtubeBtn.isHidden = true
        cell.youtube = league.strYoutube

        if let imgStr = league.strBadge{
            cell.leaugeImage.sd_setImage(with: URL(string: imgStr), placeholderImage: UIImage(named: "placeholder"))
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63.0
    }

}

extension LeaguesViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0{
            isFiltered = false
            tableView.reloadData()
        }else{
            isFiltered = true
            self.leaguesSearch = self.leagues.filter({$0.strLeague!.prefix(searchText.count)==searchText})
            tableView.reloadData()
        }
    }
    
}

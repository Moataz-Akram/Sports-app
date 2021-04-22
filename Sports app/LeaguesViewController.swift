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
    
    var leagues = [League]()

    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request(URLs.allLeaguesURL).validate().responseDecodable(of: LeagueAPI.self) { (response) in
            switch response.result {
            case .success( _):
                print("success")
                guard let leagues = response.value?.leagues else { return }
                print("leauges count \(leagues.count)")
                for leauge in leagues {
                    if leauge.strSport == "Soccer" {
                        var comingLeauge = leauge
                        comingLeauge = self.getLeaugeData(comingLeauge)
                        print(comingLeauge.strLogo ?? "append")
//                        var comingLeauge = leauge
//                        comingLeauge.strYoutube = "hello"
                        self.leagues.append(comingLeauge)
                    }
                }
                print("leauges table count \(self.leagues.count)")
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getLeaugeData(_ leauge : League)->League{
        let LeagueDetailURL = String("\(URLs.LeagueDetail)\(leauge.idLeague!)")
        var newLeauge = leauge
        AF.request(LeagueDetailURL).validate().responseDecodable(of: LeagueDetailAPI.self) { (response) in
            switch response.result {
            case .success( _):
                let leauges = response.value?.leagues
//                print(leauges?[0].strLogo ?? "")
                newLeauge.strYoutube = leauges?[0].strYoutube
                newLeauge.strLogo = leauges?[0].strLogo
//                print(newLeauge.strLogo ?? "")
          case .failure(let error):
                print(error.localizedDescription)
            }
        }

        return newLeauge
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaguesCell", for: indexPath) as! LeaugeCustomCell
        cell.leaugeName.text = leagues[indexPath.row].strLeague
        print("from cell \(leagues[indexPath.row].strLogo ?? "")")
        if let imgStr = leagues[indexPath.row].strLogo{
            cell.leaugeImage.sd_setImage(with: URL(string: imgStr), placeholderImage: UIImage(named: "placeholder"))
        }

        return cell
    }

}

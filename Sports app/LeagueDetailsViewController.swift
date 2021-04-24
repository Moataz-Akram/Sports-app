//
//  LeagueDetailsViewController.swift
//  Sports app
//
//  Created by Moataz on 20/04/2021.
//

import UIKit

class LeagueDetailsViewController: UIViewController {
    @IBOutlet weak var upcomingEventCollection: UICollectionView!
    @IBOutlet weak var passedEventCollection: UICollectionView!
    @IBOutlet weak var teamsCollection: UICollectionView!
    
    let network = SportsService()
    var leagueStr = "English Premier League"
    var leagueId = "4328"
    var teams = [Teams]()
    var passedEvents = [Event]()
    var comingEvents = [Event]()
    override func viewDidLoad() {
        super.viewDidLoad()
        upcomingEventCollection.delegate = self
        upcomingEventCollection.dataSource = self
        passedEventCollection.delegate = self
        passedEventCollection.dataSource = self
        teamsCollection.delegate = self
        teamsCollection.dataSource = self

        network.getPassedEvents(leagueId: leagueId) { (events, error) in
            if let events = events{
                self.passedEvents = events
            }
            print("from inside \(self.passedEvents.count)")
        }
        
        network.getTeamsInLeague(leagueStr: leagueStr) { (teams, error) in
            print(teams?.count as Any)
            if let teams = teams{
                self.teams = teams
                self.teamsCollection.reloadData()
            }
        }
    }

}

extension LeagueDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.upcomingEventCollection:
            return comingEvents.count
        case self.passedEventCollection:
            return passedEvents.count
        case self.teamsCollection:
            return teams.count
        default:
            return 1
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.upcomingEventCollection{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingEventCell", for: indexPath)

            return cell
            
        }else if collectionView == self.passedEventCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FinishedEventCell", for: indexPath) as! passedEventCustomCell

            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath)
            
            
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.upcomingEventCollection{
            print("upcoming")
        }else if collectionView == self.passedEventCollection{
            print("passed")
        }else{
            print("teams")
        }
    }

}

//
//  LeagueDetailsViewController.swift
//  Sports app
//
//  Created by Moataz on 20/04/2021.
//

import UIKit
import SDWebImage

class LeagueDetailsViewController: UIViewController {
    @IBOutlet weak var upcomingEventCollection: UICollectionView!
    @IBOutlet weak var passedEventCollection: UICollectionView!
    @IBOutlet weak var teamsCollection: UICollectionView!
    
    let network = SportsService()
    var strCurrentSeason = "2021"
    var round = "1"
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
                self.passedEventCollection.reloadData()
                self.strCurrentSeason = events[0].strSeason!
                self.round = String("\(Int(events[0].intRound!)!+1)")
                print("round\(self.round)")
                self.getUpcomingEvents( self.leagueId, self.round, self.strCurrentSeason)

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
    
    func getUpcomingEvents(_ leagueId: String,_ round:String,_ currentSeason:String){
        
        network.getUpcomingEvents(leagueId,  round,  currentSeason) { (events, error) in
            if let events = events{
                self.comingEvents = events
                self.upcomingEventCollection.reloadData()
            }
        }
    }
}


// MARK: - Collection Views
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

        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.upcomingEventCollection{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingEventCell", for: indexPath) as! upComingEventsCustomCell
            let event = comingEvents[indexPath.row]
            cell.homeName.text = event.strHomeTeam
            cell.awayName.text = event.strAwayTeam
            cell.eventDate.text = event.dateEvent
            cell.eventTime.text = event.strTime
            cell.eventTime.text?.removeLast(3)
            var imgHome = ""
            var imgAway = ""
            for team in teams {
                if event.strHomeTeam == team.strTeam{
                    imgHome = team.strTeamBadge!
                }
                if event.strAwayTeam == team.strTeam{
                    imgAway = team.strTeamBadge!
                }
            }

            cell.homeImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.homeImg.sd_setImage(with: URL(string: imgHome), placeholderImage: UIImage(named: "placeholder"))
            
            cell.awayImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.awayImg.sd_setImage(with: URL(string: imgAway), placeholderImage: UIImage(named: "placeholder"))

            
            return cell
            
        }else if collectionView == self.passedEventCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FinishedEventCell", for: indexPath) as! passedEventCustomCell
            let event = passedEvents[indexPath.row]
            cell.homeTeam.text = event.strHomeTeam
            cell.awayTeam.text = event.strAwayTeam
            cell.homeScore.text = event.intHomeScore
            cell.awayScore.text = event.intAwayScore
            cell.date.text = event.dateEvent
            var imgHome = ""
            var imgAway = ""
            for team in teams {
                if event.strHomeTeam == team.strTeam{
                    imgHome = team.strTeamBadge!
                }
                if event.strAwayTeam == team.strTeam{
                    imgAway = team.strTeamBadge!
                }
            }
            
            cell.homeImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.homeImg.sd_setImage(with: URL(string: imgHome), placeholderImage: UIImage(named: "placeholder"))
            
            cell.awayImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.awayImg.sd_setImage(with: URL(string: imgAway), placeholderImage: UIImage(named: "placeholder"))
//            cell.awayImg.sd_setImage(with: URL(string: imgAway))
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! teamsCutsomCell
            let img = teams[indexPath.row].strTeamBadge!
            cell.teamImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.teamImage.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "placeholder"))
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

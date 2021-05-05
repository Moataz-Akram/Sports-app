//
//  LeagueDetailsViewController.swift
//  Sports app
//
//  Created by Moataz on 20/04/2021.
//

import UIKit
import SDWebImage
import CoreData
class LeagueDetailsViewController: UIViewController {
    @IBOutlet weak var upcomingEventCollection: UICollectionView!
    @IBOutlet weak var passedEventCollection: UICollectionView!
    @IBOutlet weak var teamsCollection: UICollectionView!
    @IBOutlet weak var likeToggle: UIButton!
    var isFav = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let network = SportsService()
    let viewModel = LeagueDetailsViewModel()
    var teamDetail = Teams()
    var league = LeaugeDetail()
    var leagueStr = "English Premier League"
    var leagueId = "4328"
    var teams = [Teams]()
    var passedEvents = [Event]()
    var comingEvents = [Event]()
    var comingEventError = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindCollectionViews()
        bindToViewModel()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if viewModel.isNetworkReachable() {
            loadData()
        }else{
            noNetworkAlert()
        }
    }
    
    func bindCollectionViews(){
        //connecting collection to controller
        upcomingEventCollection.delegate = self
        upcomingEventCollection.dataSource = self
        passedEventCollection.delegate = self
        passedEventCollection.dataSource = self
        teamsCollection.delegate = self
        teamsCollection.dataSource = self
    }
    
    func bindToViewModel(){
        //bind with view model
        viewModel.bindComingEventsWithView = { [weak self] in
            self?.didReceiveComingEvents()
            self?.passedEventCollection.reloadData()
        }
        viewModel.bindTeamsWithView = { [weak self] in
            self?.didReceiveTeams()
        }
        viewModel.bindPassedEventsWithView = { [weak self] in
            self?.didReceivePastEvents()
            if self?.passedEvents[0].strHomeTeam == nil {
                //don't present any data
                self?.didReceiveEmptyTeams()
                print("no data avaliable for this league")
            }//else{
                self?.viewModel.getUpcomingEventsNew(self!.leagueId)
//            }
        }
        viewModel.bindComingEventsErrorWithView = { [weak self] in
            self?.didReceiveComingEventError()
        }
    }
    
    func loadData(){
        //get data from view model
        viewModel.getPassedEventsNew(leagueId: leagueId)
        viewModel.getTeamsInLeagueNew(leagueStr: leagueStr)
        
        isFav = viewModel.isFavLeagues(id: leagueId, appDelegate: appDelegate)
        if isFav {
            likeToggle.setImage(UIImage(named:"redHeart3"), for: .normal)
            
        }

    }
    
    func didReceiveEmptyTeams(){
        upcomingEventCollection.isHidden = true
        passedEventCollection.isHidden = true
        teamsCollection.isHidden = true
        
        let alert = UIAlertController(title: "Alert", message: "No event data avaliable for this league yet", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print("alert working")
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)

    }
    
    func noNetworkAlert(){
        let alert = UIAlertController(title: "Alert", message: "No network connection", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print("alert working")
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func didReceiveTeams(){
        teams = viewModel.teams
        teamsCollection.reloadData()
    }

    func didReceiveComingEvents(){
        comingEvents = viewModel.comingEvents
        upcomingEventCollection.reloadData()
    }

    func didReceivePastEvents(){
        passedEvents = viewModel.pastEvents
        passedEventCollection.reloadData()
    }
    
    func didReceiveComingEventError(){
        comingEventError = viewModel.comingEventError
        
        let alert = UIAlertController(title: "Alert", message: "No upcoming Matches\nThe new Season hasn't started yet", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print("alert working")
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func likeToggle(_ sender: UIButton) {
        if !isFav {
            viewModel.addToFav(league: league, appDelegate: appDelegate)
            likeToggle.setImage(UIImage(named:"redHeart3"), for: .normal)
            isFav = true
        }else{
            viewModel.deleteFav(id: league.idLeague!, appDelegate: appDelegate)
            likeToggle.setImage(UIImage(named:"grayH"), for: .normal)
            isFav = false
        }
        NotificationCenter.default.post(name: .notifyOther, object: nil, userInfo:nil)
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
            print("empty or nil \(event.strAwayTeam)")
            cell.homeScore.text = event.intHomeScore
            cell.awayScore.text = event.intAwayScore
            cell.date.text = event.dateEvent
            var imgHome = ""
            var imgAway = ""
            for team in teams {
                if event.strHomeTeam == team.strTeam{
                    imgHome = team.strTeamBadge ?? ""
                }
                if event.strAwayTeam == team.strTeam{
                    imgAway = team.strTeamBadge ?? ""
                }
            }
            cell.strHomeImg = imgHome
            cell.strAwayImg = imgAway
//            cell.homeImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
//            cell.homeImg.sd_setImage(with: URL(string: imgHome), placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: nil)
//
//
//            cell.awayImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
//            cell.awayImg.sd_setImage(with: URL(string: imgAway), placeholderImage: UIImage(named: "placeholder"))
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! teamsCutsomCell
            let img = teams[indexPath.row].strTeamBadge ?? ""
            cell.teamName.text = teams[indexPath.row].strTeam
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
            teamDetail = teams[indexPath.row]
            self.performSegue(withIdentifier: "navigateToTeamDetail", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navigateToTeamDetail"{
            let teamDetailScreen = segue.destination as! TeamDetailsViewController
            teamDetailScreen.team = self.teamDetail
        }
    }
    
}

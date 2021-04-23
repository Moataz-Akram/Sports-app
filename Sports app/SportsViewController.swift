//
//  ViewController.swift
//  Sports app
//
//  Created by Moataz on 20/04/2021.
//

import UIKit
import SDWebImage
class SportsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var sports : [Sport] = [Sport]()
    let allSportsViewModel = SportsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allSportsViewModel.bindAllSportsViewModelToView = {
                    
            self.onSuccessUpdateView()
            
        }
        
        allSportsViewModel.bindViewModelErrorToView = {
                    
            self.onFailUpdateView()
            
        }
        
    }
    
    func onSuccessUpdateView(){
        
        sports = allSportsViewModel.sportsData
        self.collectionView.reloadData()
        
    }
    
    func onFailUpdateView(){
        
       
        let alert = UIAlertController(title: "Error", message: allSportsViewModel.showError, preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
            
        }
        
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

extension SportsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 12 * 3) / 3 //some width
        let height = width * 0.5 //ratio
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCell", for: indexPath)
        let nameLabel : UILabel = cell.viewWithTag(2)! as! UILabel
        let img : UIImageView = cell.viewWithTag(1) as! UIImageView
        nameLabel.text = sports[indexPath.row].strSport
        img.sd_setImage(with: URL(string: sports[indexPath.row].strSportThumb ), placeholderImage: UIImage(named:"1"))
        // Configure the cell
    
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hello")
    }
}


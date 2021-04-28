//
//  TeamDetailsViewModel.swift
//  Sports app
//
//  Created by marwa on 4/24/21.
//

import Foundation
import UIKit
class TeamDetailsViewModel: NSObject{
  
    func openContacts(str : String ) {
        if str != ""{
            if let contactURL = URL(string: "https://\(str)"),
                UIApplication.shared.canOpenURL(contactURL) {
                // redirect to app
                UIApplication.shared.open(contactURL, options: [:], completionHandler: nil)
                print(contactURL)
            } else if let contactURL = URL(string: "https://\(str)") {
                // redirect through safari
                UIApplication.shared.open(contactURL, options: [:], completionHandler: nil)
                print(contactURL)
            }
        }
   }

}

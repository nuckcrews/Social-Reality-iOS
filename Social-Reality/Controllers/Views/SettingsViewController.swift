//
//  SettingsViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/27/21.
//

import UIKit
import Amplify
import AmplifyPlugins

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    @IBAction func tapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell") as? accountCell {
            if indexPath.row == 0 {
                cell.configureCell(title: "Inforamtion")
            } else if indexPath.row == 1 {
                cell.configureCell(title: "Accessibility")
            } else if indexPath.row == 2 {
                cell.configureCell(title: "Contact")
            } else if indexPath.row == 3 {
                cell.configureCell(title: "Security")
            } else if indexPath.row == 4 {
                cell.configureCell(title: "Payment")
            } else if indexPath.row == 5 {
                cell.configureCell(title: "Sign Out")
            }
            return cell
        } else {
            return accountCell()
        }
    }
    
    
}

//
//  SettingsViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/27/21.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var alertController: UIAlertController?
    
    struct CellTitles {
        static func title(_ index: Int) -> String {
            switch index {
            case 0:
                return "Information"
            case 1:
                return "Accessibility"
            case 2:
                return "Contact"
            case 3:
                return "Security"
            case 4:
                return "Payment"
            case 5:
                return "Sign Out"
            default:
                return ""
            }
        }
    }
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func setupAlert() {
        let alert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .actionSheet)
            
        let ok = UIAlertAction(title: "Sign Out", style: .destructive, handler: { action in
                self.signOut()
             })
             alert.addAction(ok)
             let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
                
             })
             alert.addAction(cancel)
             DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
        })
    }
    
    
    func signOut() {
        Auth0.signOut { [weak self] res in
            if res == .success {
                self?.backToHome()
            }
        }
    }
    
    func backToHome() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toHomeFromSettings.rawValue, sender: nil)
        }
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cells.settingsCell.rawValue) as? settingsCell {
            cell.configureCell(title: CellTitles.title(indexPath.row), index: indexPath.row)
            return cell
        } else {
            return settingsCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5 {
            setupAlert()
        }
    }
}

//
//  MessageViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/6/21.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var messages = [MessageModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMessages()
        
    }
    
    func getMessages() {
        
        
        
    }
    

}

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cells.messageCell.rawValue, for: indexPath) as? messageCell {
            
            return cell
        } else {
            return messageCell()
        }
    }
}

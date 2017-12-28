//
//  MenuVC.swift
//  Blog
//
//  Created by Q8coders on 12/28/17.
//  Copyright © 2017 Q8coders. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    // MARK: - View cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

extension MenuVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "Cell", for: indexPath);
        
        let titleLabel = cell.contentView.viewWithTag(2) as! UILabel
        
        switch indexPath.row {
        case 0: titleLabel.text = NSLocalizedString("Blogs", comment: "")
        case 1: titleLabel.text = NSLocalizedString("Write", comment: "")
        case 2: titleLabel.text = NSLocalizedString("Drafs", comment: "")
        case 3: titleLabel.text = NSLocalizedString("Friends", comment: "")
        default: titleLabel.text = NSLocalizedString("Profile", comment: "")
        }
        
        return cell;
    }
    
}

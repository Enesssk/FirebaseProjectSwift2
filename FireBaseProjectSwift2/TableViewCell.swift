//
//  TableViewCell.swift
//  FireBaseProjectSwift2
//
//  Created by Enes Kala on 5.03.2024.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBOutlet weak var userImageView: UIImageView!
    
    
    @IBOutlet weak var commentLabel: UILabel!
    
    
    @IBOutlet weak var likeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}

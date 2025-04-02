//
//  TumblrCell.swift
//  ios101-project5-tumblr
//
//  Created by Jay P on 4/1/25.
//

import UIKit

class TumblrCell: UITableViewCell {
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var postContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

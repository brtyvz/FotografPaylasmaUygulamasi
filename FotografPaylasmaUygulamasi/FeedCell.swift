//
//  FeedCell.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Berat Yavuz on 28.03.2022.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var yorumTextField: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var mailTextField: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

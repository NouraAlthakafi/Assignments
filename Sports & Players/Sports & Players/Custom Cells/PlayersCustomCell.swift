//
//  PlayersCustomCell.swift
//  Sports & Players
//
//  Created by admin on 29/12/2021.
//

import UIKit

class PlayersCustomCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAge: UILabel!
    @IBOutlet weak var lbHeight: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  ConfigurationViewCell.swift
//  iBuyApp
//
//  Created by Cleís Aurora Pereira on 08/11/20.
//

import UIKit

class ConfigurationViewCell: UITableViewCell {
    @IBOutlet weak var configurationLabel: UILabel!

    func setup(configuration: String) {
        configurationLabel.text = configuration
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

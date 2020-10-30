//
//  ListViewCell.swift
//  iBuyApp
//
//  Created by Cleís Aurora Pereira on 30/10/20.
//

import UIKit

class ListViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setup(product: Product) {
        nameLabel.text = product.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

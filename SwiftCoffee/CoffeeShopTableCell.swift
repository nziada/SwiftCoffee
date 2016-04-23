//
//  CoffeeShopTableCell.swift
//  SwiftCoffee
//
//  Created by Nader Ziada on 2016-04-22.
//  Copyright © 2016 NZ. All rights reserved.
//

import UIKit

class CoffeeShopTableCell: UITableViewCell {

    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var distnace: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

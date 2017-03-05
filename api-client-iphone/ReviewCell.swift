//
//  REviewCell.swift
//  api-client-iphone
//
//  Created by Khaled Rahman-Ayon on 01/02/17.
//  Copyright © 2017 Khaled Rahman-Ayon. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewTextLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(review: FoodTruckReview) {
        titleLabel.text = review.title
        reviewTextLabel.text = review.text
    }

}

//
//  CategoryCVCell.swift
//  CodeBrewAssignment
//
//  Created by Nitin Mittal on 08/01/22.
//

import UIKit

class CategoryCVCell: UICollectionViewCell {

    static let categoryCVCellIdentifier                       =      "CategoryCVCell"
    @IBOutlet weak var categoryTextLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension CategoryCVCell: Reusable {}

//
//  DetailsTVCell.swift
//  CodeBrewAssignment
//
//  Created by Nitin Mittal on 08/01/22.
//

import UIKit

class DetailsTVCell: UITableViewCell {

    static let detailsTVCellCellIdentifier                       = "DetailsTVCell"

    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var progressImgView: UIImageView!
    @IBOutlet weak var openTaskLbl: UILabel!
    @IBOutlet weak var redCircleImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension DetailsTVCell : Reusable{}


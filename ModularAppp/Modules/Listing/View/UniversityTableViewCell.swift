//
//  UniversityTableViewCell.swift
//  ModularAppp
//
//  Created by Wasim on 26/07/24.
//

import UIKit

class UniversityTableViewCell: UITableViewCell {
    @IBOutlet weak var universityNameLabel: UILabel!
    @IBOutlet weak var universityStateLabel: UILabel!
    
    func configure(with university: UniversityModel) {
        universityNameLabel.attributedText = NSAttributedString.createLabelText(
            staticText: "University Name: ",
            dynamicText: university.name,
            staticTextColor: .primaryColor,
            dynamicTextColor: .secondaryColor
        )
        
        if let state = university.state_province, !state.isEmpty {
            universityStateLabel.attributedText = NSAttributedString.createLabelText(
                staticText: "University State: ",
                dynamicText: state,
                staticTextColor: .primaryColor,
                dynamicTextColor: .secondaryColor
            )
        } else {
            universityStateLabel.text = ""
        }
    }
}

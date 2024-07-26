//
//  ExtensionClass.swift
//  ModularAppp
//
//  Created by Wasim on 26/07/24.
//

import Foundation
import UIKit

extension UIColor {
    static let primaryColor = UIColor(red: 0.0, green: 0.47, blue: 0.75, alpha: 1.0) // Primary color for static text (a shade of blue)
    static let secondaryColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.0) // Secondary color for dynamic text (a shade of dark gray)
    static let linkColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0) // Color for links (a brighter shade of blue)
}

extension NSAttributedString {
    static func createLabelText(staticText: String, dynamicText: String, staticTextColor: UIColor, dynamicTextColor: UIColor) -> NSAttributedString {
        let staticAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: staticTextColor,
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
        let dynamicAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: dynamicTextColor,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
        let attributedString = NSMutableAttributedString(string: staticText, attributes: staticAttributes)
        attributedString.append(NSAttributedString(string: dynamicText, attributes: dynamicAttributes))
        return attributedString
    }
}

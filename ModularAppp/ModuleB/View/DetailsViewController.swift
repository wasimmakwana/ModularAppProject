//
//  DetailsViewController.swift
//  ModularAppp
//
//  Created by Wasim on 25/07/24.
//
import UIKit

class DetailsViewController: UIViewController, DetailsViewProtocol {
    var presenter: DetailsPresenterProtocol?
    private let urlHandler = URLHandler()
    
    @IBOutlet weak var universityNameLabel: UILabel!
    @IBOutlet weak var universityStateLabel: UILabel!
    @IBOutlet weak var universityCountryLabel: UILabel!
    @IBOutlet weak var universityCountryCodeLabel: UILabel!
    @IBOutlet weak var universityWebsiteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func showUniversityDetails(_ university: UniversityModel) {
        configureLabel(universityNameLabel, withStaticText: "University Name: ", andDynamicText: university.name)
        configureLabel(universityStateLabel, withStaticText: "University State: ", andDynamicText: university.state_province)
        configureLabel(universityCountryLabel, withStaticText: "Country: ", andDynamicText: university.country)
        configureLabel(universityCountryCodeLabel, withStaticText: "Country Code: ", andDynamicText: university.alpha_two_code)
        
        if let website = university.web_pages.first, !website.isEmpty {
            configureLinkLabel(universityWebsiteLabel, withStaticText: "Web Page: ", andDynamicText: website)
            addTapGestureToLabel(universityWebsiteLabel, withURL: website)
        } else {
            universityWebsiteLabel.isHidden = true
        }
    }
    
    private func configureLabel(_ label: UILabel, withStaticText staticText: String, andDynamicText dynamicText: String?) {
        guard let dynamicText = dynamicText, !dynamicText.isEmpty else {
            label.isHidden = true
            return
        }
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: staticText, attributes: LabelAttributes.staticTextAttributes()))
        attributedString.append(NSAttributedString(string: dynamicText, attributes: LabelAttributes.dynamicTextAttributes()))
        label.attributedText = attributedString
        label.isHidden = false
    }
    
    private func configureLinkLabel(_ label: UILabel, withStaticText staticText: String, andDynamicText dynamicText: String) {
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: staticText, attributes: LabelAttributes.staticTextAttributes()))
        
        let linkAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.linkColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
        attributedString.append(NSAttributedString(string: dynamicText, attributes: linkAttributes))
        
        label.attributedText = attributedString
        label.isHidden = false
    }
    
    private func addTapGestureToLabel(_ label: UILabel, withURL urlString: String) {
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLabelTap(_:)))
        label.addGestureRecognizer(tapGesture)
        label.tag = urlString.hashValue
    }
    
    @objc private func handleLabelTap(_ gesture: UITapGestureRecognizer) {
        guard let label = gesture.view as? UILabel, let urlString = label.text?.split(separator: " ").last else {
            return
        }
        urlHandler.openURL(String(urlString))
    }
}

// Define a struct to handle label attributes
struct LabelAttributes {
    static func staticTextAttributes() -> [NSAttributedString.Key: Any] {
        return [
            NSAttributedString.Key.foregroundColor: UIColor.primaryColor,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
    }
    
    static func dynamicTextAttributes() -> [NSAttributedString.Key: Any] {
        return [
            NSAttributedString.Key.foregroundColor: UIColor.secondaryColor,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
    }
}

// URLHandler class to handle opening URLs
class URLHandler {
    func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

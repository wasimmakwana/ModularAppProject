//
//  ListingRouter.swift
//  ModularAppp
//
//  Created by Wasim on 25/07/24.
//
import UIKit

class DetailsRouter: DetailsRouterProtocol {
    
    static func createDetailsModule(with university: UniversityModel) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        let presenter: DetailsPresenterProtocol = DetailsPresenter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.university = university
        
        return view
    }
}

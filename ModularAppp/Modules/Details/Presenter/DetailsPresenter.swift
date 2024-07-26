//
//  ListingPresenter.swift
//  ModularAppp
//
//  Created by Wasim on 25/07/24.
//
import Foundation

class DetailsPresenter: DetailsPresenterProtocol {
    var university: UniversityModel?
    
    weak var view: DetailsViewProtocol?
    
    func viewDidLoad() {
        if let university = university {
            view?.showUniversityDetails(university)
        }
    }
}

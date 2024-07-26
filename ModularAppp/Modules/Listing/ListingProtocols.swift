//
//  ListingProtocols.swift
//  ModularAppp
//
//  Created by Wasim on 26/07/24.
//

import Foundation
import UIKit

protocol ListingViewProtocol: AnyObject {
    func showUniversities(_ universities: [UniversityModel])
    func showError(_ error: String)
}

protocol ListingPresenterProtocol: AnyObject {
    var view: ListingViewProtocol? { get set }
    var interactor: ListingInteractorInputProtocol? { get set }
    var router: ListingRouterProtocol? { get set }

    func viewDidLoad()
    func didSelectUniversity(_ university: UniversityModel)
}

protocol ListingInteractorOutputProtocol: AnyObject {
    func didFetchUniversities(_ universities: [UniversityModel])
    func onError(_ error: Error)
}

protocol ListingInteractorInputProtocol: AnyObject {
    func fetchUniversities()
}

protocol ListingRouterProtocol: AnyObject {
    static func createListingModule() -> ListingViewController
    func navigateToDetail(with university: UniversityModel)
}

//
//  ListingPresenter.swift
//  ModularAppp
//
//  Created by Wasim on 25/07/24.
//
import UIKit
import Foundation

class ListingPresenter: ListingPresenterProtocol, ListingInteractorOutputProtocol {
    weak var view: ListingViewProtocol?
    var interactor: ListingInteractorInputProtocol?
    var router: ListingRouterProtocol?

    func viewDidLoad() {
        interactor?.fetchUniversities()
    }

    func didSelectUniversity(_ university: UniversityModel) {
        router?.navigateToDetail(with: university)
    }

    func didFetchUniversities(_ universities: [UniversityModel]) {
        view?.showUniversities(universities)
    }

    func onError(_ error: Error) {
        view?.showError(error.localizedDescription)
    }
}

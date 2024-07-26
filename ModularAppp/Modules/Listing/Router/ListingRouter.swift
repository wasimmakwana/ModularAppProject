//
//  ListingRouter.swift
//  ModularAppp
//
//  Created by Wasim on 25/07/24.
//

import UIKit

class ListingRouter: ListingRouterProtocol {
    weak var viewController: UIViewController?

    static func createListingModule() -> ListingViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let view = storyboard.instantiateViewController(withIdentifier: "ListingViewController") as? ListingViewController else {
            fatalError("Failed to instantiate ListingViewController from storyboard.")
        }

        let presenter: ListingPresenterProtocol & ListingInteractorOutputProtocol = ListingPresenter()
        let localDataManager: LocalDataManagerProtocol = LocalDataManager()
        let remoteDataManager: RemoteDataManagerProtocol = RemoteDataManager()
        let interactor: ListingInteractorInputProtocol = ListingInteractor(localDataManager: localDataManager, remoteDataManager: remoteDataManager, presenter: presenter)
        let router = ListingRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.viewController = view

        print("View setup completed, presenter view: \(String(describing: presenter.view))")

        return view
    }

    func navigateToDetail(with university: UniversityModel) {
        let detailVC = DetailsRouter.createDetailsModule(with: university)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}

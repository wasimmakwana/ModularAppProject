//
//  ListingInteractor.swift
//  ModularAppp
//
//  Created by Wasim on 25/07/24.
//
import UIKit
import Foundation

class ListingInteractor: ListingInteractorInputProtocol {
    weak var presenter: ListingInteractorOutputProtocol?
    var localDataManager: LocalDataManagerProtocol?
    var remoteDataManager: RemoteDataManagerProtocol?

    init(localDataManager: LocalDataManagerProtocol, remoteDataManager: RemoteDataManagerProtocol, presenter: ListingInteractorOutputProtocol) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
        self.presenter = presenter
    }

    func fetchUniversities() {
        remoteDataManager?.fetchUniversities { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let universities):
                self.localDataManager?.saveUniversities(universities) { success in
                    if success {
                        self.localDataManager?.retrieveUniversities { cachedUniversities in
                            guard let cachedUniversities = cachedUniversities else {
                                self.presenter?.onError(NSError(domain: "Error", code: -1, userInfo: nil))
                                return
                            }
                            self.presenter?.didFetchUniversities(cachedUniversities)
                        }
                    } else {
                        self.handleLocalFetchError()
                    }
                }
            case .failure(let error):
                self.handleLocalFetchError(error: error)
            }
        }
    }

    private func handleLocalFetchError(error: Error? = nil) {
        localDataManager?.retrieveUniversities { [weak self] cachedUniversities in
            guard let self = self else { return }
            if let cachedUniversities = cachedUniversities {
                self.presenter?.didFetchUniversities(cachedUniversities)
            } else if let error = error {
                self.presenter?.onError(error)
            } else {
                self.presenter?.onError(NSError(domain: "Unknown error", code: -1, userInfo: nil))
            }
        }
    }
}

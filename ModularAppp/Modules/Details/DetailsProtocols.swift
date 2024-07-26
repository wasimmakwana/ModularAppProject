//
//  DetailsProtocols.swift
//  ModularAppp
//
//  Created by Wasim on 26/07/24.
//
import Foundation
import UIKit

protocol DetailsViewProtocol: AnyObject {
    func showUniversityDetails(_ university: UniversityModel)
}

protocol DetailsPresenterProtocol: AnyObject {
    var view: DetailsViewProtocol? { get set }
    var university: UniversityModel? { get set }
    
    func viewDidLoad()
}

protocol DetailsRouterProtocol: AnyObject {
    static func createDetailsModule(with university: UniversityModel) -> UIViewController
}

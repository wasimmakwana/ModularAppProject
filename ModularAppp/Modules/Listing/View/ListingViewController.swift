//
//  ListingViewController.swift
//  ModularAppp
//
//  Created by Wasim on 26/07/24.
//

import UIKit

class ListingViewController: UIViewController, ListingViewProtocol {
    var presenter: ListingPresenterProtocol?

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!

    private var universities: [UniversityModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter?.viewDidLoad()
    }

    private func setupViews() {
        labelTitle.text = "University Listings"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
    }

    func showUniversities(_ universities: [UniversityModel]) {
        self.universities = universities
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showError(_ error: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ListingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UniversityCell", for: indexPath) as? UniversityTableViewCell else {
            return UITableViewCell()
        }

        let university = universities[indexPath.row]
        cell.configure(with: university)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectUniversity(universities[indexPath.row])
    }
}

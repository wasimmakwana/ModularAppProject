//  LocalDataManager.swift
//  ModularApp
//
//  Created by Wasim on 25/07/24.
//
import RealmSwift
import Dispatch

protocol LocalDataManagerProtocol {
    func saveUniversities(_ universities: [University], completion: @escaping (Bool) -> Void)
    func retrieveUniversities(completion: @escaping ([UniversityModel]?) -> Void)
}

class LocalDataManager: LocalDataManagerProtocol {
    func saveUniversities(_ universities: [University], completion: @escaping (Bool) -> Void) {
        DispatchQueue(label: "realm").async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.add(universities, update: .all)
                    }
                    DispatchQueue.main.async {
                        completion(true)
                    }
                } catch {
                    print("Failed to save universities: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
            }
        }
    }

    func retrieveUniversities(completion: @escaping ([UniversityModel]?) -> Void) {
        DispatchQueue(label: "realm").async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    let universities = realm.objects(University.self).map { UniversityModel(university: $0) }
                    let universityModels = Array(universities)
                    DispatchQueue.main.async {
                        completion(universityModels)
                    }
                } catch {
                    print("Failed to retrieve universities: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        }
    }
}

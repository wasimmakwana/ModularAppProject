//
//  University.swift
//  ModularAppp
//
//  Created by Wasim on 25/07/24.
//
import RealmSwift

class University: Object, Codable {
    @Persisted var alpha_two_code: String = ""
    @Persisted var web_pages: List<String> = List<String>()
    @Persisted var country: String = ""
    @Persisted var domains: List<String> = List<String>()
    @Persisted var name: String = ""
    @Persisted var state_province: String? = nil

    override static func primaryKey() -> String? {
        return "name"
    }

    enum CodingKeys: String, CodingKey {
        case alpha_two_code
        case web_pages
        case country
        case domains
        case name
        case state_province = "state-province"
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        alpha_two_code = try container.decode(String.self, forKey: .alpha_two_code)
        let webPagesArray = try container.decode([String].self, forKey: .web_pages)
        web_pages.append(objectsIn: webPagesArray)
        country = try container.decode(String.self, forKey: .country)
        let domainsArray = try container.decode([String].self, forKey: .domains)
        domains.append(objectsIn: domainsArray)
        name = try container.decode(String.self, forKey: .name)
        state_province = try container.decodeIfPresent(String.self, forKey: .state_province)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(alpha_two_code, forKey: .alpha_two_code)
        try container.encode(Array(web_pages), forKey: .web_pages)
        try container.encode(country, forKey: .country)
        try container.encode(Array(domains), forKey: .domains)
        try container.encode(name, forKey: .name)
        try container.encode(state_province, forKey: .state_province)
    }
}

struct UniversityModel {
    let alpha_two_code: String
    let web_pages: [String]
    let country: String
    let domains: [String]
    let name: String
    let state_province: String?
    
    init(university: University) {
        self.alpha_two_code = university.alpha_two_code
        self.web_pages = Array(university.web_pages)
        self.country = university.country
        self.domains = Array(university.domains)
        self.name = university.name
        self.state_province = university.state_province
    }
}

//
//  School.swift
//  NYSSchools
//
//  Created by Bani Uppal on 12/6/22.
//

import Foundation

struct School: Decodable, Hashable {
        
    let schoolName: String
    let dbn: String
    let overview: String?
    let location: String?
    let phoneNumber: String?
    let email: String?
    
    enum CodingKeys: String, CodingKey {
        case schoolName = "school_name"
        case overview = "overview_paragraph"
        case dbn, location
        case phoneNumber = "phone_number"
        case email = "school_email"
    }
}

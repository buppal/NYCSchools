//
//  NYCSchoolsService.swift
//  NYSSchools
//
//  Created by Bani Uppal on 12/7/22.
//

import Combine
import Foundation

protocol SchoolsService {
    func fetchSchools() -> AnyPublisher<[School], Error>
}

class SchoolsServiceImpl: SchoolsService {
    enum Constants {
        static let url = URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")!
    }

    func fetchSchools() -> AnyPublisher<[School], Error> {
        var request = URLRequest(url: Constants.url)
        request.httpMethod = "GET"
        return NetworkTask().fetch(request: request)
    }
}

//
//  SATScoresService.swift
//  NYSSchools
//
//  Created by Bani Uppal on 12/12/22.
//

import Combine
import Foundation

protocol SATScoresService {
    func fetchSATScores() -> AnyPublisher<[SATScore], Error>
}

class SATScoresServiceImpl: SATScoresService {
    enum Constants {
        static let url = URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json")!
    }

    func fetchSATScores() -> AnyPublisher<[SATScore], Error> {
        var request = URLRequest(url: Constants.url)
        request.httpMethod = "GET"
        return NetworkTask().fetch(request: request)
    }
}

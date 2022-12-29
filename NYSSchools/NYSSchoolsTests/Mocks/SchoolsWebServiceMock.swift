//
//  SchoolsWebServiceMock.swift
//  NYSSchoolsTests
//
//  Created by Bani Uppal on 12/28/22.
//

@testable import NYSSchools
import Combine
import XCTest

class SchoolsWebServiceMock: SchoolsService {
    var schools: [School]
    var error: Error?
    
    var schoolsPublisher: AnyPublisher<[School], Error>!
    
    init(schools: [School], error: Error? = nil) {
        self.schools = schools
        self.error = error
    }
    
    func fetchSchools() -> AnyPublisher<[School], Error> {
        let publisher: AnyPublisher<[School], Error>
        if let error = error {
            publisher = Fail(error: error)
                .eraseToAnyPublisher()
        } else {
            publisher = Just(schools)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        schoolsPublisher = publisher
        return publisher
    }
}

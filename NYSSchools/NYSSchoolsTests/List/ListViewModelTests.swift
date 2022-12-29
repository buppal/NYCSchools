//
//  ListViewModelTests.swift
//  NYSSchoolsTests
//
//  Created by Bani Uppal on 12/28/22.
//

@testable import NYSSchools
import Combine
import XCTest

final class ListViewModelTests: XCTestCase {
    var cancellables = [AnyCancellable]()
    
    func testFetchSchoolsSetsSchoolsArray() {
        let expectedSchools = [school()]
        let mockService = SchoolsWebServiceMock(schools: expectedSchools)
        let viewModel = ListViewModel(schoolsService: mockService)
        viewModel.fetchSchools()
        let expectation = self.expectation(description: "Publisher time out")

        var gotSchools = [School]()
        mockService.schoolsPublisher
            .sink(receiveCompletion: { _ in
                expectation.fulfill()
            }, receiveValue: { schools in
                gotSchools = schools
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(gotSchools, expectedSchools)
    }
    
    func testFetchSchoolsSetsSchoolsArrayUsingExtension() throws {
        let expectedSchools = [school()]
        let mockService = SchoolsWebServiceMock(schools: expectedSchools)
        let viewModel = ListViewModel(schoolsService: mockService)
        viewModel.fetchSchools()
        let schools = try awaitPublisher(mockService.schoolsPublisher)
        XCTAssertEqual(schools, expectedSchools)
    }

    func testNetworkErrorSetsError() {
        let expectedError = NetworkTaskError.httpError
        let mockService = SchoolsWebServiceMock(schools: [], error: expectedError)
        let viewModel = ListViewModel(schoolsService: mockService)
        viewModel.fetchSchools()
        
        let expectation = self.expectation(description: "Publisher timed out")

        viewModel.$fetchError
            .dropFirst()
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { error in
                // This should be in here and not in receiveCompletion. For published properties, receiveCompletion might not even be called coz they can keep getting values.
                expectation.fulfill()
                XCTAssertNotNil(error)
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 1.0)
    }
    
    func testNetworkErrorSetsErrorUsingExtension() throws {
        let expectedError = NetworkTaskError.httpError
        let mockService = SchoolsWebServiceMock(schools: [], error: expectedError)
        let viewModel = ListViewModel(schoolsService: mockService)
        viewModel.fetchSchools()
        let errorPublisher = viewModel.$fetchError
        let error = try awaitPublisher(errorPublisher)
        XCTAssertNotNil(error)
        
    }
    
    func testLoadingIsTrueOnLoad() {
        let expectedSchools = [school()]
        let mockService = SchoolsWebServiceMock(schools: expectedSchools)
        let viewModel = ListViewModel(schoolsService: mockService)
        XCTAssertTrue(viewModel.isLoading)
    }
    
    func testLoadingIsSetToFalseOnCompletion() {
        let expectedSchools = [school()]
        let mockService = SchoolsWebServiceMock(schools: expectedSchools)
        let viewModel = ListViewModel(schoolsService: mockService)
        viewModel.fetchSchools()
        
        let expectation = self.expectation(description: "Publisher timed out")
        viewModel.$isLoading
            .dropFirst()
            .sink(receiveCompletion: { _ in
            
        }, receiveValue: { value in
            expectation.fulfill()
            XCTAssertEqual(value, false)
        })
            .store(in: &cancellables)
        waitForExpectations(timeout: 1.0)
    }
    
    private func school() -> School {
        School(schoolName: "fake_school", dbn: "fake_dbn", overview: "fake_overview", location: "fake_location", phoneNumber: "289-333-8490", email: "fake_email@doordash.com")
    }
    
    private func createViewModel(schools: [School]) -> ListViewModel {
        let mockService = SchoolsWebServiceMock(schools: schools)
        let viewModel = ListViewModel(schoolsService: mockService)
        return viewModel
    }
    
}

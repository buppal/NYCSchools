//
//  SchoolDetailViewModel.swift
//  NYSSchools
//
//  Created by Bani Uppal on 12/12/22.
//

import Combine
import Foundation

class SchoolDetailViewModel: ObservableObject {
    private let satScoreService: SATScoresService
    private var cancellables: [AnyCancellable] = []
    private let school: School
    
    @Published var schoolName: String
    @Published var fetchError: Error?
    @Published var satScoreViewModel: SATScoreViewModel?
    @Published var schoolInfoCellViewModels: [SchoolInfoCellViewModel] = []
    
    init(
        school: School,
        satScoreService: SATScoresService = SATScoresServiceImpl()
    ) {
        self.school = school
        schoolName = school.schoolName
        self.satScoreService = satScoreService

        if let overview = school.overview {
            schoolInfoCellViewModels.append(.init(title: "Overview", subtitle: overview))
        }
        if let location = school.location {
            schoolInfoCellViewModels.append(.init(title: "Location", subtitle: location))
        }
        if let phoneNumber = school.phoneNumber {
            schoolInfoCellViewModels.append(.init(title: "Phone number", subtitle: phoneNumber))
        }
        if let email = school.email {
            schoolInfoCellViewModels.append(.init(title: "Email", subtitle: email))
        } 
    }
    
    func fetchSATScores() {
        satScoreService
            .fetchSATScores()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let strongSelf = self else {
                    return
                }
                switch completion {
                case .finished:
                    ()
                case .failure(let error):
                    strongSelf.fetchError = error
                }
            } receiveValue: { [weak self] scores in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.extractScoreForThisSchool(satScores: scores)
            }
            .store(in: &cancellables)
    }
    
    private func extractScoreForThisSchool(satScores: [SATScore]) {
        if let satScore = satScores.first(where: {
            $0.dbn == school.dbn
        }) {
            satScoreViewModel = SATScoreViewModel(score: satScore)
        }
    }
}

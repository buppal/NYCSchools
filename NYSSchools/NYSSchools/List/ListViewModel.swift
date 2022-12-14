//
//  ListViewModel.swift
//  NYSSchools
//
//  Created by Bani Uppal on 12/6/22.
//

import Foundation
import Combine

class ListViewModel: ObservableObject {
    private let schoolsService: SchoolsService
    
    private var cancellables: [AnyCancellable] = []
    
    @Published var schools: [School] = []
    
    @Published var isLoading = true
    
    @Published var fetchError: Error?
    
    init(schoolsService: SchoolsService = SchoolsServiceImpl()) {
        self.schoolsService = schoolsService
    }
    
    func schoolDetailViewModel(row: Int) -> SchoolDetailViewModel {
        SchoolDetailViewModel(school: schools[row])
    }
    
    func fetchSchools() {
        isLoading = true
        schoolsService.fetchSchools()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.isLoading = false
                switch completion {
                case .finished:
                    ()
                case .failure(let error):
                    strongSelf.fetchError = error
                }
            }, receiveValue: { [weak self] schools in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.schools = schools
            })
            .store(in: &cancellables)
    }
}

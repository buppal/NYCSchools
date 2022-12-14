//
//  SATScoreViewModel.swift
//  NYSSchools
//
//  Created by Bani Uppal on 12/12/22.
//

import Foundation

class SATScoreViewModel: ObservableObject {
    let individualScoreCellViewModels: [IndividualScoreCellViewModel]
    
    init(score: SATScore) {
        individualScoreCellViewModels = [
            .init(title: "Number of test takers", subtitle: score.numberOfTestTakers),
            .init(title: "Reading Score", subtitle: score.readingScore),
            .init(title: "Writing score", subtitle: score.writingScore),
            .init(title: "Math score", subtitle: score.mathScore)
        ]
    }
}

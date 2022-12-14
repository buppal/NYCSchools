//
//  SATScore.swift
//  NYSSchools
//
//  Created by Bani Uppal on 12/12/22.
//

import Foundation

struct SATScore: Decodable {
    let dbn: String
    let schoolName: String
    let numberOfTestTakers: String
    let readingScore: String
    let writingScore: String
    let mathScore: String
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case numberOfTestTakers = "num_of_sat_test_takers"
        case readingScore = "sat_critical_reading_avg_score"
        case writingScore = "sat_writing_avg_score"
        case mathScore = "sat_math_avg_score"
    }
}

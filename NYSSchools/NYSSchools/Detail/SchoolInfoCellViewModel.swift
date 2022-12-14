//
//  SchoolInfoCellViewModel.swift
//  NYSSchools
//
//  Created by Bani Uppal on 12/12/22.
//

import Foundation

struct SchoolInfoCellViewModel: Identifiable {
    let title: String
    let subtitle: String
    let id = UUID()
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}

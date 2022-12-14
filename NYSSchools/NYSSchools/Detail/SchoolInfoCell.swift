//
//  SchoolInfoCell.swift
//  NYSSchools
//
//  Created by Bani Uppal on 12/12/22.
//

import Foundation
import SwiftUI

struct SchoolInfoCell: View {
    private let viewModel: SchoolInfoCellViewModel
    
    init(viewModel: SchoolInfoCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.title)
                .font(.headline)
                .bold()
            Text(viewModel.subtitle)
                .font(.subheadline)
        }
        .padding(.vertical, .small)
    }
}

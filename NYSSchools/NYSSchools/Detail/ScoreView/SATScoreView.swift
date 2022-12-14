//
//  SATScoreView.swift
//  NYSSchools
//
//  Created by Bani Uppal on 12/12/22.
//

import SwiftUI

struct SATScoreView: View {
    @ObservedObject private var viewModel: SATScoreViewModel
    
    init(viewModel: SATScoreViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("SAT Scores:")
                .bold()
                .font(.title)
            ForEach(viewModel.individualScoreCellViewModels) { individualScoreCellViewModel in
                IndividualScoreCell(viewModel: individualScoreCellViewModel)
            }
        }
    }
}

struct SATScoreView_Previews: PreviewProvider {
    static var previews: some View {
        SATScoreView(viewModel: SATScoreViewModel(score: SATScore(dbn: "fake_dbn", schoolName: "Some school", numberOfTestTakers: "209", readingScore: "29", writingScore: "48", mathScore: "65")))
    }
}

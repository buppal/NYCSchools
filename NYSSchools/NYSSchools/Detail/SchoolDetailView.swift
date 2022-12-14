//
//  SchoolDetailView.swift
//  NYSSchools
//
//  Created by Bani Uppal on 12/12/22.
//

import SwiftUI

struct SchoolDetailView: View {
    @StateObject private var viewModel: SchoolDetailViewModel

    init(viewModel: SchoolDetailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.schoolInfoCellViewModels, content: { schoolInfoCellViewModel in
                    SchoolInfoCell(viewModel: schoolInfoCellViewModel)
                })
                if let satScoreViewModel = viewModel.satScoreViewModel {
                    SATScoreView(viewModel: satScoreViewModel)
                }
            }
        }
        .navigationTitle(viewModel.school.schoolName)
        .padding(.all, .medium)
        .errorAlert(error: $viewModel.fetchError)
        .onAppear {
            viewModel.fetchSATScores()
        }
    }
    
}

struct SchoolDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolDetailView(
            viewModel: SchoolDetailViewModel(
                school: School(schoolName: "Some school", dbn: "some_dbn", overview: "some_overview", location: nil, phoneNumber: nil, email: nil))
        )
    }
}

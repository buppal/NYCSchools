//
//  ListView.swift
//  NYSSchools
//
//  Created by Bani Uppal on 12/6/22.
//

import SwiftUI

struct ListView: View {
    @StateObject private var viewModel: ListViewModel
    
    init(viewModel: ListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content
            .onAppear {
                viewModel.fetchSchools()
            }
            .errorAlert(error: $viewModel.fetchError)
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
        } else {
            NavigationView {
                VStack {
                    List {
                        ForEach(Array(viewModel.schools.enumerated()), id: \.element) { index, school in
                            NavigationLink(destination: {
                                SchoolDetailView(viewModel: viewModel.schoolDetailViewModel(row: index))
                            }, label: {
                                SchoolCell(name: school.schoolName)
                            })
                        }
                    }
                }
                .navigationTitle("Schools")
            }
        }
    }
}

struct SchoolCell: View {
    var name: String
    
    var body: some View {
        Text(name)
            .font(.body)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: ListViewModel())
    }
}

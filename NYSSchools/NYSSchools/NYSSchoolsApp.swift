//
//  NYSSchoolsApp.swift
//  NYSSchools
//
//  Created by Bani Uppal on 12/6/22.
//

import SwiftUI

@main
struct NYSSchoolsApp: App {
    var body: some Scene {
        WindowGroup {
            ListView(viewModel: ListViewModel())
        }
    }
}

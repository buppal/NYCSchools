//
//  ErrorAlertSheet.swift
//  NYSSchools
//
//  Created by Bani Uppal on 12/12/22.
//

import Foundation
import SwiftUI

struct LocalizedAlertError: LocalizedError {
    private let underlyingError: Error?
    
    init?(error: Error?) {
        guard let error = error else {
            return nil
        }
        self.underlyingError = error
    }
    
    var errorDescription: String? {
        underlyingError?.localizedDescription
    }
}

extension NetworkTaskError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "There was an error processing your request. "
        case .httpError:
            return "There was an error processing your request."
        case .parseError(underlyingError: let underlyingError):
            return "There was an error parsing your response. error: \(underlyingError.localizedDescription)"
        }
    }
}

extension View {
    func errorAlert(
        error: Binding<Error?>,
        primaryButtonTitle: String = "OK",
        primaryButtonAction: (() -> Void)? = nil
    ) -> some View {
        let localizedError = LocalizedAlertError(error: error.wrappedValue)
        return alert(isPresented: .constant(localizedError != nil), error: localizedError) { _ in
            Button(primaryButtonTitle) {
                error.wrappedValue = nil
            }

        } message: { error in
            Text(error.errorDescription ?? "")
        }
    }
}

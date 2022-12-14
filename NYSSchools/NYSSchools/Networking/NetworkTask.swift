//
//  NetworkTask.swift
//  NYSSchools
//
//  Created by Bani Uppal on 12/6/22.
//

import Combine
import Foundation

struct NetworkTask {
    func fetch<Output: Decodable>(request: URLRequest) -> AnyPublisher<Output, Error> {
        let session = URLSession.shared
        return URLSession.DataTaskPublisher(request: request, session: session)
            .tryMap { (data, response) in
                guard let response = response as? HTTPURLResponse else {
                    throw NetworkTaskError.invalidResponse
                }
                guard (200..<300).contains(response.statusCode) else {
                    throw NetworkTaskError.httpError
                }
                return (data, response)
            }
            .tryMap { (data, response) in
                let decoder = JSONDecoder()
                do {
                    let parsedOutput = try decoder.decode(Output.self, from: data)
                    return parsedOutput
                } catch {
                    print(error)
                    throw NetworkTaskError.parseError(underlyingError: error)
                }

            }
            .eraseToAnyPublisher()
    }
}

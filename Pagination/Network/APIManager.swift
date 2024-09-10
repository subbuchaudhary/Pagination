//
//  APIManager.swift
//  Pagination
//
//  Created by Subba Nelakudhiti on 9/10/24.
//

import Foundation

enum ApiError: Error {
  case invalidRequestError(String)
  case transportError(Error)
  case serverError(statusCode: Int, httpResponse: HTTPURLResponse, data: Data)
  case noData
  case dataError(Error)
}

final class APIManager {
    static let shared = APIManager()

    private let baseUrl = "https://api.coingecko.com/api/v3/coins/"

    private init() {}

    func fetchCryptoCoinsData(pageLimit: Int, pageNumber: Int) async throws -> [Coin] {
        let url: String = "\(baseUrl)markets?vs_currency=usd&order=market_cap_desc&per_page=\(pageLimit)&page=\(pageNumber)&price_change_percentage=24h"
        return try await fetchData(from: url)
    }

    private func fetchData<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else { throw ApiError.invalidRequestError("invalid url") }
        let (data, response) = try await URLSession.shared.data(from: url)
        let model = try JSONDecoder().decode(
            T.self,
            from: mapResponse(response: (data: data, response: response))
        )
        return model
    }

    private func mapResponse(response: (data: Data, response: URLResponse)) throws -> Data {
        guard let httpResponse = response.response as? HTTPURLResponse else {
            return response.data
        }

        switch httpResponse.statusCode {
        case 200..<300:
            return response.data
        default: 
            throw ApiError.serverError(statusCode: httpResponse.statusCode,
                                       httpResponse: httpResponse,
                                       data: response.data)
        }
    }
}

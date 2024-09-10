//
//  CoinsListViewModel.swift
//  Pagination
//
//  Created by Subba Nelakudhiti on 9/10/24.
//

import Foundation

enum FetchableState {
    case fetching
    case idle
}

@MainActor
final class CoinsListViewModel: ObservableObject {
    @Published var coins: [Coin] = [Coin]()
    @Published var error: Error?
    @Published private(set) var state: FetchableState = .idle

    private let apiManager: APIManager
    private let pageLimit: Int = 20
    private var pageNumber: Int = 0

    init(apiManager: APIManager = APIManager.shared) {
        self.apiManager = apiManager
        fetchData()
    }

    func refreshData() {
        coins.removeAll()
        pageNumber = 0
        fetchData()
    }

    func fetchData() {
        state = .fetching
        Task {
            do {
                pageNumber += 1
                let coins = try await apiManager.fetchCryptoCoinsData(pageLimit: pageLimit, pageNumber: pageNumber)
                self.coins.append(contentsOf: coins)
                state = .idle
            } catch {
                self.error = error
                state = .idle
            }
        }
    }
}

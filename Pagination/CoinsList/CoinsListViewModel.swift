//
//  CoinsListViewModel.swift
//  Pagination
//
//  Created by Subba Nelakudhiti on 9/10/24.
//

import Foundation

@MainActor
final class CoinsListViewModel: ObservableObject {
    @Published var coins: [Coin] = [Coin]()
    @Published var error: Error?

    private let apiManager: APIManager
    private let pageLimit: Int = 50
    private var pageNumber: Int = 0
    @Published var isLoading: Bool = false

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
        guard !isLoading else { return }
        isLoading = true
        Task {
            do {
                pageNumber += 1
                let coins = try await apiManager.fetchCryptoCoinsData(pageLimit: pageLimit, pageNumber: pageNumber)
                self.coins.append(contentsOf: coins)
                isLoading = false
            } catch {
                self.error = error
                isLoading = false
            }
        }
    }
}

//
//  CoinsListView.swift
//  Pagination
//
//  Created by Subba Nelakudhiti on 9/10/24.
//

import SwiftUI

struct CoinsListView: View {
    @StateObject private var viewModel: CoinsListViewModel = CoinsListViewModel()
    @State private var showAlert: Bool = false

    private var coinsListView: some View {
        List {
            ForEach(viewModel.coins) { coin in
                let model = CoinViewModel(coinName: coin.name,
                                          coinSymbol: coin.symbol,
                                          coinImageUrl: coin.imageUrl,
                                          coinValue: coin.coinPrice,
                                          coinPriceChangePercentage: coin.priceChangePercentage,
                                          isCoinPriceIncreased: coin.isCoinPriceIncreased)
                CoinView(viewModel: model)
                    .onAppear {
                        if coin.id == viewModel.coins.last?.id {
                            viewModel.fetchData()
                        }
                    }
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                switch viewModel.state {
                case .fetching:
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                case .idle:
                    coinsListView
                        .refreshable {
                            viewModel.refreshData()
                        }
                        .onReceive(viewModel.$error, perform: { error in
                            if error != nil {
                                showAlert.toggle()
                            }
                        })
                        .alert(isPresented: $showAlert, content: {
                            Alert(title: Text("Error!"),
                                  message: Text(viewModel.error?.localizedDescription ?? ""))
                        })
                }
            }
            .navigationTitle("Crypto List")
        }
    }
}

#if DEBUG
#Preview {
    CoinsListView()
}
#endif

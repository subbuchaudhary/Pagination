//
//  CoinViewModel.swift
//  Pagination
//
//  Created by Subba Nelakudhiti on 9/10/24.
//

import Foundation

struct CoinViewModel {
    let coinName: String
    let coinSymbol: String
    let coinImageUrl: URL?
    let coinValue: String
    let coinPriceChangePercentage: String
    let isCoinPriceIncreased: Bool

    init(coinName: String,
         coinSymbol: String,
         coinImageUrl: URL?,
         coinValue: String,
         coinPriceChangePercentage: String,
         isCoinPriceIncreased: Bool) {
        self.coinName = coinName
        self.coinSymbol = coinSymbol
        self.coinImageUrl = coinImageUrl
        self.coinValue = coinValue
        self.coinPriceChangePercentage = coinPriceChangePercentage
        self.isCoinPriceIncreased = isCoinPriceIncreased
    }

    var coinPriceChangeIndicatorName: String {
        isCoinPriceIncreased ? "arrow.up.forward" : "arrow.down.right"
    }
}

#if DEBUG
extension CoinViewModel {
    static let mock: CoinViewModel = CoinViewModel(coinName: Coin.mock.name,
                                                   coinSymbol: Coin.mock.symbol,
                                                   coinImageUrl: URL(string: Coin.mock.image),
                                                   coinValue: Coin.mock.coinPrice,
                                                   coinPriceChangePercentage: Coin.mock.priceChangePercentage,
                                                   isCoinPriceIncreased: Coin.mock.isCoinPriceIncreased)
}
#endif

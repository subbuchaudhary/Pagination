//
//  Coin.swift
//  Pagination
//
//  Created by Subba Nelakudhiti on 9/10/24.
//

import Foundation

struct Coin: Identifiable, Hashable, Codable {
    var id: String = UUID().uuidString
    var coinId: String
    var symbol: String
    var name: String
    var image: String
    var currentPrice: Double
    var marketCapRank: Int
    var priceChangeInLast24Hours: Double

    enum CodingKeys: String, CodingKey {
        case coinId = "id"
        case symbol
        case name
        case image

        case currentPrice = "current_price"
        case marketCapRank = "market_cap_rank"
        case priceChangeInLast24Hours = "price_change_percentage_24h"
    }

    var isCoinPriceIncreased: Bool {
        priceChangeInLast24Hours > 0
    }

    var coinPrice: String {
        currentPrice.toCurrencyValue
    }

    var priceChangePercentage: String {
        abs(priceChangeInLast24Hours).toPercentageValue
    }

    var imageUrl: URL? {
        URL(string: image)
    }
}

#if DEBUG
extension Coin {
    static let mock: Coin = Coin(coinId: "bitcoin",
                                 symbol: "btc",
                                 name: "Bitcoin",
                                 image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
                                 currentPrice: 56839,
                                 marketCapRank: 1,
                                 priceChangeInLast24Hours: 3.49127)
}
#endif

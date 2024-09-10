//
//  CoinView.swift
//  Pagination
//
//  Created by Subba Nelakudhiti on 9/10/24.
//

import SwiftUI

struct CoinView: View {
    private let viewModel: CoinViewModel

    init(viewModel: CoinViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: viewModel.coinImageUrl) { image in
                image.resizable()
            } placeholder: {
                ProgressView().controlSize(.mini)
            }.frame(width: 30, height: 30)
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.coinName)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                Text(viewModel.coinSymbol.uppercased())
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.coinValue)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                HStack(spacing: 8) {
                    MyImage(imageName: viewModel.coinPriceChangeIndicatorName, tintColor: viewModel.isCoinPriceIncreased ? .green : .red, imageSize: .extraSmall)
                    Text(viewModel.coinPriceChangePercentage)
                        .foregroundColor(viewModel.isCoinPriceIncreased ? .green : .red)
                }
            }
        }
    }
}

#Preview {
    CoinView(viewModel: CoinViewModel.mock)
}

//
//  ContentView.swift
//  B2BrokerCryptoAssessment
//
//  Created by Samrez Ikram on 27/12/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      CoinsListView(viewModel: CoinListViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

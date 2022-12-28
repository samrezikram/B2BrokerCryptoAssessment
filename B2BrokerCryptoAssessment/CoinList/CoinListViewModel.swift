//
//  CoinListViewModel.swift
//  B2BrokerCryptoAssessment
//
//  Created by Samrez Ikram on 28/12/2022.
//

import Foundation
import Combine

final class CoinListViewModel: ObservableObject {
    @Published private(set) var state = State.idle
    
    private var bag = Set<AnyCancellable>()
    
    private let input = PassthroughSubject<Event, Never>()
    
    init() {
        Publishers.system(
            initial: state,
            reduce: Self.reduce,
            scheduler: RunLoop.main,
            feedbacks: [
                Self.whenLoading(),
                Self.userInput(input: input.eraseToAnyPublisher())
            ]
        )
        .assign(to: \.state, on: self)
        .store(in: &bag)
    }
    
    deinit {
        bag.removeAll()
    }
    
    func send(event: Event) {
        input.send(event)
    }
}

// MARK: - Inner Types

extension CoinListViewModel {
    enum State {
        case idle
        case loading
        case loaded([ListItem])
        case refresh([ListItem])
        case error(Error)
    }
    
    enum Event {
        case onAppear
        case onCoinsLoaded([ListItem])
        case onRefreshCrypto
        case onFailedToLoadCoins(Error)
    }
    
  struct ListItem: Identifiable {
    let id: Int
    let currencyName: String
    let usdValue: String
    let changePercentIn1Hour: Double
    let changePercentIn24Hour: Double
    let changePercentIn7Days: Double
    
    init(coinMarketStat: CoinMarketData) {
      id = coinMarketStat.id
      currencyName = coinMarketStat.name + " (\(coinMarketStat.symbol))"
      usdValue = "\(coinMarketStat.quote["USD"]?.price.rounded(toPlaces: 5) ?? 1.69) USD"
      changePercentIn1Hour = (coinMarketStat.quote["USD"]?.percentChange1H ?? 1.69).rounded(toPlaces: 2)
      changePercentIn24Hour = (coinMarketStat.quote["USD"]?.percentChange24H ?? 1.69).rounded(toPlaces: 2)
      changePercentIn7Days = (coinMarketStat.quote["USD"]?.percentChange7D ?? 1.69).rounded(toPlaces: 2)
    }
  }
}

// MARK: - State Machine

extension CoinListViewModel {
    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle:
            switch event {
            case .onAppear:
                return .loading
            default:
                return state
            }
        case .loading:
            switch event {
            case .onFailedToLoadCoins(let error):
                return .error(error)
            case .onCoinsLoaded(let coins):
                return .loaded(coins)
            default:
                return state
            }
        case .loaded:
            return state
        case .refresh:
          return .loading
        case .error:
            return state
        }
    }
    
    static func whenLoading() -> Feedback<State, Event> {
        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading = state else { return Empty().eraseToAnyPublisher() }
          return CryptoService.currencies()
            .map { $0.data.map(ListItem.init) }
            .map(Event.onCoinsLoaded)
            .catch { Just(Event.onFailedToLoadCoins($0)) }
            .eraseToAnyPublisher()
        }
    }
    
    static func userInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in input }
    }
}


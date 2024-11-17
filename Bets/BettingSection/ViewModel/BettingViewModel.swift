//
//  BettingViewModel.swift
//  Bets
//
//  Created by Admin on 11/16/24.
//

import UIKit
import BetsCore

final class BettingViewModel: BettingViewModelProtocol {
    weak var delegate: BettingViewModelDelegate?
    private let repository: BetRepository
    private var items = [BettingItemViewModel]()
    
    func item(at indexPath: IndexPath) -> BettingItemViewModelProtocol {
        items[indexPath.row]
    }
    
    func numberOfItemsInSection() -> Int {
        items.count
    }
    
    init(repository: BetRepository) {
        self.repository = repository
    }
    
    func loadData() async {
        do {
            let bets = try await self.repository.updateOdds()
            self.items = bets.map { BettingItemViewModel(title: $0.name.rawValue) }
            await MainActor.run {
                delegate?.reloadData()
            }
        } catch {
            print("Failed to load data: \(error)")
        }
    }
}


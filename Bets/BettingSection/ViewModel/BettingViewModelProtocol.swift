//
//  BettingViewModelProtocol.swift
//  Bets
//
//  Created by Admin on 11/17/24.
//

import UIKit

protocol BettingViewModelDelegate: AnyObject {
    func reloadData()
}

protocol BettingViewModelProtocol {
    func loadData() async
    var delegate: BettingViewModelDelegate? { get set }
    func item(at indexPath: IndexPath) -> BettingItemViewModelProtocol
    func numberOfItemsInSection() -> Int
}

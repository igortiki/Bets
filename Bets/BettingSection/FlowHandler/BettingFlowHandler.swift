//
//  BettingFlowHandler.swift
//  Bets
//
//  Created by Admin on 11/16/24.
//

import UIKit
import BetsCore

class BettingFlowHandler: MainFlowHandler {
    override func startFlow() {
        let betRepository = BetRepository(service: RemoteBetService.instance, transformer: BetTransformer())
        let viewModel = BettingViewModel(repository: betRepository)
        
        let bettingViewController = BettingViewController(viewModel: viewModel)
        viewModel.delegate = bettingViewController
        self.push(viewController: bettingViewController)
    }
}

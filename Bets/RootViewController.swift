//
//  RootViewController.swift
//  Bets
//
//  Created by Admin on 11/17/24.
//

import UIKit

class RootViewController: UIViewController {

    @IBAction func seeResultsBtnClick(_ sender: Any) {
        guard let navigationController = self.navigationController else { return }
        let bettingFlowHandler = BettingFlowHandler(navigationController: navigationController)
        bettingFlowHandler.startFlow()
    }
   

}

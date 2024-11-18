//
//  MainFlowHandler.swift
//  Bets
//
//  Created by Admin on 11/16/24.
//

import UIKit

protocol NavigationControllerProvider {
    
    var navigationController: UINavigationController? { get }
}

class MainFlowHandler: NavigationControllerProvider {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startFlow() {
        fatalError("Subclasses must implement the `startFlow` method.")
    }
    
    func endFlow() {
        fatalError("Subclasses must implement the `endFlow` method.")
    }
    
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func present(viewController: UIViewController, animated: Bool) {
        navigationController?.present(viewController, animated: animated, completion: nil)
    }
}

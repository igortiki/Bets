//
//  BetTransformer.swift
//  BetsCore
//
//  Created by Admin on 11/17/24.
//

public protocol BetTransformerProtocol {
    func transform(bets: [Bet]) async throws -> [Bet]
}

public class BetTransformer: BetTransformerProtocol {
    public init() {}
    
    public func transform(bets: [Bet]) async throws -> [Bet] {
        var updatedBets = bets
        
        for i in 0 ..< updatedBets.count {
            var bet = updatedBets[i]
            
            if bet.name != .playerPerformance, bet.name != .totalScore {
                decreaseQualityIfNeeded(bet: &bet)
            } else {
                increaseQualityIfNeeded(bet: &bet)
                increaseQualityForTotalScoreIfNeeded(bet: &bet)
            }
            
            decreaseSellInIfNeeded(bet: &bet)
            handleExpiredBet(bet: &bet)
            
            updatedBets[i] = bet
        }
        
        return updatedBets
    }
    
    fileprivate func increaseQualityIfNeeded(bet: inout Bet) {
        if bet.quality < 50 {
            bet.quality += 1
        }
    }
    
    fileprivate func decreaseQualityIfNeeded(bet: inout Bet) {
        if bet.quality > 0, bet.name != .winningTeam {
            bet.quality -= 1
        }
    }
    
    fileprivate func increaseQualityForTotalScoreIfNeeded(bet: inout Bet) {
        if bet.name == .totalScore {
            if bet.sellIn < 6 {
                increaseQualityIfNeeded(bet: &bet)
            }
            
            if bet.sellIn < 11 {
                increaseQualityIfNeeded(bet: &bet)
            }
        }
    }
    
    fileprivate func handleExpiredBet(bet: inout Bet) {
        if bet.sellIn < 0 {
            if bet.name == .totalScore {
                bet.quality = 0
            } else if bet.name != .playerPerformance {
                decreaseQualityIfNeeded(bet: &bet)
            } else if bet.name == .playerPerformance {
                increaseQualityIfNeeded(bet: &bet)
            }
        }
    }
    
    fileprivate func decreaseSellInIfNeeded(bet: inout Bet) {
        if bet.name != .winningTeam {
            bet.sellIn -= 1
        }
    }
}


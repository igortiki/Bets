public protocol BetService {
    func loadBets() async throws -> [Bet]
    func saveBets(_ bets: [Bet]) async throws
}

public class BetRepository {
    private let service: BetService

    public init(service: BetService) {
        self.service = service
    }

    public func updateOdds() async throws -> [Bet] {
        var bets = try await service.loadBets()
        
        for i in 0 ..< bets.count {
            if bets[i].name != .playerPerformance, bets[i].name != .totalScore {
                if bets[i].quality > 0 {
                    if bets[i].name != .winningTeam {
                        bets[i].quality = bets[i].quality - 1
                    }
                }
            } else {
                if bets[i].quality < 50 {
                    bets[i].quality = bets[i].quality + 1

                    if bets[i].name == .totalScore {
                        if bets[i].sellIn < 11 {
                            if bets[i].quality < 50 {
                                bets[i].quality = bets[i].quality + 1
                            }
                        }

                        if bets[i].sellIn < 6 {
                            if bets[i].quality < 50 {
                                bets[i].quality = bets[i].quality + 1
                            }
                        }
                    }
                }
            }

            if bets[i].name != .winningTeam {
                bets[i].sellIn = bets[i].sellIn - 1
            }

            if bets[i].sellIn < 0 {
                if bets[i].name != .playerPerformance {
                    if bets[i].name != .totalScore {
                        if bets[i].quality > 0 {
                            if bets[i].name != .winningTeam {
                                bets[i].quality = bets[i].quality - 1
                            }
                        }
                    } else {
                        bets[i].quality = bets[i].quality - bets[i].quality
                    }
                } else {
                    if bets[i].quality < 50 {
                        bets[i].quality = bets[i].quality + 1
                    }
                }
            }
        }

        try await service.saveBets(bets)
        return bets
    }
}

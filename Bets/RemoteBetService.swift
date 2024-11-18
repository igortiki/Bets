import BetsCore

actor RemoteBetService: BetService {
    private static let delay: UInt64 = 1_000_000_000
    
    public static let instance = RemoteBetService()
    
    private init() { }
    
    private var bets: [Bet] = [
        Bet(name: .winningTeam, sellIn: 8, quality: 15),
        Bet(name: .totalScore, sellIn: 5, quality: 26),
        Bet(name: .playerPerformance, sellIn: 9, quality: 4),
        Bet(name: .firstGoalScorer, sellIn: 10, quality: 49),
        Bet(name: .numberOfFouls, sellIn: 4, quality: 21),
        Bet(name: .cornerKicks, sellIn: 9, quality: 32),
        Bet(name: .yellowCards, sellIn: 0, quality: 45),
        Bet(name: .redCards, sellIn: 2, quality: 11),
        Bet(name: .offsides, sellIn: 2, quality: 14),
        Bet(name: .penalties, sellIn: 4, quality: 10),
        Bet(name: .halfTimeScore, sellIn: 1, quality: 42),
        Bet(name: .cleanSheet, sellIn: 10, quality: 34),
        Bet(name: .hatTrick, sellIn: 9, quality: 32),
        Bet(name: .numberOfSetsWon, sellIn: 8, quality: 17),
        Bet(name: .numberOfAces, sellIn: 6, quality: 46),
        Bet(name: .setScore, sellIn: 9, quality: 12),
    ]
    
    func loadBets() async throws -> [Bet] {
        try await Task.sleep(nanoseconds: RemoteBetService.delay)
        return bets
    }
    
    func saveBets(_ bets: [Bet]) async throws {
        try await Task.sleep(nanoseconds: RemoteBetService.delay)
        self.bets = bets
    }
}

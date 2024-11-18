public protocol BetService {
    func loadBets() async throws -> [Bet]
    func saveBets(_ bets: [Bet]) async throws
}

public class BetRepository {
    private let service: BetService
    private let transformer: BetTransformer

    public init(service: BetService, transformer: BetTransformer) {
        self.service = service
        self.transformer = transformer
    }

    public func updateOdds() async throws -> [Bet] {
        var bets = try await service.loadBets()
        bets = try await transformer.transform(bets: bets)

        try await service.saveBets(bets)
        return bets
    }
}

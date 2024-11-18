import XCTest
@testable import BetsCore

class BetsCoreTests: XCTestCase {
    var betTransformer = BetTransformer()

    func createBet(name: BetsName, quality: Int, sellIn: Int) -> Bet {
        return Bet(name: name, sellIn: sellIn, quality: quality)
    }
    
    func test_TotalScoreBet_IncreasesQuality() async throws {
        let bet = createBet(name: .totalScore, quality: 10, sellIn: 10)
        let updatedBets = try await betTransformer.transform(bets: [bet])
        
        XCTAssertEqual(updatedBets[0].quality, 12)
    }
    
    func test_WinningTeamBet_DoesNot_DecreaseQuality() async throws {
        let bet = createBet(name: .winningTeam, quality: 10, sellIn: 10)
        let updatedBets = try await betTransformer.transform(bets: [bet])
        
        XCTAssertEqual(updatedBets[0].quality, 10)
    }
    
    func test_Expired_TotalScoreBet_SetsQuality_ToZero() async throws {
        let bet = createBet(name: .totalScore, quality: 10, sellIn: -1)
        let updatedBets = try await betTransformer.transform(bets: [bet])
        
        XCTAssertEqual(updatedBets[0].quality, 0)
    }
}

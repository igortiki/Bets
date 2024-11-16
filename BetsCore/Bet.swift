public enum BetsName: String {
    case winningTeam = "Winning team"
    case totalScore = "Total score"
    case playerPerformance = "Player performance"
    case firstGoalScorer = "First goal scorer"
    case numberOfFouls = "Number of fouls"
    case cornerKicks = "Corner kicks"
    case yellowCards = "Yellow cards"
    case redCards = "Red cards"
    case offsides = "Offsides"
    case penalties = "Penalties"
    case halfTimeScore = "Half-time score"
    case cleanSheet = "Clean sheet"
    case hatTrick = "Hat trick"
    case numberOfSetsWon = "Number of sets won"
    case numberOfAces = "Number of aces"
    case setScore = "Set score"
}

public struct Bet {
    public var name: BetsName
    public var sellIn: Int
    public var quality: Int

    public init(name: BetsName, sellIn: Int, quality: Int) {
        self.name = name
        self.sellIn = sellIn
        self.quality = quality
    }
}

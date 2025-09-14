import Foundation

// MARK: - Main Bitcoin Data Structure
public struct CoinDataDTO: Decodable {
    public let id: String
    public let symbol: String
    public let name: String
    public let webSlug: String
    public let assetPlatformId: String?
    public let blockTimeInMinutes: Int
    public let hashingAlgorithm: String
    public let categories: [String]
    public let previewListing: Bool
    public let publicNotice: String?
    public let additionalNotices: [String]
    public let localization: LocalizationData
    public let description: LocalizationData
    public let links: CoinLinks
    public let image: CoinImage
    public let countryOrigin: String
    public let genesisDate: String
    public let sentimentVotesUpPercentage: Double
    public let sentimentVotesDownPercentage: Double
    public let watchlistPortfolioUsers: Int
    public let marketCapRank: Int
    public let marketData: CoinMarketDataDTO
    public let statusUpdates: [String]
    public let lastUpdated: String
    public let tickers: [Ticker]
    
    public enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case webSlug = "web_slug"
        case assetPlatformId = "asset_platform_id"
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case categories
        case previewListing = "preview_listing"
        case publicNotice = "public_notice"
        case additionalNotices = "additional_notices"
        case localization, description, links, image
        case countryOrigin = "country_origin"
        case genesisDate = "genesis_date"
        case sentimentVotesUpPercentage = "sentiment_votes_up_percentage"
        case sentimentVotesDownPercentage = "sentiment_votes_down_percentage"
        case watchlistPortfolioUsers = "watchlist_portfolio_users"
        case marketCapRank = "market_cap_rank"
        case marketData = "market_data"
        case statusUpdates = "status_updates"
        case lastUpdated = "last_updated"
        case tickers
    }
}

// MARK: - Links
public struct CoinLinks: Decodable {
    public let homepage: [String]
    public let whitepaper: String
    public let blockchainSite: [String]
    public let officialForumUrl: [String]
    public let chatUrl: [String]
    public let announcementUrl: [String]
    public let snapshotUrl: String?
    public let twitterScreenName: String
    public let facebookUsername: String
    public let bitcointalkThreadIdentifier: String?
    public let telegramChannelIdentifier: String
    public let subredditUrl: String
    public let reposUrl: ReposUrl
    
    public enum CodingKeys: String, CodingKey {
        case homepage, whitepaper
        case blockchainSite = "blockchain_site"
        case officialForumUrl = "official_forum_url"
        case chatUrl = "chat_url"
        case announcementUrl = "announcement_url"
        case snapshotUrl = "snapshot_url"
        case twitterScreenName = "twitter_screen_name"
        case facebookUsername = "facebook_username"
        case bitcointalkThreadIdentifier = "bitcointalk_thread_identifier"
        case telegramChannelIdentifier = "telegram_channel_identifier"
        case subredditUrl = "subreddit_url"
        case reposUrl = "repos_url"
    }
}

// MARK: - Repository URLs
public struct ReposUrl: Decodable {
    public let github: [String]
    public let bitbucket: [String]
}

// MARK: - Coin Image
public struct CoinImage: Decodable {
    public let thumb: String
    public let small: String
    public let large: String
}

// MARK: - Ticker
public struct Ticker: Decodable {
    public let base: String
    public let target: String
    public let market: TickerMarket
    public let last: Double
    public let volume: Double
    public let convertedLast: [String: Double]
    public let convertedVolume: [String: Double]
    public let trustScore: String
    public let bidAskSpreadPercentage: Double
    public let timestamp: String
    public let lastTradedAt: String
    public let lastFetchAt: String
    public let isAnomaly: Bool
    public let isStale: Bool
    public let tradeUrl: String
    public let tokenInfoUrl: String?
    public let coinId: String
    public let targetCoinId: String
    
    public enum CodingKeys: String, CodingKey {
        case base, target, market, last, volume
        case convertedLast = "converted_last"
        case convertedVolume = "converted_volume"
        case trustScore = "trust_score"
        case bidAskSpreadPercentage = "bid_ask_spread_percentage"
        case timestamp
        case lastTradedAt = "last_traded_at"
        case lastFetchAt = "last_fetch_at"
        case isAnomaly = "is_anomaly"
        case isStale = "is_stale"
        case tradeUrl = "trade_url"
        case tokenInfoUrl = "token_info_url"
        case coinId = "coin_id"
        case targetCoinId = "target_coin_id"
    }
}

// MARK: - Ticker Market
public struct TickerMarket: Decodable {
    public let name: String
    public let identifier: String
    public let hasTradingIncentive: Bool
    
    public enum CodingKeys: String, CodingKey {
        case name, identifier
        case hasTradingIncentive = "has_trading_incentive"
    }
}

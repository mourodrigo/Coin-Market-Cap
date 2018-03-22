//
//  CoinMarketCapTests.swift
//  CoinMarketCapTests
//
//  Created by Rodrigo Bueno Tomiosso on 21/03/2018.
//  Copyright © 2018 mourodrigo. All rights reserved.
//

import XCTest
import SwiftyJSON
import RealmSwift

@testable import CoinMarketCap

class CoinMarketCapTests: XCTestCase {
    let coins = [JSON(["id": "bitcoin",
                          "name": "Bitcoin",
                          "symbol": "BTC",
                          "rank": 1,
                          "price_usd": 8706.41,
                          "price_btc": 1.0,
                          "24h_volume_usd": 5824340000.0,
                          "market_cap_usd": 147428470113,
                          "available_supply": 16933325.0,
                          "total_supply": 16933325.0,
                          "max_supply": 21000000.0,
                          "percent_change_1h": -0.73,
                          "percent_change_24h": -4.45,
                          "percent_change_7d": 6.69,
                          "last_updated": 1521720268]),
                 JSON(["id": "ethereum",
                          "name": "Ethereum",
                          "symbol": "ETH",
                          "rank": 2,
                          "price_usd": 538.816,
                          "price_btc": 0.0621791,
                          "24h_volume_usd": 1582190000.0,
                          "market_cap_usd": 52989423887.0,
                          "available_supply": 98344191.0,
                          "total_supply": 98344191.0,
                          "max_supply": 0,
                          "percent_change_1h": -1.05,
                          "percent_change_24h": -7.09,
                          "percent_change_7d": -10.95,
                          "last_updated": 1521720253]),
                 JSON(["id": "ripple",
                          "name": "Ripple",
                          "symbol": "XRP",
                          "rank": 3,
                          "price_usd": 0.656217,
                          "price_btc": 0.00007554,
                          "24h_volume_usd": 448892000.0,
                          "market_cap_usd": 25654209634.0,
                          "available_supply": 39094094840.0,
                          "total_supply": 99992466986.0,
                          "max_supply": 100000000000,
                          "percent_change_1h": -1.37,
                          "percent_change_24h": -7.41,
                          "percent_change_7d": -5.28,
                          "last_updated": 1521720541])
    ]

    let realm = try! Realm()

    override func setUp() {
        super.setUp()
        self.measure {
            try! realm.write {
                realm.deleteAll()
                realm.add([
                    Coin.build(with: coins[2]),
                    Coin.build(with: coins[1]),
                    Coin.build(with: coins[0])
                    ], update: true)
            }
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDataSourceCount() {
        let coinTableVC = CoinMarketCapTableViewController()
        assert(coinTableVC.dataSource().count == coins.count, "Datasource is not returning the same number of coins inserted in the test")
    }
    
    func testDataSorting() {
        let coinTableVC = CoinMarketCapTableViewController()
        
        if let firstItem = coinTableVC.dataSource().first, let lastItem = coinTableVC.dataSource().last {
            assert(firstItem.market_cap_usd > lastItem.market_cap_usd, "Coins must be presented sorted by its market cap descending")
        }
    }
    
    func testCoinMapping() {
        let coinJson = coins[0]
        let coin = Coin.build(with: coinJson)
 
        assert(coin.name == coinJson["name"].stringValue, "Coin name mapping is not correct")
        assert(coin.market_cap_usd == coinJson["market_cap_usd"].int64Value, "Coin market cap mapping is not correct")
        assert(coin.last_updated == Date(timeIntervalSince1970: TimeInterval(coinJson["last_updated"].intValue)), "Coin last update mapping is not correct")

    }
    
}

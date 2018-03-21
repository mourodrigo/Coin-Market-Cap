//
//  Coin.swift
//  CoinMarketCap
//
//  Created by Rodrigo Bueno Tomiosso on 21/03/2018.
//  Copyright © 2018 mourodrigo. All rights reserved.
//

import Foundation
import RealmSwift

class Coin: Object {

    @objc dynamic var id : String = ""
    @objc dynamic var name : String = ""
    @objc dynamic var symbol : String = ""
    @objc dynamic var rank : Int = 0
    @objc dynamic var price_usd : Double = 0.0
    @objc dynamic var price_btc : Double = 0.0
    @objc dynamic var volume_usd_24: Double = 0.0
    @objc dynamic var market_cap_usd : Int64 = 0
    @objc dynamic var available_supply : Double = 0.0
    @objc dynamic var total_supply : Double  = 0.0
    @objc dynamic var max_supply : Double  = 0.0
    @objc dynamic var percent_change_1h : Double = 0.0
    @objc dynamic var percent_change_24h : Double = 0.0
    @objc dynamic var percent_change_7d : Double = 0.0
    @objc dynamic var last_updated : Date?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id : String, name : String, symbol : String, rank : Int,
                     price_usd : Double, price_btc : Double, volume_usd_24: Double,
                     market_cap_usd : Int64, available_supply : Double, total_supply : Double,
                     max_supply : Double, percent_change_1h : Double, percent_change_24h : Double,
                     percent_change_7d : Double, last_updated : Date) {
        
        self.init()
        
        self.id = id
        self.name = name
        self.symbol = symbol
        self.rank = rank
        self.price_usd = price_usd
        self.price_btc = price_btc
        self.volume_usd_24 = volume_usd_24
        self.market_cap_usd = market_cap_usd
        self.available_supply = available_supply
        self.total_supply = total_supply
        self.max_supply = max_supply
        self.percent_change_1h = percent_change_1h
        self.percent_change_24h = percent_change_24h
        self.percent_change_7d = percent_change_7d
        self.last_updated = last_updated
        
    }

}

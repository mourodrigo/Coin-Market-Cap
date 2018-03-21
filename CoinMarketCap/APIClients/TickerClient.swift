//
//  TickerClient.swift
//  CoinMarketCap
//
//  Created by Rodrigo Bueno Tomiosso on 21/03/2018.
//  Copyright © 2018 mourodrigo. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_SwiftyJSON
import RealmSwift

class TickerClient: Object {

    func fetch( start: Int = 0, limit: Int = 10 ) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let url = delegate.baseUrl + "/ticker/?start=\(start)&limit=\(limit)"
        
        Alamofire.request(url).responseSwiftyJSON(queue: DispatchQueue.global(),
                                                  options: JSONSerialization.ReadingOptions.mutableLeaves)
        { response in
            
            if let items = response.value?.array {
                
                let realm = try! Realm()
                
                if !realm.isInWriteTransaction { realm.beginWrite() }
                
                for item in items {
                    let coin = Coin(id: item["id"].stringValue,
                                    name: item["name"].stringValue,
                                    symbol: item["symbol"].stringValue,
                                    rank: item["rank"].intValue,
                                    price_usd: item["price_usd"].doubleValue,
                                    price_btc: item["price_btc"].doubleValue,
                                    volume_usd_24: item["24h_volume_usd"].doubleValue,
                                    market_cap_usd: item["market_cap_usd"].int64Value,
                                    available_supply: item["available_supply"].doubleValue,
                                    total_supply: item["total_supply"].doubleValue,
                                    max_supply: item["max_supply"].doubleValue,
                                    percent_change_1h: item["percent_change_1h"].doubleValue,
                                    percent_change_24h: item["percent_change_24h"].doubleValue,
                                    percent_change_7d: item["percent_change_7d"].doubleValue,
                                    last_updated: Date(timeIntervalSince1970: item["last_updated"].doubleValue)
                    )
                    realm.add(coin, update: true)
                }
                if realm.isInWriteTransaction { try! realm.commitWrite() }
            }
        }
    }
    
}

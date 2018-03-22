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

    func fetch( start: Int = 0, limit: Int = 10, completion: @escaping (() -> Void) ) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let url = delegate.baseUrl + "/ticker/?start=\(start)&limit=\(limit)"
        
        Alamofire.request(url).responseSwiftyJSON(queue: DispatchQueue.global(),
                                                  options: JSONSerialization.ReadingOptions.mutableLeaves)
        { response in
            
            if let items = response.value?.array {
                
                let realm = try! Realm()
                
                if !realm.isInWriteTransaction { realm.beginWrite() }
                
                for item in items {
                    let coin = Coin.build(with: item)
                    realm.add(coin, update: true)
                }
                if realm.isInWriteTransaction { try! realm.commitWrite() }
            }
            completion()            
        }
    }
    
}

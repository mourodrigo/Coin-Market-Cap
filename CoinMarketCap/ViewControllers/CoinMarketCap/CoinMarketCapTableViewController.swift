//
//  CoinMarketCapTableViewController.swift
//  CoinMarketCap
//
//  Created by Rodrigo Bueno Tomiosso on 21/03/2018.
//  Copyright © 2018 mourodrigo. All rights reserved.
//

import UIKit
import RealmSwift

class CoinMarketCapTableViewController: UITableViewController {

    let realm = try! Realm()
    let defaultCoin = "USD $"

    override func viewDidLoad() {
        super.viewDidLoad()
        TickerClient.init().fetch()
    }

    // MARK: - Table view data source
    
    func dataSource() -> Results<Coin> {
        return realm.objects(Coin.self).sorted(byKeyPath: "market_cap_usd", ascending: false)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoinMarketCapTableViewCell",
                                                       for: indexPath) as? CoinMarketCapTableViewCell
            else { fatalError("CoinMarketCapTableViewCell class implementation could not be found") }

        let coin = dataSource()[indexPath.row]
        
        cell.coinNameLabel.text = coin.name
        cell.marketCapLabel.text = "\(defaultCoin) \(coin.market_cap_usd)"
        cell.priceLabel.text = "\(defaultCoin) \(coin.price_usd)"

        return cell
    }
}

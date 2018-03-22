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
    let showDetailSegue = "ShowCoinMarketCapDetailViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchDataIfEmpty()
    }

    // MARK: - Table view data source

    func fetchDataIfEmpty() {
        if dataSource().count == 0 {
            TickerClient.init().fetch {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
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
        cell.marketCapLabel.text = "$ \(coin.market_cap_usd.format())"
        cell.priceLabel.text = "$ \(coin.price_usd.format())"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = dataSource()[indexPath.row]
        performSegue(withIdentifier: showDetailSegue, sender: coin)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showDetailSegue,
            let destination = segue.destination as? CoinMarketCapDetailViewController,
            let selectedCoin = sender as? Coin {
            destination.selectedCoin = selectedCoin
        }
    }
    
}

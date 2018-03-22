//
//  CoinMarketCapDetailViewController.swift
//  CoinMarketCap
//
//  Created by Rodrigo Bueno Tomiosso on 21/03/2018.
//  Copyright © 2018 mourodrigo. All rights reserved.
//

import UIKit

class CoinMarketCapDetailViewController: UIViewController {

    var selectedCoin: Coin?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var priceUsdLabel: UILabel!
    @IBOutlet weak var nameBtcLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var availableSupplyLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var maxSupplyLabel: UILabel!

    @IBOutlet weak var percent1hLabel: UILabel!
    @IBOutlet weak var percent24hLabel: UILabel!
    @IBOutlet weak var percent7dLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelValues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func setLabelValues() {
        if let coin = selectedCoin {
            nameLabel.text = coin.name
            rankLabel.text = "\(coin.rank)"
            priceUsdLabel.text = "$ \(coin.price_usd.format())"
            nameBtcLabel.text = "\(coin.price_btc.format())"
            volumeLabel.text = "$ \(coin.volume_usd_24.format())"
            marketCapLabel.text = "$ \(coin.market_cap_usd.format())"
            availableSupplyLabel.text = "$ \(coin.available_supply.format())"
            totalLabel.text = "\(coin.total_supply.format())"
            maxSupplyLabel.text = "\(coin.max_supply.format())"
        
            percent1hLabel.text = "\(coin.percent_change_1h.format())%"
            percent24hLabel.text = "\(coin.percent_change_24h.format())%"
            percent7dLabel.text = "\(coin.percent_change_7d.format())%"

            percent1hLabel.setColorForValue(value: coin.percent_change_1h)
            percent24hLabel.setColorForValue(value: coin.percent_change_24h)
            percent7dLabel.setColorForValue(value: coin.percent_change_7d)
        }
    }

}

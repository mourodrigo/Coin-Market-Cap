//
//  MoneyFormatExtension.swift
//  CoinMarketCap
//
//  Created by Rodrigo Bueno Tomiosso on 21/03/2018.
//  Copyright © 2018 mourodrigo. All rights reserved.
//

import Foundation

extension String {
    var toLocale: Locale {
        return Locale(identifier: self)
    }
}

extension Numeric {
    
    func format(numberStyle: NumberFormatter.Style = NumberFormatter.Style.decimal, locale: Locale = Locale.current) -> String {
        if let num = self as? NSNumber {
            let formater = NumberFormatter()
            formater.numberStyle = numberStyle
            formater.locale = locale
            return formater.string(from: num) ?? ""
        }
        return ""
    }
    
    func format(numberStyle: NumberFormatter.Style = NumberFormatter.Style.decimal, groupingSeparator: String = ".", decimalSeparator: String = ",") -> String {
        if let num = self as? NSNumber {
            let formater = NumberFormatter()
            formater.numberStyle = numberStyle
            formater.groupingSeparator = groupingSeparator
            formater.decimalSeparator = decimalSeparator
            return formater.string(from: num) ?? ""
        }
        return ""
    }
}

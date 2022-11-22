//
//  Date.swift
//  my_ios_clock
//
//  Created by 危末狂龍 on 2022/11/3.
//

import Foundation

extension Date{
    
    func toString(format: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    var localizedDescription: String {
        return description(with: .current)
    }

}

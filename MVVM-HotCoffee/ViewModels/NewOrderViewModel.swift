//
//  NewOrderViewModel.swift
//  MVVM-HotCoffee
//
//  Created by Raja Adeel Ahmed on 3/24/23.
//

import Foundation

struct NewOrderViewModel {
    var name: String?
    var email: String?
    var selectedSize: String?
    var selectedType: String?
    
    var types:[String] {
        return CoffeeType.allCases.map{ $0.rawValue.capitalized }
    }
    
    var sizes:[String] {
        return CoffeeSize.allCases.map{ $0.rawValue.capitalized }
    }
}

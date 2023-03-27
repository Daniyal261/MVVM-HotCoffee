//
//  Order.swift
//  MVVM-HotCoffee
//
//  Created by Raja Adeel Ahmed on 3/24/23.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable  {
    case cappuccino
    case latte
    case expressino
    case cortado
    case HotCoffee = "Hot Coffee"
}

enum CoffeeSize:String, Codable, CaseIterable {
    case small
    case medium
    case large
}

struct Order: Codable {
    var name:String = ""
    var email:String = ""
    var type:CoffeeType
    var size:CoffeeSize
}

extension Order {
    
    static var all : Resource<[Order]> = {
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL is incorrect")
        }
        return Resource<[Order]>(url: url)

    }()
    
    static func create (vm:NewOrderViewModel) -> Resource<Order?> {
        let order = Order(vm: vm)
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL is incorrect")
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            print("Error")
            fatalError("Error while encoding")
        }
        
        return Resource(url: url, httpMethod: .post, body: data)
        
    }
}

extension Order {
    init?( vm:NewOrderViewModel) {
        guard let name = vm.name,
              let email = vm.email,
              let selectedType = CoffeeType(rawValue: vm.selectedType!.lowercased()),
              let selectedSize = CoffeeSize(rawValue: vm.selectedSize!.lowercased()) else {
            return nil
        }
        
        self.name = name
        self.email = email
        self.type = selectedType
        self.size = selectedSize
    }
}



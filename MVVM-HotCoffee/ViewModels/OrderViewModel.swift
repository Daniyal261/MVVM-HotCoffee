//
//  OrderViewModel.swift
//  MVVM-HotCoffee
//
//  Created by Raja Adeel Ahmed on 3/24/23.
//

import Foundation

class OrderListViewModel {
    var ordersViewModel: [OrderViewModel]
    
    init() {
        self.ordersViewModel = [OrderViewModel]()
    }
}

extension OrderListViewModel {
    func orderViewModelAtIndex(at index: Int) -> OrderViewModel {
        return self.ordersViewModel[index];
    }
    
    func numberOfOrdersInSection() -> Int {
        return self.ordersViewModel.count
    }
}

struct OrderViewModel {
    let order:Order
}

extension OrderViewModel {
    var name:String {
        return self.order.name
    }
    
    var email:String {
        return self.order.email
    }
    
    var type: String {
        return self.order.type.rawValue.capitalized
    }
    
    var size:String {
        return self.order.size.rawValue.capitalized
    }
}

//
//  OrderTableViewController.swift
//  MVVM-HotCoffee
//
//  Created by Raja Adeel Ahmed on 3/24/23.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    var ordersListViewModel = OrderListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrder()
    }
    
    private func populateOrder() {
        WebService().load(resource: Order.all) { [weak self] result in
            switch result {
            case .success( let orders):
                self?.ordersListViewModel.ordersViewModel =  orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
   
}

extension OrderTableViewController: NewOrderDelegate {
    func newOrderViewControllerDidSave(order: Order, controller: UIViewController) {
        controller.dismiss(animated: true)
        let orderVM = OrderViewModel(order: order)
        self.ordersListViewModel.ordersViewModel.append(orderVM)
        self.tableView.insertRows(at: [IndexPath.init(row: self.ordersListViewModel.ordersViewModel.count - 1, section: 0)], with: .automatic)
    }
    
    func newOrderViewControllerDidClose(controller: UIViewController) {
        controller.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nvC = segue.destination as? UINavigationController,
              let addOrderVC = nvC.viewControllers.first as? AddOrderViewController
        else {
            return
        }
        addOrderVC.delegate = self
    }
    
    
}

extension OrderTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.ordersListViewModel.numberOfOrdersInSection()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = self.ordersListViewModel.orderViewModelAtIndex(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderViewCell", for: indexPath)
        
        cell.textLabel?.text = vm.type
        cell.detailTextLabel?.text = vm.size
        
        return cell
                                                                
    }
    
}

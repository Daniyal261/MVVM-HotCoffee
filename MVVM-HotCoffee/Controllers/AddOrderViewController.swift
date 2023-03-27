//
//  AddOrderViewController.swift
//  MVVM-HotCoffee
//
//  Created by Raja Adeel Ahmed on 3/24/23.
//

import UIKit

protocol NewOrderDelegate {
    func newOrderViewControllerDidSave(order:Order, controller:UIViewController)
    func newOrderViewControllerDidClose(controller:UIViewController)
}

class AddOrderViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var segmentSize: UISegmentedControl!
    @IBOutlet weak var tableView:UITableView!
    
    var viewModel = NewOrderViewModel()
    var delegate:NewOrderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCancelPressed(_ sender: Any) {
       if let delegate = self.delegate {
                delegate.newOrderViewControllerDidClose(controller: self)
        }
    }
    
    @IBAction func btnSavePressed(_ sender: Any) {
        let name = txtName.text
        let email = txtEmail.text
        let selectedSize = self.segmentSize.titleForSegment(at: self.segmentSize.selectedSegmentIndex)
        
        guard let selectedIndex = self.tableView.indexPathForSelectedRow else {
            // Error Selecting Coffee
            return
        }
        
        self.viewModel.name = name
        self.viewModel.email = email
        self.viewModel.selectedSize = selectedSize
        self.viewModel.selectedType = self.viewModel.types[selectedIndex.row]
        
        WebService().load(resource: Order.create(vm: self.viewModel)) { result in
            switch result {
            case .success(let order):
                print(order)
                if let order = order, let delegate = self.delegate {
                    DispatchQueue.main.async {
                        delegate.newOrderViewControllerDidSave(order: order, controller: self)
                    }
                    
                }
            case .failure( let error):
                print(error)
            }
        }
        
    }

}

extension AddOrderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.types.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewOrderCellView", for: indexPath)
        
        cell.textLabel?.text = self.viewModel.types[indexPath.row]
        
        return cell
    }
    
    
}

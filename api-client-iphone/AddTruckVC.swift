//
//  AddTruckVC.swift
//  api-client-iphone
//
//  Created by Khaled Rahman-Ayon on 01/02/17.
//  Copyright © 2017 Khaled Rahman-Ayon. All rights reserved.
//

import UIKit

class AddTruckVC: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var foodTypeField: UITextField!
    @IBOutlet weak var avgCostField: UITextField!
    @IBOutlet weak var latField: UITextField!
    @IBOutlet weak var longField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButtonTapped(sender: UIButton) {
        guard let name = nameField.text, nameField.text != "" else {
            showAlert(with: "Error", message: "Please enter a name")
            return
        }
        guard let foodType = foodTypeField.text, foodTypeField.text != "" else {
            showAlert(with: "Error", message: "Please enter a food type")
            return
        }
        guard let avgCost = Double(avgCostField.text!), avgCostField.text != "" else {
            showAlert(with: "Error", message: "Please enter an avaerage cost")
            return
        }
        guard let lat = Double(latField.text!), latField.text != "" else {
            showAlert(with: "Error", message: "Please enter a latitude")
            return
        }
        guard let long = Double(longField.text!), longField.text != "" else {
            showAlert(with: "Error", message: "Please enter a longitude")
            return
        }
        DataService.instance.addNewFoodTruck(name, foodtype: foodType, avgcost: avgCost, latitude: lat, longitude: long) { (Success) in
            if Success {
                print("We saved succcessfully")
                self.dismissViewController()
            } else {
                self.showAlert(with: "Error", message: "An error occured saving the new food truck")
                print("save wasn't complete")
            }
        }
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        dismissViewController()
    }

    @IBAction func backButtonTapped(sender: UIButton) {
        dismissViewController()
    }
    
    func dismissViewController() {
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showAlert(with title: String?, message: String?) {
        let alertControlelr = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertControlelr.addAction(okAction)
        present(alertControlelr, animated: true, completion: nil)
    }

}

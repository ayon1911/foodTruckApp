//
//  AddReviewVC.swift
//  api-client-iphone
//
//  Created by Khaled Rahman-Ayon on 01/02/17.
//  Copyright © 2017 Khaled Rahman-Ayon. All rights reserved.
//

import UIKit

class AddReviewVC: UIViewController {
    
    @IBOutlet weak var headerLabel:UILabel!
    @IBOutlet weak var reviewTitleFieldl: UITextField!
    @IBOutlet weak var reviewTextField: UITextView!
    
    var selectedFoodTruck: FoodTruck?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let truck = selectedFoodTruck {
                headerLabel.text = truck.name
        } else {
            headerLabel.text = "Error"
        }
        
    }
    
    @IBAction func addButtonTapped(sender: UIButton) {
        guard let truck = selectedFoodTruck else {
            showAlert(with: "Error", message: "Could not get selected truck")
            return
        }
        guard let title = reviewTitleFieldl.text, reviewTitleFieldl.text != "" else {
            showAlert(with: "Error", message: "Please enter a title")
            return
        }
        guard let reviewText = reviewTextField.text, reviewText != ""  else {
            showAlert(with: "Error", message: "Please put revive text")
            return
        }
        DataService.instance.addNewReview(truck.id, title: title, text: reviewText) { (Success) in
            if Success {
                
                print("We Saved Successfully")
                DataService.instance.getAllReviews(for: truck)
                self.dismissViewController()
            } else {
                self.showAlert(with: "Error", message: "An error occured while saving")
                print("Save was unsuccessfulll")
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
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Error", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }


}

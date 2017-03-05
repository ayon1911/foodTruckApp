//
//  FoodTruckReview.swift
//  api-client-iphone
//
//  Created by Khaled Rahman-Ayon on 25/01/17.
//  Copyright © 2017 Khaled Rahman-Ayon. All rights reserved.
//

import Foundation

struct FoodTruckReview {
    
    var id: String = ""
    var title: String = ""
    var text: String = ""
    
    static func parseReviewJSONData(data: Data) -> [FoodTruckReview] {
        var foodTruckReviews = [FoodTruckReview]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            //
            if let reviews = jsonResult as? [Dictionary<String, AnyObject>] {
                for review in  reviews {
                    
                    var newReview = FoodTruckReview()
                    newReview.id = review["_id"] as! String
                    newReview.title = review["title"] as! String
                    newReview.text = review["text"] as! String
                    
                    foodTruckReviews.append(newReview)
                }
            }
        } catch let err {
            print(err)
        }
        
        return foodTruckReviews
    }
}

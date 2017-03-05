//
//  Constans.swift
//  api-client-iphone
//
//  Created by Khaled Rahman-Ayon on 25/01/17.
//  Copyright © 2017 Khaled Rahman-Ayon. All rights reserved.
//

import Foundation

// Callbacks
// Typealias for callbacks used in Data Service
typealias callback = (_ success: Bool) -> ()

// Base URL
let BASE_API_URL = "http://localhost:3005/api/v1"

// Get all food trucks
let GET_ALL_FT_URL = "\(BASE_API_URL)/foodtruck"

// GET all reviews for specific food truck
let GET_ALL_FT_REVIEWS = "\(BASE_API_URL)/foodtruck/reviews"

//POST add new Food Truck
let POST_ADD_NEW_TRUCK = "\(BASE_API_URL)/foodtruck/add"

//POST add review for a specific Food Truck
let POST_ADD_NEW_REVIEW = "\(BASE_API_URL)/foodtruck/reviews/add"

//Boolean of user default keys
let DEFAULT_REGESTERED = "isREgestered"
let DEFAULT_AUTHENTICATED = "isAuthenticated"

//Auth Email
let DEFAULT_EMAIL = "email"

//Auth token
let DEFAULT_TOKEN = "authtoken"

//REGISTER url
let POST_REGESTER_ACCT = "\(BASE_API_URL)/account/register"

//Login url
let POST_LOGIN_ACCT = "\(BASE_API_URL)/account/login"


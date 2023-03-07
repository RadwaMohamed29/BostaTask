//
//  ResponseError.swift
//  BostaTask
//
//  Created by Radwa on 07/03/2023.
//

import Foundation

enum ResponseError: String, Error{
    case invalidURL = "Invalid URL Request"
    case invalidData = "Server Error"
    case parsingError = "Model Parsing Error"
}


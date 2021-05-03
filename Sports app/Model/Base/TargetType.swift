//
//  TargetType.swift
//  Sports app
//
//  Created by Moataz on 02/05/2021.
//

import Foundation
import Alamofire  // to use it's ParameterEncoding in Task enum

enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum Task {
    case requestPlain
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}

protocol TargetType {
    var baseURL: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var task: Task {get}
    var headers: [String: String]? {get}  //like adding authentication token
}


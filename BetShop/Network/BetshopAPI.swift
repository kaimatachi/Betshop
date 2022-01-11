//
//  BetshopAPI.swift
//  Betshop
//
//  Created by Jérémy Van Cauteren on 10/01/2022.
//

import Foundation
import Moya

enum BetshopAPI {
    case fetchBetshops(lat1: Double, long1: Double, lat2: Double, long2: Double)
}

extension BetshopAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://interview.superology.dev")!
    }
    
    var path: String {
        switch self {
        case .fetchBetshops:
            return "betshops"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case let .fetchBetshops(lat1, long1, lat2, long2):
            return .requestParameters(parameters: ["boundingBox":"\(lat1),\(long1),\(lat2),\(long2)"], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}

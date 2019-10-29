//
//  MoyaNearBy.swift
//  NearBy
//
//  Created by Mahmoud Hamad on 10/27/19.
//  Copyright © 2019 Mahmoud Hamad. All rights reserved.
//

import Moya



/*
https://api.foursquare.com/v2/venues/explore?client_id={{client_id}}&client_secret={{client_secret}}&v={{v}}&ll=1.283644,103.860753&query=steak&limit=10&offset=5&price=2,3
*/

enum MoyaNearBy {
    case getNetBy(latitude: String, longitude: String)
    case getVenuePhoto(venueId: String)
}

extension MoyaNearBy: TargetType {
    
    var baseURL: URL {
        switch self {
        case .getNetBy(let latitude, let longitude):
            return URL(string: "\(Constants.BASE_URL)?client_id=\(Constants.CLIENT_ID)&client_secret=\( Constants.CLIENT_SECRET)&v=\(Constants.V)&ll=\(latitude),\(longitude)&radius=1000&limit=1")!
        
        case .getVenuePhoto(let venueId):
            return URL(string: "\(Constants.BASE_URL)?client_id=\(Constants.CLIENT_ID)&client_secret=\( Constants.CLIENT_SECRET)&v=\(Constants.V)&group=venue&limit=1")!
        
        default:
            return URL(string: Constants.BASE_URL)!
        }
    }
    
    var path: String {
        switch self {
        case .getNetBy(let latitude, let longitude):
            return "venues/explore"
        case .getVenuePhoto(let venueId):
            return "venues/\(venueId)/photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNetBy(_, _), .getVenuePhoto(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .getNetBy(_, _), .getVenuePhoto(_):
            return .requestPlain
            /*return .requestParameters(parameters: ["client_id": Constants.CLIENT_ID,
                                                   "client_secret": Constants.CLIENT_SECRET,
                                                   "v": Constants.V,
                                                   "ll": "\(latitude),\(longitude)"]
                , encoding: URLEncoding.methodDependent)*/
        }
    }
    
    var headers: [String: String]? {
        return [
            "content-Type": "application/json"
        ]
    }
}

/*
https://api.foursquare.com/v2/venues/explore?client_id={{client_id}}&client_secret={{client_secret}}&v={{v}}&ll=1.283644,103.860753&query=steak&limit=10&offset=5&price=2,3
*/

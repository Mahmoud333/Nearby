//
//  Constants.swift
//  NearBy
//
//  Created by Mahmoud Hamad on 10/27/19.
//  Copyright © 2019 Mahmoud Hamad. All rights reserved.
//

import Foundation

struct Constants {
    static var BASE_URL: String {
        return "https://api.foursquare.com/v2/"
    }
    
    static var CLIENT_ID: String {
        return "TIWLXITTT4VM1G0VNJ3UOJB5NRJ31FR1HXXOASTSGDWI3KEH"
    }
    
    static var CLIENT_SECRET: String {
        return "KZ0U2U14AJARXBDT23CDOHGVI3UHSKHEVW0TRKRLDSOLTT04"
    }
    
    static var V: String {
        return "20190425"
    }
}

/*
https://api.foursquare.com/v2/venues/explore?client_id={{client_id}}&client_secret={{client_secret}}&v={{v}}&ll=1.283644,103.860753&query=steak&limit=10&offset=5&price=2,3
*/

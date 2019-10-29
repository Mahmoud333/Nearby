//
//  Connectivity.swift
//  WireTask
//
//  Created by Mahmoud Hamad on 8/3/19.
//  Copyright © 2019 Mahmoud Hamad. All rights reserved.
//

import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

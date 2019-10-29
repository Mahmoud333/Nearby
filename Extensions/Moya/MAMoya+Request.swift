//
//  MAMoya+Request.swift
//  Extensions
//
//  Created by Mahmoud Hamad on 10/27/19.
//  Copyright © 2019 Mahmoud Hamad. All rights reserved.
//

import Moya
import Alamofire

public extension MoyaProvider {

    public func MARequest<T: Decodable>(target: Target, onSuccess: @escaping (T, Data, Int?) -> (), onError: @escaping (NSError, Int?) -> ()) {
    
        let isConnectedToInternet = NetworkReachabilityManager()!.isReachable
        
        if isConnectedToInternet == false {
            onError(NSError(domain: "Please check your internet connection", code: -1, userInfo: nil), nil)
        }
    
        self.request(target) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode

                if statusCode == 200 {
                    do {
                        let object = try JSONDecoder().decode(T.self, from: response.data)
                        onSuccess(object, response.data, statusCode)
                    } catch {
                        print("Error: \(error)")
                        onError(NSError(domain: "Something went wrong.. please try again", code: -2, userInfo: nil), nil)
                    }
                }
            case .failure(let error):
                onError(NSError(domain: error.localizedDescription, code: -6, userInfo: nil), nil) //3
            }
        }
    }

}

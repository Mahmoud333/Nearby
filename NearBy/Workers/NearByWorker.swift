//
//  NearByWorker.swift
//  NearBy
//
//  Created by Mahmoud Hamad on 10/27/19.
//  Copyright © 2019 Mahmoud Hamad. All rights reserved.
//

import Moya
import Extensions

class NearByWorker {
    
    private let provider = MoyaProvider<MoyaNearBy>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func getNearBy(latitude: String, longitude: String, onSuccess: @escaping (VenueRecommendations) -> (), onError: @escaping (NSError) -> ()) {
        provider.MARequest(target: .getNetBy(latitude: latitude, longitude: longitude), onSuccess: { (response: VenueRecommendations, _, _) in
            onSuccess(response)
        }) { (error, _) in
            onError(error)
        }
    }
    
    func getVenuePhoto(venueId: String, onSuccess: @escaping (VenuePhotos) -> (), onError: @escaping (NSError) -> ()) {
        provider.MARequest(target: .getVenuePhoto(venueId: venueId), onSuccess: { (response: VenuePhotos, _, _) in
            var venuePhoto = response
            venuePhoto.venueId = venueId
            onSuccess(venuePhoto)
        }) { (error, _) in
            onError(error)
        }
    }
}

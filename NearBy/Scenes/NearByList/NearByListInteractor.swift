//
//  NearByListInteractor.swift
//  NearBy
//
//  Created by Mahmoud Hamad on 10/27/19.
//  Copyright © 2019 Mahmoud Hamad. All rights reserved.
//

import Foundation

class NearByListInteractor: NearByListInteractorInputProtocol {
    
    weak var presenter: NearByListInteractorOutputProtocol?
    
    private let nearBy = NearByWorker()
    
    func getNearBy(latitude: String, longitude: String) {
        nearBy.getNearBy(latitude: latitude, longitude: longitude, onSuccess: { [weak self] (response) in
            guard let strongSelf = self else { print("guard return: \(#line) \(#file)"); return }
            if response.response != nil {
                strongSelf.presenter?.nearByFetchedSuccessfully(nearBy: response.response!)
            } else {
                strongSelf.presenter?.nearByFetchingFailed(withError: NSError())
            }
        }) { [weak self] (error) in
            guard let strongSelf = self else { print("guard return: \(#line) \(#file)"); return }
            strongSelf.presenter?.nearByFetchingFailed(withError: error)
        }
    }
    
    func getImages(venueItems: [VenueRecommendations.GroupItem]) {
        let dispatchGroup = DispatchGroup()
        
        var venuePhotos = [VenuePhotos]()
        
        for item in venueItems {
            let venueId = item.venue?.id ?? ""
            
            dispatchGroup.enter()
            nearBy.getVenuePhoto(venueId: venueId, onSuccess: { (venuePhoto) in
                venuePhotos.append(venuePhoto)
                dispatchGroup.leave()
            }) { (error) in
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.presenter?.venuePhotosFetchedSuccessfully(photos: venuePhotos)
        }
    }
}

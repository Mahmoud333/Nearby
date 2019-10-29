//
//  NearByListPresenter.swift
//  NearBy
//
//  Created by Mahmoud Hamad on 10/27/19.
//  Copyright © 2019 Mahmoud Hamad. All rights reserved.
//

import Foundation

class NearByListPresenter {
    
    enum ListType {
        case realTime
        case singleUpdate
        
        var userDefaultsValues: String {
            switch self {
            case .realTime: return "RealTime"
            case .singleUpdate: return "SingleUpdate"
            }
        }
        
        func typeFrom(string: String) -> ListType? {
            if string == "RealTime" {
                return .realTime
            } else if string == "SingleUpdate" {
                return .singleUpdate
            }            
            return nil
        }
    }
    
    weak var view: NearByListViewProtocol?
    private let interactor: NearByListInteractorInputProtocol
    private let router: NearByListRouterProtocol
    
    lazy var locationManager: MALocationManager = {
        return MALocationManager(viewController: self.view!)
    }()
    
    private var nearByListResponse: VenueRecommendations.Response?
    private var venuePhotosListResponse: [VenuePhotos]?
    
    //private var operationalMode: ListType
    
    init(view: NearByListViewProtocol, interactor: NearByListInteractorInputProtocol, router: NearByListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        
        /*if let mode = Defaults.shared.getListType() {
         self.operationalMode = mode
         } else {
         Defaults.shared.setListType(type: .singleUpdate)
         self.operationalMode = .singleUpdate
         }*/
    }
}

//MARK:- NearByListPresenterProtocol
extension NearByListPresenter: NearByListPresenterProtocol {
    
    func fetch() {
        locationManager.checkAuthorization()
        
        //if let currentLocation = locationManager.currentLocation() {
        //    self.interactor.getNearBy(latitude: "\(currentLocation.latitude)", longitude: "\(currentLocation.longitude)")
        //}
        
        
        locationManager.updatedLocation = { [weak self] location in
            guard let strongSelf = self else { print("guard return: \(#line) \(#file)"); return }
            guard let location = location else { return }
            
            if Defaults.shared.getListType() == .realTime ||
                (Defaults.shared.getListType() == .singleUpdate && strongSelf.nearByListResponse == nil) {
                strongSelf.view?.showLoadingIndicator()
                strongSelf.interactor.getNearBy(latitude: "\(location.coordinate.latitude)", longitude: "\(location.coordinate.longitude)")
            }
        }
    }
    
    func viewDidLoad() {
        fetch()
    }
    
    func viewControllerTitle() -> String {
        switch Defaults.shared.getListType() {
        case .realTime: return "RealTime"
        case .singleUpdate: return "Single Update"
        }
    }
    
    func numberOfRows() -> Int {
        return nearByListResponse?.groups?.first?.items?.count ?? 0
    }
    
    func configure(cell: NearByListCellViewProtocol, indexPath: IndexPath) {
        guard let model = nearByListResponse?.groups?.first?.items?[indexPath.row] else { return }
        let photo = venuePhotosListResponse?.first(where: { $0.venueId == model.venue?.id })
        let viewModel = NearByListCellViewModel(nearBy: model, venuePhoto: photo)
        cell.configure(viewModel: viewModel)
    }
}


//MARK:- NearByListInteractorOutputProtocol
extension NearByListPresenter: NearByListInteractorOutputProtocol {
    func nearByFetchedSuccessfully(nearBy: VenueRecommendations.Response) {
        view?.hideLoadingIndicator()
        self.nearByListResponse = nearBy
        self.interactor.getImages(venueItems: nearBy.groups!.first!.items!)
        view?.reloadData()
    }
    
    func nearByFetchingFailed(withError error: Error) {
        view?.hideLoadingIndicator()
        if Connectivity.isConnectedToInternet() == false {
            view?.setErrorsImage(named: "WentWrong")
        } else {
            view?.setErrorsImage(named: "NoData")
        }
    }
    
    func venuePhotosFetchedSuccessfully(photos: [VenuePhotos]) {
        venuePhotosListResponse = photos
        view?.reloadData()
    }
}

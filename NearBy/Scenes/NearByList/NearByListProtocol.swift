//
//  NearByListProtocol.swift
//  NearBy
//
//  Created by Mahmoud Hamad on 10/27/19.
//  Copyright © 2019 Mahmoud Hamad. All rights reserved.
//

import UIKit

protocol NearByListViewProtocol: UIViewController {
    var presenter: NearByListPresenterProtocol! { get set }
    func setErrorsImage(named: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func reloadData()
}

protocol NearByListPresenterProtocol: class {
    var view: NearByListViewProtocol? { get set }
    func viewControllerTitle() -> String
    func viewDidLoad()
    func numberOfRows() -> Int
    func configure(cell: NearByListCellViewProtocol, indexPath: IndexPath)
}

protocol NearByListRouterProtocol {
    static func createInitForApp() -> UINavigationController
    static func createModule() -> UIViewController
}

protocol NearByListInteractorInputProtocol {
    var presenter: NearByListInteractorOutputProtocol? { get set }
    func getNearBy(latitude: String, longitude: String)
    func getImages(venueItems: [VenueRecommendations.GroupItem])
}

protocol NearByListInteractorOutputProtocol: class {
    func nearByFetchedSuccessfully(nearBy: VenueRecommendations.Response)
    func nearByFetchingFailed(withError error: Error)
    func venuePhotosFetchedSuccessfully(photos: [VenuePhotos])
}

protocol NearByListCellViewProtocol {
    func configure(viewModel: NearByListCellViewModel) 
}

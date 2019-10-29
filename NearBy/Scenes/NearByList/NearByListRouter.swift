//
//  NearByListRouter.swift
//  NearBy
//
//  Created by Mahmoud Hamad on 10/27/19.
//  Copyright © 2019 Mahmoud Hamad. All rights reserved.
//

import UIKit

class NearByListRouter: NearByListRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createInitForApp() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: NearByListRouter.createModule())
        //BG
        //navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //navigationController.navigationBar.shadowImage = UIImage()
        //navigationController.navigationBar.isTranslucent = true
        //Title Color
        //navigationController.navigationBar.tintColor = .white
        //navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navigationController
    }
    
    static func createModule() -> UIViewController {
        let view = UIStoryboard(name: "NearByListViewController", bundle: Bundle.main).instantiateInitialViewController() as! NearByListViewController
        let interactor = NearByListInteractor()
        let router = NearByListRouter()
        let presenter = NearByListPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }    
}


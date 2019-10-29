//
//  Globals.swift
//  NearBy
//
//  Created by Mahmoud Hamad on 10/28/19.
//  Copyright © 2019 Mahmoud Hamad. All rights reserved.
//

import Foundation


class Defaults {
    
    private init() {}
    static let shared = Defaults()
    
    let ud = UserDefaults.standard

    func getListType() -> NearByListPresenter.ListType {
        if let str = ud.object(forKey: "NearByListMode") as? String {
            return NearByListPresenter.ListType.realTime.typeFrom(string: str)!
        }
        ud.set(NearByListPresenter.ListType.singleUpdate.userDefaultsValues, forKey: "NearByListMode")
        return .singleUpdate
    }
    
    func setListType(type: NearByListPresenter.ListType) {
        ud.set(type.userDefaultsValues, forKey: "NearByListMode")
    }
    
    
}

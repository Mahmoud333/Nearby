//
//  VenueRecommendations.swift
//  NearBy
//
//  Created by Mahmoud Hamad on 10/27/19.
//  Copyright © 2019 Mahmoud Hamad. All rights reserved.
//


import Foundation

// MARK: - VenueRecommendations
struct VenueRecommendations: Codable {
    let meta: VenueRecommendations.Meta?
    let response: VenueRecommendations.Response?
    

    // MARK: - Meta
    struct Meta: Codable {
        let code: Int?
        let requestID: String?

        enum CodingKeys: String, CodingKey {
            case code
            case requestID = "requestId"
        }
    }

    // MARK: - Response
    struct Response: Codable {
        let suggestedFilters: VenueRecommendations.SuggestedFilters?
        let headerLocation, headerFullLocation, headerLocationGranularity: String?
        let totalResults: Int?
        let suggestedBounds: VenueRecommendations.SuggestedBounds?
        let groups: [VenueRecommendations.Group]?
    }

    // MARK: - Group
    struct Group: Codable {
        let type, name: String?
        let items: [VenueRecommendations.GroupItem]?
    }

    // MARK: - GroupItem
    struct GroupItem: Codable {
        let reasons: VenueRecommendations.Reasons?
        let venue: VenueRecommendations.Venue?
        let referralID: String?

        enum CodingKeys: String, CodingKey {
            case reasons, venue
            case referralID = "referralId"
        }
    }

    // MARK: - Reasons
    struct Reasons: Codable {
        let count: Int?
        let items: [VenueRecommendations.ReasonsItem]?
    }

    // MARK: - ReasonsItem
    struct ReasonsItem: Codable {
        let summary: String?
        let type: String?
        let reasonName: String?
    }

    // MARK: - Venue
    struct Venue: Codable {
        let id, name: String?
        let location: VenueRecommendations.Location?
        let categories: [VenueRecommendations.Category]?
        let photos: VenueRecommendations.Photos?
        let venuePage: VenueRecommendations.VenuePage?
    }

    // MARK: - Category
    struct Category: Codable {
        let id, name, pluralName, shortName: String?
        let icon: VenueRecommendations.Icon?
        let primary: Bool?
    }

    // MARK: - Icon
    struct Icon: Codable {
        let iconPrefix: String?
        let suffix: VenueRecommendations.Suffix?

        enum CodingKeys: String, CodingKey {
            case iconPrefix = "prefix"
            case suffix
        }
    }

    enum Suffix: String, Codable {
        case png = ".png"
    }

    // MARK: - Location
    struct Location: Codable {
        let address, crossStreet: String?
        let lat, lng: Double?
        let labeledLatLngs: [VenueRecommendations.LabeledLatLng]?
        let distance: Int?
        let cc: String?
        let neighborhood, city, state: String?
        let country: String?
        let formattedAddress: [String]?
        let postalCode: String?
    }


    // MARK: - LabeledLatLng
    struct LabeledLatLng: Codable {
        let label: String?
        let lat, lng: Double?
    }


    // MARK: - Photos
    struct Photos: Codable {
        let count: Int?
        let groups: [JSONAny]?
    }

    // MARK: - VenuePage
    struct VenuePage: Codable {
        let id: String?
    }

    // MARK: - SuggestedBounds
    struct SuggestedBounds: Codable {
        let ne, sw: VenueRecommendations.Ne?
    }

    // MARK: - Ne
    struct Ne: Codable {
        let lat, lng: Double?
    }

    // MARK: - SuggestedFilters
    struct SuggestedFilters: Codable {
        let header: String?
        let filters: [VenueRecommendations.Filter]?
    }

    // MARK: - Filter
    struct Filter: Codable {
        let name, key: String?
    }

}

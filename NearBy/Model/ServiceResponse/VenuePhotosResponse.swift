//
//  VenuePhotosResponse.swift
//  NearBy
//
//  Created by Mahmoud Hamad on 10/28/19.
//  Copyright © 2019 Mahmoud Hamad. All rights reserved.
//

import Foundation

// MARK: - VenuePhotos
struct VenuePhotos: Codable {
    var venueId: String!
    let meta: VenuePhotos.Meta?
    let response: VenuePhotos.Response?
    

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
        let photos: VenuePhotos.Photos?
    }

    // MARK: - Photos
    struct Photos: Codable {
        let count: Int?
        let items: [VenuePhotos.Item]?
    }

    // MARK: - Item
    struct Item: Codable {
        let id: String?
        let createdAt: Int?
        let itemPrefix: String?
        let suffix: String?
        let width, height: Int?
        let user: VenuePhotos.User?
        let visibility: String?

        enum CodingKeys: String, CodingKey {
            case id, createdAt
            case itemPrefix = "prefix"
            case suffix, width, height, user, visibility
        }
    }
    
    // MARK: - User
    struct User: Codable {
        let id, firstName, gender: String?
        let photo: VenuePhotos.Photo?
    }

    // MARK: - Photo
    struct Photo: Codable {
        let photoPrefix: String?
        let suffix: String?

        enum CodingKeys: String, CodingKey {
            case photoPrefix = "prefix"
            case suffix
        }
    }
}

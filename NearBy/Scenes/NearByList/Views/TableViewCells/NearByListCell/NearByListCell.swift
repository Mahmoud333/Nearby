//
//  NearByListCell.swift
//  NearBy
//
//  Created by Mahmoud Hamad on 10/27/19.
//  Copyright © 2019 Mahmoud Hamad. All rights reserved.
//

import UIKit
import Kingfisher

struct NearByListCellViewModel {
    var name: String
    var imageUrl: String?
    var address: String
    
    init(nearBy: VenueRecommendations.GroupItem, venuePhoto: VenuePhotos?) {
        self.name = nearBy.venue?.name ?? ""
        self.address = (nearBy.venue?.location?.formattedAddress ?? [""]).joined(separator: " | ")
        if let venuePhoto = venuePhoto {
            let photo = venuePhoto.response?.photos?.items?.first
            self.imageUrl = "\(photo?.itemPrefix ?? String())100x100\(photo?.suffix ?? String())"
        }
    }
}

class NearByListCell: UITableViewCell {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeAddressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension NearByListCell: NearByListCellViewProtocol {
    func configure(viewModel: NearByListCellViewModel) {
        self.placeNameLabel.text = viewModel.name
        self.placeAddressLabel.text = viewModel.address
        if let imageUrlStr = viewModel.imageUrl {
            self.placeImageView.kf.setImage(with: URL(string: imageUrlStr))
        }
    }
}

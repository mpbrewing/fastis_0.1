//
//  LocationClass.swift
//  fastis
//
//  Created by Michael Brewington on 3/23/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class LocationClass: NSObject {
    var locationName: String!
    var location: String!

    init(locationName: String, location: String) {
        self.locationName = locationName
        self.location = location
    }
}

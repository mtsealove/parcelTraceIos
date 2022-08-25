//
//  TrackingModel.swift
//  ParcelTracker
//
//  Created by Hash on 2022/08/25.
//

import Foundation

struct TrackingModel: Identifiable {
    let id = UUID()
    var datetime: String
    var location: String
    var state: String
}

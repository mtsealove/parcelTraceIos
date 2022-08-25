//
//  TrackingView.swift
//  ParcelTracker
//
//  Created by Hash on 2022/08/25.
//

import SwiftUI

struct TrackingView: View {
    let model: TrackingModel
    
    var body: some View {
        HStack() {
            Text(model.datetime)
                .padding(.trailing, 16)
            Text(model.state)
            Spacer()
            Text(model.location)
        }.padding(.vertical, 16)
            .padding(.horizontal, 12)
    }
}

struct TrackingView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingView(model: TrackingModel(
            datetime: "2022-08-25 19:00:00",
            location: "어딘가",
            state: "배송 완료"))
            .previewLayout(.sizeThatFits)
    }
}

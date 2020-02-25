//
//  CarDriver.swift
//  fnet
//
//  Created by Eddie on 5/28/19.
//  Copyright © 2019 Eddie. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

protocol CarDriverDelegate: class {
    func driver(_ driver: CarDriver, didReach position: CLLocationCoordinate2D)
}
final class CarDriver {
    private weak var map: GMSMapView?
    private weak var delegate: CarDriverDelegate?
    private let animationDuration: Double

    private let myCar: GMSMarker = {
        let myCar = GMSMarker()
        myCar.icon = UIImage(named: "ic_map_marker_my_car")
        myCar.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        myCar.zIndex = Int32.max
        return myCar
    }()

    init(map: GMSMapView, animationDuration: Double, startingPosition: CLLocationCoordinate2D, delegate: CarDriverDelegate? = nil) {
        self.map = map
        self.animationDuration = animationDuration
        self.delegate = delegate
        myCar.position = startingPosition
        myCar.map = map
    }

    deinit { myCar.map = nil }

    func drive(to: CLLocationCoordinate2D) {

        CATransaction.begin()
        CATransaction.setAnimationDuration(animationDuration)
        myCar.rotation = myCar.position.rotateAngle(to: to) * (180 / Double.pi)
        myCar.position = to
        CATransaction.commit()
        CATransaction.setCompletionBlock { [weak self] in
            guard let `self` = self else { return }
            self.delegate?.driver(self, didReach: to)
        }
    }
}

extension CLLocationCoordinate2D {
    func rotateAngle(to: CLLocationCoordinate2D) -> Double {
        let deltaLon = to.longitude - longitude
        let deltaLat = to.latitude - latitude
        let angle = (Double.pi * 0.5) - atan(deltaLat / deltaLon)

        if deltaLon > 0 { return angle }
        else if deltaLon < 0 { return angle + Double.pi }
        else if deltaLat < 0 { return Double.pi }

        return 0
    }
}

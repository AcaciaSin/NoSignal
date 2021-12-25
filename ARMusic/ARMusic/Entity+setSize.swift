//
//  Entity+setSize.swift
//  ARMusic
//
//  Created by 11 11 on 2021/12/25.
//

import RealityKit

extension Entity {
    func setSize(_ size: Float, relativeTo entity: Entity?) {
        let currentSize = self.visualBounds(recursive: true, relativeTo: entity, excludeInactive: false).extents.max()
        let scaleFactor = size / (currentSize)
        
        setScale([scaleFactor, scaleFactor, scaleFactor], relativeTo: nil)
    }
}

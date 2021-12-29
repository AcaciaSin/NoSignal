//
//  InstrumentEntity.swift
//  NoSignalAR
//
//  Created by student9 on 2021/12/26.
//

import RealityKit

struct InstrumentComponent: Component {
    var audioFile: String
}

extension Entity {
    func setSize(_ size: Float, relativeTo entity: Entity?) {
        let currentSize = self.visualBounds(recursive: true, relativeTo: entity, excludeInactive: false).extents.max()
        let scaleFactor = size / (currentSize)
        
        setScale([scaleFactor, scaleFactor, scaleFactor], relativeTo: nil)
    }
}

class InstrumentEntity: Entity, HasModel, HasCollision {
    
    var instrument: InstrumentComponent?
    var isPlaying: Bool = false
    
    required init() {
        super.init()
    }
    
    convenience init(modelEntity: ModelEntity) {
        self.init()
        self.model = modelEntity.model
        self.transform = modelEntity.transform
        
        setSize(0.8, relativeTo: nil)
        
        generateCollisionShapes(recursive: true)
    }
    
    func scale() {
        var scaleTransform = self.transform
        scaleTransform.scale = [1.5, 1.5, 1.5]
        self.move(to: scaleTransform, relativeTo: self, duration: 1, timingFunction: .easeInOut)
    }
    
    func shrink() {
        var scaleTransform = self.transform
        scaleTransform.scale = [0.66, 0.66, 0.66]
        scaleTransform.translation = .zero
        self.move(to: scaleTransform, relativeTo: self, duration: 1, timingFunction: .easeInOut)
    }
    
    func makeSound() {
        if self.isPlaying {
            return
        }
        guard let audioFile = self.instrument?.audioFile else { return }
        let audioResource = try! AudioFileResource.load(named: audioFile, in: nil, inputMode: .spatial, loadingStrategy: .preload, shouldLoop: false)
        playAudio(audioResource)
        self.isPlaying = true
    }
}


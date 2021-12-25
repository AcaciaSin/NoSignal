//
//  InstrumentEntity.swift
//  ARMusic
//
//  Created by 11 11 on 2021/12/25.
//

import RealityKit

class InstrumentEntity: Entity, HasModel, HasCollision {
    
    var instrument: InstrumentComponent?
    
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
        guard let audioFile = self.instrument?.audioFile else { return }
        let audioResource = try! AudioFileResource.load(named: audioFile, in: nil, inputMode: .spatial, loadingStrategy: .preload, shouldLoop: false)
        playAudio(audioResource)
    }
}


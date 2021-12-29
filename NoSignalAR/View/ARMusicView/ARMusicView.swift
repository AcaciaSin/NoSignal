//
//  ARMusicView.swift
//  NoSignalAR
//
//  Created by student9 on 2021/12/26.
//

import UIKit
import ARKit
import RealityKit
import Combine
import SwiftUI


struct InstrumentFiles {
    static let symbol1 = "symbol1.usdz"
    static let gramophone = "gramophone.usdz"
    static let symbol2 = "symbol2.usdz"

}

struct AudioFiles {
    static let symbol1 = "gramophone.mp3"
    static let gramophone = "gramophone.mp3"
    static let symbol2 = "gramophone.mp3"

}

struct TextElements {
  let initialText = "Cube"
  let extrusionDepth: Float = 0.01
  let font: MeshResource.Font = MeshResource.Font.systemFont(ofSize: 0.05, weight: .bold)
  let colour: UIColor = .white
}

extension Entity {
    func setText(_ content: String) {
        self.components[ModelComponent.self] = self.generatedModelComponent(text: content)
    }
    
    func generatedModelComponent(text: String) -> ModelComponent {
        let modelComponent: ModelComponent = ModelComponent(
          mesh: .generateText(text, extrusionDepth: TextElements().extrusionDepth, font: TextElements().font,
                              containerFrame: .zero, alignment: .center, lineBreakMode: .byTruncatingTail),
          materials: [SimpleMaterial(color: TextElements().colour, isMetallic: true)])

        return modelComponent
    }
}


struct ARMusicView: View {
    var body: some View {
        ZStack() {
            ARViewContainer()
        }
    }
}




struct ARViewContainer: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject {
        var view: ARView?        // << optional initially
        
        @objc func handleTap(_ sender: UIGestureRecognizer? = nil) {
            guard let tapLocation = sender?.location(in: view) else { return }
            guard let selectedInstrument = view!.entity(at: tapLocation) as? InstrumentEntity else { return }
            
            selectedInstrument.scale()
            selectedInstrument.makeSound()
            
            var cancellable: Cancellable? = nil
            cancellable = view!.scene.subscribe(to: AnimationEvents.PlaybackCompleted.self, on: selectedInstrument) { event in
                selectedInstrument.shrink()
                cancellable?.cancel()
            //doing something with object here, assigning to @Binding for example
                
            }
            
        }
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        //
    }

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
    
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        arView.enableObjectPlay()
        print("add tap gesture")
        
        
        let textEntity = Entity()
        textEntity.setText("Royals - Lorde")
        textEntity.position.x = 0
        textEntity.position.y = 0.3
        textEntity.position.z = 0
//        textEntity.generateCollisionShapes(recursive: true)
//        arView.installGestures([.translation, .rotation, .scale], for: textEntity as! HasCollision)
        
        
        anchor.addChild(textEntity)
        
//        print("settext")
        let instrumentComponents: [InstrumentComponent] = [
            InstrumentComponent(audioFile: AudioFiles.symbol1),
            InstrumentComponent(audioFile: AudioFiles.gramophone),
            InstrumentComponent(audioFile: AudioFiles.symbol2)
        ]
        
        let xCoordinates: [Float] = [-0.7, 0, 0.7]
        
//        print(InstrumentFiles.symbol1)
        
        var cancellable: AnyCancellable?
        cancellable = Entity.loadModelAsync(named: InstrumentFiles.symbol1)
            .append(Entity.loadModelAsync(named: InstrumentFiles.gramophone))
            .append(Entity.loadModelAsync(named: InstrumentFiles.symbol2))
            .collect()
            .sink(receiveCompletion: { completion in
//                print("completion: \(completion)")
                print("error when loading model")
                cancellable?.cancel()
            }, receiveValue: { entities in
                for (index, entity) in entities.enumerated() {
                    let instrument = InstrumentEntity(modelEntity: entity)
                    instrument.instrument = instrumentComponents[index]
                    instrument.name = "gramophone" + String(index)
                    cancellable?.cancel()
                    print("loading model: \(instrument.name)")
                    

                    instrument.generateCollisionShapes(recursive: true)
                    arView.installGestures([.translation, .rotation, .scale], for: instrument)
                    print("loading gesture")
                    
                    anchor.addChild(instrument)
                    instrument.position.x = xCoordinates[index]
                    instrument.position.z = -2
                }
                
                
            })
//        print("ModelEntity")

        arView.scene.anchors.append(anchor)

        return arView
    }

}


extension ARView {
    func enableObjectPlay() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(recognizer:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTapGesture(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: self)
        guard let selectedInstrument = self.entity(at: location) as? InstrumentEntity else {
            print("tap wrong")
            return
        }
        print("tap instrument")
        selectedInstrument.makeSound()
        selectedInstrument.scale()
        selectedInstrument.shrink()
    }
}

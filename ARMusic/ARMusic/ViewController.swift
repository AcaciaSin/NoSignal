//
//  ViewController.swift
//  ARMusic
//
//  Created by 11 11 on 2021/12/25.
//

import UIKit
import RealityKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        InstrumentComponent.registerComponent()

        setupGestureRecognizer()
        
        let anchor = AnchorEntity(plane: .horizontal)
       
        arView.scene.anchors.append(anchor)
                
        let instrumentComponents: [InstrumentComponent] = [
            InstrumentComponent(audioFile: AudioFiles.symbol1),
            InstrumentComponent(audioFile: AudioFiles.gramophone),
            InstrumentComponent(audioFile: AudioFiles.symbol2)
        ]
        
        let xCoordinates: [Float] = [-0.7, 0, 0.7]
        
        var cancellable: AnyCancellable? = nil
        cancellable = ModelEntity.loadModelAsync(named: InstrumentFiles.symbol1)
            .append(ModelEntity.loadModelAsync(named: InstrumentFiles.gramophone))
            .append(ModelEntity.loadModelAsync(named: InstrumentFiles.symbol2))
            .collect()
            .sink(receiveCompletion: { completion in
                cancellable?.cancel()
            }, receiveValue: { entities in
                for (index, entity) in entities.enumerated() {
                    let instrument = InstrumentEntity(modelEntity: entity)
                    instrument.instrument = instrumentComponents[index]
                    
                    anchor.addChild(instrument)
 
                    instrument.position.x = xCoordinates[index]
                    instrument.position.z = -2
                }
                
                cancellable?.cancel()
            })
        let textEntity = Entity()
        textEntity.setText("Royals - Lorde")
        textEntity.position.x = 0
        textEntity.position.y = 0.3
        textEntity.position.z = 0
        
        anchor.addChild(textEntity)
    }
}

extension ViewController {
    func setupGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        arView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: arView)
        guard let selectedInstrument = arView.entity(at: tapLocation) as? InstrumentEntity else { return }
        
        selectedInstrument.scale()
        selectedInstrument.makeSound()
        
        var cancellable: Cancellable? = nil
        cancellable = arView.scene.subscribe(to: AnimationEvents.PlaybackCompleted.self, on: selectedInstrument) { event in
            selectedInstrument.shrink()
            cancellable?.cancel()
        }
    }
}

extension ViewController {
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
}

extension Entity {

  /// Changes The Text Of An Entity
  /// - Parameters:
  ///   - content: String
    func setText(_ content: String){ self.components[ModelComponent.self] = self.generatedModelComponent(text: content) }

  /// Generates A Model Component With The Specified Text
  /// - Parameter text: String
  func generatedModelComponent(text: String) -> ModelComponent{

    let modelComponent: ModelComponent = ModelComponent(

      mesh: .generateText(text, extrusionDepth: TextElements().extrusionDepth, font: TextElements().font,
                          containerFrame: .zero, alignment: .center, lineBreakMode: .byTruncatingTail),

      materials: [SimpleMaterial(color: TextElements().colour, isMetallic: true)]

    )

    return modelComponent
  }

}

//--------------------
//MARK:- Text Elements
//--------------------

/// The Base Setup Of The MeshResource
struct TextElements{

  let initialText = "Cube"
  let extrusionDepth: Float = 0.01
  let font: MeshResource.Font = MeshResource.Font.systemFont(ofSize: 0.05, weight: .bold)
  let colour: UIColor = .white

}

//
//  ViewController.swift
//  test2
//
//  Created by 11 11 on 2021/12/16.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
//        let boxAnchor = try! Experience.loadBox()
        let boxAnchor = try! MusicPlayer.loadPlayer()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
    }
}

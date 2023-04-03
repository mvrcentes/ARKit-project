//
//  CustomVRView.swift
//  ARKit project
//
//  Created by Marco Ramirez on 3/04/23.
//

import ARKit
import RealityKit
import SwiftUI
import Combine

class CustomARView: ARView {
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
            
        subscribeToActiveSteam()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func subscribeToActiveSteam() {
        ARManager.shared.actionStream
            .sink {[weak self] action in
                switch action {
                case .placeBlock(let color):
                    self?.placeBlueBlock(ofColor: color)
                case.removeAllAnchors:
                    self?.scene.anchors.removeAll()
                }
            }
        .store(in: &cancellables)
    }
    
    func configurationExample() {
        let configuration = ARWorldTrackingConfiguration()
        session.run(configuration)
        
        let _ = ARGeoTrackingConfiguration()
        
        let _ = ARBodyTrackingConfiguration()
    }
    
    func anchorExample() {
        let coordinateAnchor = AnchorEntity(world: .zero)
        
        let _ = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: .zero))
        let _ = AnchorEntity(.plane(.vertical, classification: .any, minimumBounds: .zero))
        
        let _ = AnchorEntity(.face)
        
        let _ = AnchorEntity(.image(group: "group", name: "name"))
                
        scene.addAnchor(coordinateAnchor)
    }
    
    func entityExample() {
        let _ = try? Entity.load(named: "usdzFileName")
        
        let _ = try? Entity.load(named: "realityFileName")
        
        let box = MeshResource.generateBox(size: 1)
        let entity = ModelEntity(mesh: box)
        
        let anchor = AnchorEntity()
        anchor.addChild(entity)
    }
    
    func placeBlueBlock(ofColor color: Color) {
        let block = MeshResource.generateBox(size: 1)
        let material  = SimpleMaterial(color: UIColor(color), isMetallic: false)
        let entity = ModelEntity(mesh: block, materials: [material])
        
        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: .one))
        anchor.addChild(entity)
        
        scene.addAnchor(anchor)
    }
}

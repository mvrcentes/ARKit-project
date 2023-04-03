//
//  ARManager.swift
//  ARKit project
//
//  Created by Marco Ramirez on 3/04/23.
//

import Combine

class ARManager {
    static let shared = ARManager()
    private init() { }
    
    var actionStream = PassthroughSubject<ARAction, Never>()
    
}
 

//
//  HandDetection.swift
//  ARKit project
//
//  Created by Marco Ramirez on 4/04/23.
//

import ARKit
import Vision

class HandDetection {
    var handPosition: SIMD3<Float>?
    
    private let visionSequenceHandler = VNSequenceRequestHandler()
    private var currentObservation: VNHumanHandPoseObservation?
    
    init() {}
    
    func detect(in pixelBuffer: CVPixelBuffer, orientation: CGImagePropertyOrientation, completion: @escaping ([CGPoint]?) -> Void) {
        
        // Create a new Vision request for hand detection
        let request = VNDetectHumanHandPoseRequest(completionHandler: { (request, error) in
            
            // Make sure we have a valid observation
            guard let observation = request.results?.first as? VNHumanHandPoseObservation else {
                completion(nil)
                return
            }
            
            // Save the observation
            self.currentObservation = observation
            
            // Get the hand landmarks and convert them to CGPoints
            let landmarks = try? observation.recognizedPoints(.all)
            let points = landmarks?.values.map { (value) -> CGPoint in
                let cgPoint = CGPoint(x: value.location.x, y: 1 - value.location.y)
                return cgPoint
            }
            
            // Pass the points to the completion handler
            completion(points)
        })
        
        // Rotate the pixel buffer based on the orientation of the device
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: orientation, options: [:])
        
        // Perform the request
        do {
            try imageRequestHandler.perform([request])
        } catch {
            completion(nil)
        }
    }
}


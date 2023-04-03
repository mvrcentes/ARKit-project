//
//  CustomARViewRepresentable.swift
//  ARKit project
//
//  Created by Marco Ramirez on 3/04/23.
//

import SwiftUI

struct CustomARViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return CustomARView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

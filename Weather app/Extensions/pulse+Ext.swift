//
//  pulse+Ext.swift
//  Weather app
//
//  Created by mücahit öztürk on 18.03.2024.
//

import UIKit

extension UIButton {
    func addPulseAnimation() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func removePulseAnimation() {
        layer.removeAnimation(forKey: "pulse")
    }
}

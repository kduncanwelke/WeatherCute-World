//
//  ViewExtension.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/17/21.
//

import Foundation
import UIKit

extension UIView {
    func popUp() {
        UIView.animate(withDuration: 0.2, animations: {
            self.isHidden = false
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: { [unowned self] _ in
            self.transform = CGAffineTransform.identity
        })
    }
    
    func goDown() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: { [unowned self] _ in
            self.isHidden = true
        })
    }
}

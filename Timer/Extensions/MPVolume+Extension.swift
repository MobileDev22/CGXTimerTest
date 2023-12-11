//
//  MPVolume+Extension.swift
//  Timer
//
//  Created by Mideveloper on 12/12/2023.
//

import Foundation
import MediaPlayer

extension MPVolumeView {
    /// Set the iPhone's Media Volume to new value
    func setVolume(value: Float) {
        // MARK: - Warning - Not a feasible solution for App Store Submission but just for demo purposes
        let slider = self.subviews.first(where: { $0 is UISlider }) as? UISlider
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = value
        }
    }
}

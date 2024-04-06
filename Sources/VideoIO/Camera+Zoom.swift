//
//  Camera+Zoom.swift
//
//
//  Created by Daniel Murfin on 2024/04/06.
//

import Foundation
import AVFoundation

@available(iOS 10.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(macCatalyst 14.0, *)
extension Camera {
    @available(macOS, unavailable)
    public func setZoom(to zoomFactor: CGFloat, withRate rate: Float?) throws {
        guard let videoDevice = self.videoDevice else {
            return
        }
        let clampedZoom = min(max(zoomFactor, videoDevice.minAvailableVideoZoomFactor), videoDevice.maxAvailableVideoZoomFactor)
        try videoDevice.lockForConfiguration()
        if let rate = rate {
            videoDevice.ramp(toVideoZoomFactor: clampedZoom, withRate: rate)
        } else {
            videoDevice.videoZoomFactor = clampedZoom
        }
        videoDevice.unlockForConfiguration()
    }
}

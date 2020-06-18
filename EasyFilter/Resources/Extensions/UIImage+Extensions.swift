//
//  CIFilter+Extensions.swift
//  EasyFilter
//
//  Created by Emre Çelik on 9.06.2020.
//  Copyright © 2020 Emre Çelik. All rights reserved.
//

import UIKit

public enum FilterType: String {
    case Gamma = "CIGammaAdjust,inputPower"
    case ExposureAdjust = "CIExposureAdjust,inputEV"
    case Hue = "CIHueAdjust,inputAngle"
    case Vibrance = "CIVibrance,inputAmount"
    case ColorPasterize = "CIColorPosterize,inputLevels"
    case Sepia = "CISepiaTone,inputIntensity"
    case Vignette = "CIVignette,inputIntensity"
    case SharpenLuminance = "CISharpenLuminance,inputSharpness"
}

public enum EffectType: String {
    case Chrome = "CIPhotoEffectChrome"
    case Fade = "CIPhotoEffectFade"
    case Instant = "CIPhotoEffectInstant"
    case Mono = "CIPhotoEffectMono"
    case Noir = "CIPhotoEffectNoir"
    case Process = "CIPhotoEffectProcess"
    case Tonal = "CIPhotoEffectTonal"
    case Transfer =  "CIPhotoEffectTransfer"
}

extension UIImage {
    
    public static let context = CIContext(options: nil)
    
    func addEffect(effect : EffectType) -> UIImage {
        let filter = CIFilter(name: effect.rawValue)
        let ciInput = CIImage(image: self)
        filter?.setValue(ciInput, forKey: "inputImage")
        let ciOutput = filter?.outputImage
        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
        return UIImage(cgImage: cgImage!)
    }
    
    func addFilter(filter: FilterType, value: Float) -> UIImage? {
        let filterDesc = filter.rawValue.components(separatedBy: ",")
        let filterName = filterDesc[0]
        let filterInput = filterDesc[1]
        
        if let currentFilter = CIFilter(name: filterName) {
            let beginImage = CIImage(image: self)
            
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.setValue(value, forKey: filterInput)
            
            if let output = currentFilter.outputImage {
                if let cgimg = UIImage.context.createCGImage(output, from: output.extent) {
                    return UIImage(cgImage: cgimg)
                }
            }
        }
        return nil
    }
    
    func getFilteredImage(filter: Filter) -> UIImage? {
        return self.addFilter(filter: .Gamma, value: filter.gamma)?
            .addFilter(filter: .ExposureAdjust, value: filter.exposureAdjust)?
            .addFilter(filter: .Hue, value: filter.hue)?
            .addFilter(filter: .Vibrance, value: filter.vibrance)?
            .addFilter(filter: .ColorPasterize, value: filter.colorPasterize)?
            .addFilter(filter: .Sepia, value: filter.sepia)?
            .addFilter(filter: .Vignette, value: filter.vignette)?
            .addFilter(filter: .SharpenLuminance, value: filter.sharpenLuminance)
    }

    func aspectFittedToMaxLengthData(maxLength: CGFloat, compressionQuality: CGFloat) -> Data {
        let scale = maxLength / max(self.size.height, self.size.width)
        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        let renderer = UIGraphicsImageRenderer(size: self.size, format: format)
        return renderer.jpegData(withCompressionQuality: compressionQuality) { context in
            self.draw(in: CGRect(origin: .zero, size: self.size))
        }
    }
    func aspectFittedToMaxLengthImage(maxLength: CGFloat, compressionQuality: CGFloat) -> UIImage? {
        let newImageData = aspectFittedToMaxLengthData(maxLength: maxLength, compressionQuality: compressionQuality)
        return UIImage(data: newImageData)
    }
    
}

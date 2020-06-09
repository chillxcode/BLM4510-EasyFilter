//
//  CIFilter+Extensions.swift
//  EasyFilter
//
//  Created by Emre Çelik on 9.06.2020.
//  Copyright © 2020 Emre Çelik. All rights reserved.
//

import UIKit

public enum FilterType: String {
    case Gamma = "CIGammaAdjust,inputPower"                 //Default 0.75
    case ExposureAdjust = "CIExposureAdjust,inputEV"        //Default 0.5
    case Hue = "CIHueAdjust,inputAngle"
    case Vibrance = "CIVibrance,inputAmount"
    case ColorPasterize = "CIColorPosterize,inputLevels"    //Default Value 6.0
    case Sepia = "CISepiaTone,inputIntensity"               //Default Value 1.0
    case Vignette = "CIVignette,inputIntensity"             //Default Value 0.0 also takes inputRadius = 1.0(DV)
//    case GlassLozenge = "CIGlassLozenge,inputRefraction"
//    case CMYKHalftone = "CICMYKHalftone,inputSharpness"     //Default 0.7, 0.0 da cmyk oluyo
    case SharpenLuminance = "CISharpenLuminance,inputSharpness" //Default 0.4
//    case Edges = "CIEdges,inputIntensity"          //Default 1.0
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
        // convert UIImage to CIImage and set as input
        let ciInput = CIImage(image: self)
        filter?.setValue(ciInput, forKey: "inputImage")
        // get output CIImage, render as CGImage first to retain proper UIImage scale
        let ciOutput = filter?.outputImage
        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
        //Return the image
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
        return self.addFilter(filter: .Gamma, value: filter.Gamma)?
            .addFilter(filter: .ExposureAdjust, value: filter.ExposureAdjust)?
            .addFilter(filter: .Hue, value: filter.Hue)?
            .addFilter(filter: .Vibrance, value: filter.Vibrance)?
            .addFilter(filter: .ColorPasterize, value: filter.ColorPasterize)?
            .addFilter(filter: .Sepia, value: filter.Sepia)?
            .addFilter(filter: .Vignette, value: filter.Vignette)?
            .addFilter(filter: .SharpenLuminance, value: filter.SharpenLuminance)
    }

}

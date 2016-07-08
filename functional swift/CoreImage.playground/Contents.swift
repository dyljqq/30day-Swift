//: Playground - noun: a place where people can play

import Cocoa

typealias Filter = CIImage-> CIImage

func blur(radius: Double)-> Filter {
    return { image in
        let parameters = [
            kCIInputRadiusKey: radius,
            kCIInputImageKey: image
        ]
        guard let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: parameters) else {
            fatalError()
        }
        guard let outputImage = filter.outputImage else {
            fatalError()
        }
        return outputImage
    }
}

func colorGenerator(color: NSColor)-> Filter {
    return { _ in
        guard let c = CIColor(color: color) else {
            fatalError()
        }
        let parameters = [kCIInputColorKey: c]
        guard let filter = CIFilter(name: "CIConstantColorGenerator", withInputParameters: parameters) else {
            fatalError()
        }
        guard let outputImage = filter.outputImage else {
            fatalError()
        }
        return outputImage
    }
}

func compositeSourceOver(overlay: CIImage)-> Filter {
    return { image in
        let parameters = [
            kCIInputBackgroundImageKey: image,
            kCIInputImageKey: overlay
        ]
        guard let filter = CIFilter(name: "CISourceOverCompositing", withInputParameters: parameters) else {
            fatalError()
        }
        guard let outputImage = filter.outputImage else {
            fatalError()
        }
        let cropRect = image.extent
        return outputImage.imageByCroppingToRect(cropRect)
    }
}

func colorOverlay(color: NSColor)-> Filter {
    return { image in
        let overlay = colorGenerator(color)(image)
        return compositeSourceOver(overlay)(image)
    }
}

let url = NSURL(string: "http://g.hiphotos.baidu.com/baike/h%3D160/sign=7763f4b06481800a71e58d08813533d6/e7cd7b899e510fb3a91f7aa8d133c895d1430c8e.jpg")!
let image = CIImage(contentsOfURL: url)!

let blurRadius = 5.0
let overlayColor = NSColor.redColor().colorWithAlphaComponent(0.2)
let bluredImage = blur(blurRadius)(image)
let overlaidImage = colorOverlay(overlayColor)(bluredImage)

infix operator >>> { associativity left }

func >>> (filter1: Filter, filter2: Filter)-> Filter {
    return { image in
        return filter2(filter1(image))
    }
}

let myFilter2 = blur(blurRadius) >>> colorOverlay(overlayColor)
let result = myFilter2(image)

//
//  ShadowImageView.swift
//  ShadowImageView
//
//  Created by olddonkey on 2017/4/29.
//  Copyright © 2017年 olddonkey. All rights reserved.
//

import UIKit
import CoreGraphics

@IBDesignable
class ShadowImageView: UIView {

    private var imageView = UIImageView()
    private var blurredImageView = UIImageView()


    /// Gaussian Blur radius, larger will make the back ground shadow lighter (warning: do not set it too large, 2 or 3 for most cases)
    @IBInspectable
    public var blurRadius: CGFloat = 3 {
        didSet {
            layoutShadow()
        }
    }

    /// The image view contains target image
    @IBInspectable
    public var image: UIImage? {
        set {
            imageView.image = newValue
            layoutShadow()
        }
        get {
            return imageView.image
        }
    }

    /// Image's corner radius
    @IBInspectable
    public var imageCornerRaidus: CGFloat = 0 {
        didSet {
            imageView.layer.cornerRadius = imageCornerRaidus
            imageView.layer.masksToBounds = true
        }
    }

    /// shadow radius offset in percentage, if you want shadow radius larger, set a postive number for this, if you want it be smaller, then set a negative number
    @IBInspectable
    public var shadowRadiusOffSetPercentage: CGFloat = 0 {
        didSet {
            layoutShadow()
        }
    }

    /// Shadow offset value on x axis, postive -> right, negative -> left
    @IBInspectable
    public var shadowOffSetByX: CGFloat = 0 {
        didSet {
            layoutShadow()
        }
    }


    /// Shadow offset value on y axis, postive -> right, negative -> left
    @IBInspectable
    public var shadowOffSetByY: CGFloat = 0 {
        didSet {
            layoutShadow()
        }
    }
    
    
    /// Shadow alpha value
    @IBInspectable
    public var shadowAlpha: CGFloat = 1 {
        didSet {
            blurredImageView.alpha = shadowAlpha
        }
    }
    
    override var contentMode: UIViewContentMode {
        didSet{
            layoutShadow()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutShadow()
    }

    /// Generate the background color and set it to a image view.
    private func generateBlurBackground() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let weakself = self else {
                return
            }
            guard let image = weakself.image else{
                return
            }
            let realImageSize = weakself.getRealImageSize(image)
            // Create a containerView to hold the image should apply gaussian blur.
            let containerLayer = CALayer()
            containerLayer.frame = CGRect(origin: .zero, size: realImageSize.scaled(by: 1.4))
            containerLayer.backgroundColor = UIColor.clear.cgColor
            let blurImageLayer = CALayer()
            blurImageLayer.frame = CGRect(origin: CGPoint.init(x: realImageSize.width*0.2, y: realImageSize.height*0.2), size: realImageSize)
            blurImageLayer.contents = image.cgImage
            blurImageLayer.cornerRadius = weakself.imageCornerRaidus
            blurImageLayer.masksToBounds = true
            containerLayer.addSublayer(blurImageLayer)
            
            var containerImage = UIImage()
            // Get the UIImage from a UIView.
            if containerLayer.frame.size != CGSize.zero {
                containerImage = UIImage(layer: containerLayer)
            }else {
                containerImage = UIImage()
            }

            guard let resizedContainerImage = containerImage.resized(withPercentage: 0.2),
                let ciimage = CIImage(image: resizedContainerImage),
                let blurredImage = weakself.applyBlur(ciimage: ciimage) else {
                    return
            }

            DispatchQueue.main.async { [weak self] in
                self?.blurredImageView.image = blurredImage
            }
        }
    }

    /// Apply Gaussian Blur to a ciimage, and return a UIImage
    ///
    /// - Parameter ciimage: the imput CIImage
    /// - Returns: output UIImage
    private func applyBlur(ciimage: CIImage) -> UIImage? {

        if let filter = CIFilter(name: "CIGaussianBlur") {
            filter.setValue(ciimage, forKey: kCIInputImageKey)
            filter.setValue(blurRadius, forKeyPath: kCIInputRadiusKey)
            
            // Due to a iOS 8 bug, we need to bridging CIContext from OC to avoid crashing
            let context = CIContext.bridging_context(options: nil)
            if let output = filter.outputImage, let cgimage = context.createCGImage(output, from: ciimage.extent) {
                return UIImage(cgImage: cgimage)
            }
        }
        return nil
    }

    /// Due to scaleAspectFit, need to calculate the real size of the image and set the corner radius
    ///
    /// - Parameter from: input image
    /// - Returns: the real size of the image
    func getRealImageSize(_ from: UIImage) -> CGSize {
        if contentMode == .scaleAspectFit {
            let scale = min(bounds.size.width / from.size.width, bounds.size.height / from.size.height)
            return from.size.scaled(by: scale)
        } else {
            return from.size
        }
    }

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        backgroundColor = .clear
        if newSuperview != nil {
            layoutImageView()
        }
    }

    private func layoutShadow() {
        
        generateBlurBackground()
        guard let image = image else {
            return
        }

        let realImageSize = getRealImageSize(image)

        imageView.frame = CGRect(origin: .zero, size: realImageSize)
        imageView.center = CGPoint(x: bounds.width/2, y: bounds.height/2)

        let newSize = realImageSize.scaled(by: 1.4 * (1 + shadowRadiusOffSetPercentage/100))

        blurredImageView.frame = CGRect(origin: .zero, size: newSize)
        blurredImageView.center = CGPoint(x: bounds.width/2 + shadowOffSetByX, y: bounds.height/2 + shadowOffSetByY)
        blurredImageView.contentMode = contentMode
        blurredImageView.alpha = shadowAlpha

        addSubview(blurredImageView)
        sendSubview(toBack: blurredImageView)
    }

    private func layoutImageView() {
        imageView.image = image
        imageView.frame = bounds

        imageView.layer.cornerRadius = imageCornerRaidus
        imageView.layer.masksToBounds = true
        imageView.contentMode = contentMode
        addSubview(imageView)
    }

}

private extension CGSize {
    
    /// Generates a new size that is this size scaled by a cerntain percentage
    ///
    /// - Parameter percentage: the percentage to scale to
    /// - Returns: a new CGSize instance by scaling self by the given percentage
    func scaled(by percentage: CGFloat) -> CGSize {
        return CGSize(width: width * percentage, height: height * percentage)
    }
    
}

private extension UIImage {

    /// Resize the image to a centain percentage
    ///
    /// - Parameter percentage: Percentage value
    /// - Returns: UIImage(Optional)
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = size.scaled(by: percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// Method to create a UIImage from CALayer
    ///
    /// - Parameter layer: input Layer
    convenience init(layer: CALayer) {
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let cgImage = image?.cgImage {
            self.init(cgImage: cgImage)
        } else {
            self.init()
        }
    }
}

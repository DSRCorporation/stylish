//
//  ImageExtension.swift
//  SwiftStylish
//

import UIKit

extension UIImage
{
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 100, height: 100))
    {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    func compare(withImage image: UIImage) -> Bool
    {
        let dataImage = UIImagePNGRepresentation(self)
        let dataImageTest = UIImagePNGRepresentation(image)
        
        return dataImage == dataImageTest
    }
}


//  Colors.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-03.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}

struct Colors {
    static let autobotsColor = UIColor.rgb(red: 0, green: 8, blue: 79, alpha: 1)
    static let decepticonsColor:UIColor = UIColor.rgb(red: 62, green: 0, blue: 0, alpha: 1)
    static let unselectedGrayColor:UIColor = UIColor.rgb(red: 201, green: 201, blue: 201, alpha: 1)
}

//
//  String+Height.swift
//  YouTube_Project
//
//  Created by Admin on 19.01.2023.


import Foundation
import UIKit

extension String {
    func heightWithWidth(width: CGFloat,
                         font: UIFont) -> CGFloat {
        let rect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: rect,
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return boundingBox.height
    }
}

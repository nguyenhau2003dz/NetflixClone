//
//  Extensions.swift
//  Netflix
//
//  Created by Hậu Nguyễn on 14/3/25.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

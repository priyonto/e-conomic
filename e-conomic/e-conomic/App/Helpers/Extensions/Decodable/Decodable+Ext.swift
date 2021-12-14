//
//  Decodable+Ext.swift
//  e-conomic
//
//  Created by iPriyo on 14/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import Foundation

extension Decodable {
  static func parse(fileName: String) -> Self? {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
          let data = try? Data(contentsOf: url),
          let output = try? JSONDecoder().decode(self, from: data)
        else {
      return nil
    }
    return output
  }
}

//
//  Section.swift
//  fastis
//
//  Created by Michael Brewington on 3/10/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//

import Foundation

class Section {
    let row: Int
    let title: String
    var count: Int
    
    init(cellRow: Int, cellTitle: String, cellCount: Int)
    {
        self.row = cellRow
        self.title = cellTitle
        self.count = cellCount
    }
    func changeRow(newCount: Int)
     {
        self.count = newCount
     }
}

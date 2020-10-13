//
//  AddFileTabs.swift
//  fastis
//
//  Created by Michael Brewington on 3/10/20.
//  Copyright © 2020 Michael Brewington. All rights reserved.
//

import Foundation

class AddFileTabs {
    
    var key: String
    var section: Int
    var row:  Int
    
    init(cellKey:String,cellSection:Int,cellRow:Int){
        self.key = cellKey
        self.section = cellSection
        self.row = cellRow
    }

}

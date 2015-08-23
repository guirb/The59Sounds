//
//  Music.swift
//  The59Sounds
//
//  Created by gustavo.freitas2 on 8/23/15.
//  Copyright (c) 2015 himynameisgustavo. All rights reserved.
//

import Foundation
import CoreData

class Music: NSManagedObject {

    @NSManaged var musicName: String?
    @NSManaged var bandName: String?

    
    func getMusicName() -> String {
        if let music = self.musicName {
            return music
        } else {
            return " "
        }

    }
    
    func getBandName() -> String {
        if let band = self.bandName {
            return band
        } else {
            return " "
        }
        
    }
    
    
    func set(#musicName: String?, bandName: String?) {
        self.musicName = musicName
        self.bandName = bandName
        
    }
}

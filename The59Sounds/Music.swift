//
//  Music.swift
//  Playlist
//
//  Created by gustavo.freitas2 on 8/20/15.
//  Copyright (c) 2015 himynameisgustavo. All rights reserved.
//

import Foundation


class Music {
    
    
    private var musicName: String?
    private var bandName: String?
    
    
    func getMusicName() -> String {
        
        if let music = musicName {
            return music
        } else {
            return " "
        }
    }
    
    func getBandName() -> String {
        
        if let band = bandName {
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
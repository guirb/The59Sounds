//
//  NewMusicViewController.swift
//  The59Sounds
//
//  Created by gustavo.freitas2 on 8/21/15.
//  Copyright (c) 2015 himynameisgustavo. All rights reserved.
//

import UIKit

class NewMusicViewController: UIViewController {
    
    
    @IBOutlet weak var musicName: UITextField!
    
    @IBOutlet weak var bandName: UITextField!
    
    private var music: Music!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        musicName.text = music.getMusicName()
        bandName.text = music.getBandName()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        music.set(musicName: musicName.text, bandName: bandName.text)
        
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func prepare(#music: Music) {
        self.music = music
    }
    

}

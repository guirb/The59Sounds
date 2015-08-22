//
//  MusicList.swift
//  The59Sounds
//
//  Created by gustavo.freitas2 on 8/21/15.
//  Copyright (c) 2015 himynameisgustavo. All rights reserved.
//

import UIKit

class MusicListTableViewController: UITableViewController, UITableViewDataSource {
    
    private var musics: Array<Music> = Array<Music>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if musics.last?.getMusicName() == "" {
            musics.removeLast()
        }
        
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "newMusic" {
            var newMusic = Music()
            
            musics.append(newMusic)
            tableView.reloadData()
            
            if let nc = segue.destinationViewController as? NewMusicViewController {
                
                nc.prepare(music: newMusic)
                
            }
        }
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musics.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("musicCell") as! MusicTableViewCell
        
        var music = musics[indexPath.row]
        
        cell.numberNameLabel.text = String(indexPath.row + 1)
        cell.musicNameLabel.text = "\""+music.getMusicName()+"\""
        cell.bandNameLabel.text = music.getBandName()
        
        return cell
        
    }
    

}

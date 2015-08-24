//
//  MusicList.swift
//  The59Sounds
//
//  Created by gustavo.freitas2 on 8/21/15.
//  Copyright (c) 2015 himynameisgustavo. All rights reserved.
//

import UIKit
import CoreData

class MusicListTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var musics: Array<Music> = Array<Music>()
    
    var context: NSManagedObjectContext!
    var model: NSManagedObjectModel!
    var isUpdate: Bool = false
    
    let itemArchivePath: String = {
        let documentsDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectory = documentsDirectories.first as! String
        
        return documentDirectory.stringByAppendingPathComponent("store.data")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let model = NSManagedObjectModel.mergedModelFromBundles(nil) {
            self.model = model
            
            let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
            
            if let storeURL = NSURL(fileURLWithPath: itemArchivePath) {
                var error: NSError?
                
                psc.addPersistentStoreWithType(NSSQLiteStoreType,
                    configuration: nil,
                    URL: storeURL,
                    options: nil,
                    error: &error)
                
                context = NSManagedObjectContext()
                context.persistentStoreCoordinator = psc
                
                self.loadMusics()
                
            }
        }
                
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if(!isUpdate) {
            if musics.last?.getMusicName() == " " {
                musics.removeLast()
            }
        }
        
        tableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        var error: NSError?
        if !context.save(&error) {
            println("Error")
        } 
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "newMusic" {
            isUpdate = false
            var newMusic = NSEntityDescription.insertNewObjectForEntityForName("Music", inManagedObjectContext: context) as! Music
            
            musics.append(newMusic)
            tableView.reloadData()
            
            if let nc = segue.destinationViewController as? NewMusicViewController {
                
                nc.prepare(music: newMusic)
                
            }
        } else if segue.identifier == "updateMusic" {
            isUpdate = true
            var music = musics[tableView.indexPathForSelectedRow()!.row]
            
            if let nc = segue.destinationViewController as? NewMusicViewController {
                
                nc.prepare(music: music)
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
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
        
    }
    
    func loadMusics(){
        
        let request = NSFetchRequest()
        
        let e = NSEntityDescription.entityForName("Music", inManagedObjectContext: context)
        request.entity = e
        
        var error: NSError?
        if let result = context.executeFetchRequest(request, error: &error) as? [Music]{
            musics = musics + result
        }else{
            println("Fecth failed: \(error!.localizedDescription)")
        }
        
    }

    

}

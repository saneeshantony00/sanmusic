//
//  ViewController.swift
//  MyMusic
//
//  Created by Afraz Siddiqui on 4/3/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet var table: UITableView!

    var songs = [Song]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        table.delegate = self
        table.dataSource = self
      
    }
    func configureSongs(){

        songs.append(Song(name:"Drip like me", albumName: "kenndog", artistName: "unknown",imageName:"cover1" ,
                          trackName: "song1"))
        songs.append(Song(name:"jelabi", albumName: "unknown", artistName: "unknown",imageName:"cover2" ,
                          trackName: "song2"))
    }
    
    //table
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        //configure
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.accessoryType = .disclosureIndicator
        
    
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.textLabel?.font = UIFont(name: "Helvtica", size: 17)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    //present the player
        let position = indexPath.row
        //songs
        guard let vc = storyboard?.instantiateViewController(identifier: "player") as? PlayerViewController  else {
            return
        }
        vc.songs = songs
        vc.position = position
        self.navigationController?.pushViewController(vc, animated: true)
   
    }
    
 
   
        

}
struct Song {
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
}


//
//  PlayerViewController.swift
//  sanmusic
//
//  Created by saneesh antony on 2021-01-13.
//
import AVFoundation
import UIKit

class PlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [Song] = []
    
    @IBOutlet var holder: UIView!
    
    var player: AVAudioPlayer?
    
    //user interface
    
    private let albumImageView: UIImageView = {
        
        let imageView = UIImageView()                     //{album image properties
        imageView.contentMode = .scaleAspectFill
       return imageView
        
    }()
    
    private let songNameLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center              //{songname properties
        label.numberOfLines = 0 //line wrap
        return label
        
    }()
    
    private let albumNameLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0 //line wrap       //{album name properties
        return label
        
    }()
    
    private let  artistNameLabel: UILabel = {
        
        let label = UILabel()                    //{artist name properties
        label.textAlignment = .center
        label.numberOfLines = 0 //line wrap
        return label
        
    }()
    
    let playPauseButton = UIButton()    // one button from (m-player controller)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if holder.subviews.count == 0 {
            configure()
        }
    }
    func configure() {
        // set up player
        let song = songs[position]

      let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")

       
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)

            guard let urlString = urlString else {
                print("urlstring is nil")
                return
            }

            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)

            guard let player = player else {
                print("player is nil")
                return
            }
            player.volume = 0.5

            player.play()
        }
        catch {
            print("error occurred")
        }
        
        //album cover
        albumImageView.frame  = CGRect(x: 10, y: 10, width: holder.frame.size.width-20, height: holder.frame.size.width-20)
        albumImageView.image = UIImage(named: song.imageName)
        holder.addSubview(albumImageView)
        
        //labels  songname,albumname,artistname
                     //setting size properities
                //songname
        songNameLabel.frame  = CGRect(x: 10, y: albumImageView.frame.size.height, width: holder.frame.size.width-20, height: 70)
        albumImageView.image = UIImage(named: song.imageName)
               //albumname
        albumNameLabel.frame  = CGRect(x: 10, y: albumImageView.frame.size.height + 50, width: holder.frame.size.width-20, height: 70)
        albumImageView.image = UIImage(named: song.imageName)
              //artistname
        artistNameLabel.frame  = CGRect(x: 10, y: albumImageView.frame.size.height + 50 + 70, width: holder.frame.size.width-20, height: 70)
        albumImageView.image = UIImage(named: song.imageName)
              
              // for display
        songNameLabel.text = song.name
        albumNameLabel.text = song.albumName
        artistNameLabel.text = song.artistName
        
        holder.addSubview(songNameLabel)
        holder.addSubview(albumNameLabel)
        holder.addSubview(artistNameLabel)
              //--end
        
        //m-player controller
        
        let nextButton = UIButton()
        let backButton = UIButton()
        
         // frame
        let yPosition = artistNameLabel.frame.origin.y + 70 + 20
        let size: CGFloat = 70
                  //setting button location
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size)/2.0, y: yPosition, width: size, height: size)
        nextButton.frame = CGRect(x: holder.frame.size.width - size - 20, y: yPosition, width: size, height: size) //{diff types(doubt)
        backButton.frame = CGRect(x: 20, y: yPosition, width: size, height: size)
        
          //button actions
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
          //m1-styling
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        
        backButton.backgroundColor = .red
        nextButton.backgroundColor = .red
        
        playPauseButton.tintColor = .black
        backButton.tintColor = .black
        nextButton.tintColor = .black
        
        holder.addSubview(playPauseButton)
        holder.addSubview(nextButton)
        holder.addSubview(backButton)
        
        //m-slider
        
        let slider = UISlider (frame:CGRect(x: 20, y: holder.frame.size.height-60 , width: holder.frame.size.width-40,
                                            height: 50))
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        holder.addSubview(slider)
        
    }
    
    @objc func didTapBackButton(){
        if position > 0 {
            position = position - 1
            player?.stop()
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
            configure()
        }
        
    }
    @objc func didTapNextButton(){
        if position < (songs.count - 1)  {
            position = position + 1
            player?.stop()
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
            configure()
        }
    }
        //start
    @objc func didTapPlayPauseButton(){
        if player?.isPlaying == true {
            //pause
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            
        }else{
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }  //end
    
    @objc func  didSlideSlider(_ slider: UISlider){
        let value = slider.value
        player?.volume = value
               //adjust player volume
         
    }
         
      override  func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
        }
}


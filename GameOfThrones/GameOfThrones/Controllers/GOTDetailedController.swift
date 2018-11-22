//
//  GOTDetailedController.swift
//  GameOfThrones
//
//  Created by Genesis Mosquera on 11/19/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class GOTDetailedController: UIViewController {

    // write out all of the images and stuff
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var episodeSeason: UILabel!
    @IBOutlet weak var episodeEpisode: UILabel!
    @IBOutlet weak var episodeRuntime: UILabel!
    @IBOutlet weak var episodeAirDate: UILabel!
    @IBOutlet weak var episodeDescription: UITextView!
    
    var episodes: GOTEpisode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateGotUI()
    }
    private func updateGotUI() {
        episodeImage.image = UIImage(named:(episodes?.originalImageID)!)
        episodeTitle.text = episodes.name
        episodeSeason.text = "Season: \(episodes.season)"
        episodeEpisode.text = "Episode: \(episodes.number)"
        episodeRuntime.text = "RunTime: \(episodes.runtime)"
        episodeAirDate.text = episodes.airdate
        episodeDescription.text = episodes.summary
    }
}

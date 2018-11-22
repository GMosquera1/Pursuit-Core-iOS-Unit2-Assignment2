//
//  ViewController.swift
//  GameOfThrones
//
//  Created by Alex Paul on 11/16/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class GoTViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var refreshControl: UIRefreshControl!
    
    private var episodes = GOTEpisode.allEpisodes {
        didSet {
            tableView.reloadData()
        }
    }
    private func setUpProtocols() {
        tableView.dataSource = self
        tableView.delegate = self
        //searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        episodes = GOTEpisode.allEpisodes
               setUpProtocols()
        
    }
    
    private func setUpRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(fetchEpisodes), for: .valueChanged)
    }
    @objc private func
        fetchEpisodes() {
        refreshControl.endRefreshing()
        episodes = GOTEpisode.allEpisodes
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gotDetailedController = segue.destination as? GOTDetailedController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        let episode = episodes[indexPath.row]
        gotDetailedController.episodes = episode
    }

}

extension GoTViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = episodes[indexPath.row]
        if episode.season % 2 == 0 {
            guard let trailingCell = tableView.dequeueReusableCell(withIdentifier: "TrailingCell", for: indexPath) as? TrailingCell else { return UITableViewCell() }
            trailingCell.gotImage.image = UIImage(named: episode.mediumImageID)
            trailingCell.gotSeason.text = episode.name
            trailingCell.gotEpisode.text = "S:\(episode.season) E:\(episode.number)"
            return trailingCell
        } else {
            guard let leadingCell =  tableView.dequeueReusableCell(withIdentifier: "LeadingCell", for: indexPath) as? LeadingCell else { return UITableViewCell() }
            leadingCell.gotImage.image = UIImage(named: episode.mediumImageID)
            leadingCell.gotSeason.text = episode.name
                leadingCell.gotEpisode.text = "S:\(episode.season) E:\(episode.number)"
            return leadingCell
        }
    }
}

extension GoTViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
    }
}


//extension GoTViewController: UISearchBarDelegate {
//    // step 2: implements menthods as needed or required if available
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//        guard let searchText = searchBar.text else { return }
//
//        // user can enter "classic" or "egg"
//        // results should return "Classic Deviled Eggs"
//
//        episodes = GOTEpisode.allEpisodes().filter { $0.name.lowercased().contains(searchText.lowercased()) }
//    }
//}


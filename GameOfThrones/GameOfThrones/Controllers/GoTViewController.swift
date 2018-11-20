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
        episodes = GOTEpisode.allEpisodes //questionable
            setUpRefreshControl()
        //        setUpProtocols()
        
    } // this line of code scares me
//    static func getEpisodes() -> [GOTEpisode] {
//        return GOTEpisode.allEpisodes
//    }
    
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
        guard let indexPath = tableView.indexPathForSelectedRow,
            let gotDetailedController = segue.destination as? GOTDetailedController else { return }
     let episode = episodes[indexPath.row]
        gotDetailedController.episodes = episode
}

}

extension GoTViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // sets which custom cell to use, ie leading or trailing cell. if/ else statement
        guard let leadingCell =  tableView.dequeueReusableCell(withIdentifier: "LeadingCell", for: indexPath) as? LeadingCell else { return UITableViewCell() }
        
        
        let episode = episodes[indexPath.row]
        // leadingCell.gotImage.image = UIImage.init(named: (episodes?.originalImageID)!)
        leadingCell.gotEpisode.text = episode.name
        leadingCell.gotSeason.tag = episode.season
        
        return leadingCell
    }
    
}
extension GoTViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 400
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


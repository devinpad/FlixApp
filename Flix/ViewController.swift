//
//  ViewController.swift
//  Flix
//
//  Created by Devin Padron on 2/7/22.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var movies: [[String:Any?]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getMovies()
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.rowHeight = 150
    }
    
    func getMovies(){
        API.getAPI(){(movieList) in
            guard let movieList = movieList else{
                return
            }
            self.movies = movieList
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let baseurl = "https://image.tmdb.org/t/p/w185"
        let movie = self.movies[indexPath.row]
        let title = movie["title"] as! String
        let desc = movie["overview"] as! String
        let posterpath = movie["poster_path"] as! String
        let posterurl = URL(string: baseurl + posterpath)
        cell.posterImage.af.setImage(withURL: posterurl!)
        
        cell.titleLabel.text = title
        cell.descLabel.text = desc
        
        return cell
    }


}


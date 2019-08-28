//
//  ViewController.swift
//  teste-pag-ios
//
//  Created by Lucas Mathielo Gomes on 2019-08-20.
//  Copyright © 2019 Lucas Mathielo Gomes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var genreList: [Genre]?
    var genre2: Genres?
    var selectedGenreId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerViewCell()
        teste()
        ApiService.retrieveGenres(completion: { (genreList) in
//            self.genreList = genre2
            print(genreList!)
            self.tableView.reloadDataWithAutoSizingCellWorkAround()
            })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovies" {
            let vc = segue.destination as! MoviesTableViewController
            vc.selectedGenreId = selectedGenreId
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    fileprivate func registerViewCell() {
        tableView.register(UINib(nibName: "GenreViewCell", bundle: nil), forCellReuseIdentifier: "GenreViewCell")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(genreList![indexPath.row])
        selectedGenreId = genreList![indexPath.row].id
        performSegue(withIdentifier: "showMovies", sender: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreViewCell", for: indexPath) as! GenreViewCell
        cell.configure(with: genreList![indexPath.row])
        print(indexPath.row)
//        cell.titleLabel.text = genreList![indexPath.row].name
        return cell
    }
}

extension UITableView {
    func reloadDataWithAutoSizingCellWorkAround() {
        self.reloadData()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.reloadData()
    }
}

extension UIViewController {
    func teste() {
        let apiClient = MarvelAPIClient()
        apiClient.send(GetGenders<Genre>()) { response in
            print("response ->\(response.data)")
//            response.map { characters in
//                for character in characters {
//                    print("Name: \(character.name ?? "Unnamed character")")
//                }
//            }
        }
    }
}


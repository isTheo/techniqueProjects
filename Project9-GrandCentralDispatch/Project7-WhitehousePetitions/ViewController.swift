//
//  ViewController.swift
//  Project7-WhitehousePetitions
//
//  Created by Matteo Orru on 23/02/24.
//  This is Project 9 - Implementing GCD

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    var savedPetitions = [Petition]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filterSymbol = UIImage(systemName: "line.horizontal.3.decrease.circle")
        let filterButton = UIBarButtonItem(image: filterSymbol, style: .plain, target: self, action: #selector(filterButtonTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(showCredits))
        navigationItem.leftBarButtonItem = filterButton
        
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self.parse(json: data)
                    return
                }
            }
            self.showError()
        }  
    }


    
    func showError() {
        let errorAlert = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(errorAlert, animated: true)
    }

    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            savedPetitions = petitions
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            DispatchQueue.main.async {
                self.showError()
            }
        }
    }
    
    
    //setting table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //setting right bar button
    @objc func showCredits() {
        let creditsAlert = UIAlertController(title: "We The People API Information", message: "The data displayed in this app is sourced from the We The People API of the White House.", preferredStyle: .alert)
        creditsAlert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(creditsAlert, animated: true)
    }
    
    
    @objc func filterButtonTapped() {
        let filterAlert = UIAlertController(title: "Find your petition", message: nil, preferredStyle: .alert)
        filterAlert.addTextField()
        let findAction = UIAlertAction(title: "Find", style: .default) { _ in
            guard let text = filterAlert.textFields?[0].text else { return }
            self.findPetitions(text)
        }
        let backAction = UIAlertAction(title: "Reset", style: .destructive) { _ in
            self.resetButton()
        }
        
        filterAlert.addAction(findAction)
        filterAlert.addAction(backAction)
        present(filterAlert, animated: true)
        
    }
    
    
    func findPetitions(_ text: String) {
        filteredPetitions.removeAll()
        for petition in savedPetitions {
            if petition.body.lowercased().contains(text.lowercased()) {
                filteredPetitions.append(petition)
            }
        }
        
        if filteredPetitions.isEmpty { return }
        petitions = filteredPetitions
        tableView.reloadData()
    }
    
    
    func resetButton() {
        petitions = savedPetitions
        tableView.reloadData()
    }
    
    
    
}

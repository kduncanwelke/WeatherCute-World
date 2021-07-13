//
//  AddViewController.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/21/21.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var noNetwork: UILabel!
    
    // MARK: Variables
    
    private let searchViewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(showResults), name: NSNotification.Name(rawValue: "showResults"), object: nil)
    
        NotificationCenter.default.addObserver(self, selector: #selector(fail), name: NSNotification.Name(rawValue: "fail"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(returned), name: NSNotification.Name(rawValue: "returned"), object: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        searchField.delegate = self
    }
    
    @objc func showResults() {
        indicator.stopAnimating()
        tableView.reloadData()
    }
    
    @objc func returned() {
        noNetwork.isHidden = true
    }
    
    @objc func fail() {
        indicator.stopAnimating()
        noNetwork.isHidden = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchField.becomeFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        indicator.startAnimating()
        searchViewModel.search(parameter: searchField.text ?? "")
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchViewModel.clearSearch()
        tableView.reloadData()
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: IBActions
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        // hide keyboard if user taps away
        if searchField.isFirstResponder {
            searchField.resignFirstResponder()
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        searchViewModel.clearSearch()
        self.dismiss(animated: true, completion: nil)
    }

}

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.getResultCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationTableViewCell
        
        cell.location.text = searchViewModel.getLocationName(index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchViewModel.addSelectedLocation(index: indexPath.row)
        searchViewModel.clearSearch()
        self.dismiss(animated: true, completion: nil)
    }
}

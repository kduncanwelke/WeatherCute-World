//
//  ContentViewController.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/15/21.
//

import UIKit

class ContentViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var locationLabel: UILabel!
    
    // MARK: Variables
    
    private var contentViewModel = ContentViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(refreshContent), name: NSNotification.Name(rawValue: "refreshContent"), object: nil)
        
    }
    
    @objc func refreshContent() {
        loadUI()
    }
    
    func loadUI() {
        locationLabel.text = contentViewModel.getLocationName()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  InfoViewController.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/24/21.
//

import UIKit

class InfoViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var apiButton: UIButton!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        apiButton.layer.cornerRadius = 15
        privacyPolicyButton.layer.cornerRadius = 15
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func apiPressed(_ sender: UIButton) {
        guard let url = URL(string: "https://www.weatherapi.com/") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func privacyPolicyPressed(_ sender: UIButton) {
        guard let url = URL(string: "http://kduncan-welke.com/weathercuteworldprivacy.php") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

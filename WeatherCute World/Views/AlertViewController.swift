//
//  AlertViewController.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/21/21.
//

import UIKit

class AlertViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var event: UILabel!
    @IBOutlet weak var severity: UILabel!
    @IBOutlet weak var certainty: UILabel!
    @IBOutlet weak var urgency: UILabel!
    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var areas: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var instruction: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: Variables
    
    private let alertViewModel = AlertViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backButton.layer.cornerRadius = 15
        nextButton.layer.cornerRadius = 15
        loadAlerts()
    }
    
    func loadAlerts() {
        event.text = alertViewModel.getEventText()
        severity.text = alertViewModel.getSeverity()
        certainty.text = alertViewModel.getCertainty()
        urgency.text = alertViewModel.getUrgency()
        headline.text = alertViewModel.getHeadline()
        areas.text = alertViewModel.getAreas()
        descriptionLabel.text = alertViewModel.getDescription()
        instruction.text = alertViewModel.getInstruction()
        
        if alertViewModel.enableBackButton() {
            enableBackButton()
        } else {
            disableBackButton()
        }
        
        if alertViewModel.enableNextButton() {
            enableNextButton()
        } else {
            disableNextButton()
        }
    }
    
    func disableBackButton() {
        backButton.isEnabled = false
        backButton.backgroundColor = UIColor.clear
    }
    
    func enableBackButton() {
        backButton.isEnabled = true
        backButton.backgroundColor = UIColor.white
    }
    
    func disableNextButton() {
        nextButton.isEnabled = false
        nextButton.backgroundColor = UIColor.clear
    }

    func enableNextButton() {
        nextButton.isEnabled = true
        nextButton.backgroundColor = UIColor.white
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backPressed(_ sender: UIButton) {
        if alertViewModel.goBack() {
            loadAlerts()
        }
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        if alertViewModel.goForward() {
            loadAlerts()
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

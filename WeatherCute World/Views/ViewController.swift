//
//  ViewController.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tempSegmentedControl: UISegmentedControl!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var contentView: UIView!
    
    // MARK: Variables
    
    private var viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(retrieveData), name: NSNotification.Name(rawValue: "retrieveData"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(sectionChanged), name: NSNotification.Name(rawValue: "sectionChanged"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatePageControl), name: NSNotification.Name(rawValue: "updatePageControl"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSegment), name: NSNotification.Name(rawValue: "updateSegment"), object: nil)
        
        viewModel.loadLocations()
        viewModel.loadUnit()
      
        updatePageControl()
        viewModel.setUpNetworkMonitor()
    }
    
    @objc func updateSegment() {
        tempSegmentedControl.selectedSegmentIndex = viewModel.getSegment()
    }
    
    @objc func retrieveData() {
        viewModel.getAll()
    }
    
    @objc func updatePageControl() {
        print("update page control")
        var locationCount = viewModel.getWeatherLocationTotal()
        pageControl.numberOfPages = locationCount
        
        if locationCount == 0 {
            contentView.isHidden = true
        } else {
            contentView.isHidden = false
        }
    }
    
    @objc func sectionChanged() {
        pageControl.currentPage = viewModel.getCurrentPage()
        print("section changed")
        print(PageManager.currentPage)
    }
    
    // MARK: IBActions
    
    @IBAction func tempSegmentedChanged(_ sender: UISegmentedControl) {
        viewModel.changeUnit(index: tempSegmentedControl.selectedSegmentIndex)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "degreeUnitChanged"), object: nil)
    }
    
    
    @IBAction func editTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "edit", sender: Any?.self)
    }
    
    @IBAction func addLocationPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "addLocation", sender: Any?.self)
    }
    
    @IBAction func infoPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "viewInfo", sender: Any?.self)
    }
}


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
    
    // MARK: Variables
    
    private var viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(sectionChanged), name: NSNotification.Name(rawValue: "sectionChanged"), object: nil)
        
        viewModel.getAll()
      
        updatePageControl()
    }
    
    func updatePageControl() {
        pageControl.numberOfPages = viewModel.getWeatherLocationTotal()
    }
    
    @objc func sectionChanged() {
        pageControl.currentPage = viewModel.getCurrentPage()
        print(PageManager.currentPage)
        print("section changed")
    }
    
    // MARK: IBActions
    
    @IBAction func tempSegmentedChanged(_ sender: UISegmentedControl) {
        viewModel.changeUnit(index: tempSegmentedControl.selectedSegmentIndex)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "degreeUnitChanged"), object: nil)
    }
    
}


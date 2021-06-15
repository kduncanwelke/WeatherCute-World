//
//  ViewController.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Variables
    
    private var viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel.getAll()
        //viewModel.search(parameter: "london")
    }

}


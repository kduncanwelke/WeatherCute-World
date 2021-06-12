//
//  ViewController.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/10/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(AstronomyCurrent.endpoint.url())
        print(ConditionData.endpoint.url())
    
        
        getCondition()
    }

    func getCondition() {
        print("called")
        DataManager<ConditionData>.fetch() { [weak self] result in
            print("fetch")
            switch result {
            case .success(let response):
                
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}


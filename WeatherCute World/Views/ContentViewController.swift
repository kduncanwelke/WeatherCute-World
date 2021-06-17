//
//  ContentViewController.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/15/21.
//

import UIKit

class ContentViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var reloadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var currentCondition: UILabel!
    
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var uv: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var gust: UILabel!
    
    @IBOutlet weak var astroView: UIView!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var moonrise: UILabel!
    @IBOutlet weak var moonset: UILabel!
    @IBOutlet weak var phase: UILabel!
    @IBOutlet weak var illumination: UILabel!
    
    
    // MARK: Variables
    
    private var contentViewModel = ContentViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(degreeUnitChanged), name: NSNotification.Name(rawValue: "degreeUnitChanged"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshContent), name: NSNotification.Name(rawValue: "refreshContent"), object: nil)
        
        astroView.layer.cornerRadius = 15
        astroView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadUI()
    }
    
    @objc func refreshContent() {
        loadUI()
    }
    
    @objc func degreeUnitChanged() {
        // swap unit on items with F/C variations available
        temperature.text = contentViewModel.getTemperature()
        time.text = contentViewModel.getLocationTime()
        feelsLike.text = contentViewModel.getFeelsLike()
        pressure.text = contentViewModel.getPressure()
        wind.text = contentViewModel.getWind()
        gust.text = contentViewModel.getGust()
    }
    
    func loadUI() {
        locationLabel.text = contentViewModel.getLocationName()
        time.text = contentViewModel.getLocationTime()
        conditionImage.image = contentViewModel.getWeatherImage()
        temperature.text = contentViewModel.getTemperature()
        currentCondition.text = contentViewModel.getCurrentCondition()
        
        feelsLike.text = contentViewModel.getFeelsLike()
        humidity.text = contentViewModel.getHumidity()
        uv.text = contentViewModel.getUV()
        
        pressure.text = contentViewModel.getPressure()
        wind.text = contentViewModel.getWind()
        gust.text = contentViewModel.getGust()
        
        sunrise.text = contentViewModel.getSunrise()
        sunset.text = contentViewModel.getSunset()
        moonrise.text = contentViewModel.getMoonrise()
        moonset.text = contentViewModel.getMoonset()
        phase.text = contentViewModel.getMoonPhase()
        illumination.text = contentViewModel.getMoonIllumination()
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
   
    @IBAction func pressOnAstro(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            astroView.popUp()
        } else if sender.state == .cancelled || sender.state == .ended {
            astroView.goDown()
        }
    }
}

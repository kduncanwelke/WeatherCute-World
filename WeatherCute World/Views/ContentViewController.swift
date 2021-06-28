//
//  ContentViewController.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/15/21.
//

import UIKit

class ContentViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var reloadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var currentCondition: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
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
    
    @IBOutlet weak var alertButton: UIButton!
    
    @IBOutlet weak var airQualityView: UIView!
    @IBOutlet weak var carbonMonoxide: UILabel!
    @IBOutlet weak var ozone: UILabel!
    @IBOutlet weak var nitrogenDioxide: UILabel!
    @IBOutlet weak var sulphurDioxide: UILabel!
    @IBOutlet weak var pm2: UILabel!
    @IBOutlet weak var pm10: UILabel!
    @IBOutlet weak var airQualityIndex: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: Variables
    
    private var contentViewModel = ContentViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(degreeUnitChanged), name: NSNotification.Name(rawValue: "degreeUnitChanged"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshContent), name: NSNotification.Name(rawValue: "refreshContent"), object: nil)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        astroView.layer.cornerRadius = 15
        astroView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        airQualityView.layer.cornerRadius = 15
        airQualityView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        if contentViewModel.isThereData() == false {
            loadingIndicator.startAnimating()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadUI()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // if device is rotated, recalculate cell size
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.layoutIfNeeded()
            self?.collectionView.reloadData()
        }
    }
    
    @objc func refreshContent() {
        // use if data has been reloaded
        print("refreshed")
        if reloadIndicator.isAnimating {
            reloadIndicator.stopAnimating()
            reloadButton.setImage(UIImage(named: "reload"), for: .normal)
            reloadButton.isEnabled = true
        }
        
        if loadingIndicator.isAnimating {
            loadingIndicator.stopAnimating()
        }
        
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
        collectionView.reloadData()
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
        
        carbonMonoxide.text = contentViewModel.getCarbonDioxide()
        ozone.text = contentViewModel.getOzone()
        nitrogenDioxide.text = contentViewModel.getNitrogenDioxide()
        sulphurDioxide.text = contentViewModel.getSulphurDioxide()
        pm2.text = contentViewModel.getPM2()
        pm10.text = contentViewModel.getPM10()
        airQualityIndex.text = contentViewModel.getAirQualityIndex()
        
        alertButton.isHidden = contentViewModel.hideAlertButton()
        
        collectionView.reloadData()
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
    
    @IBAction func reloadPressed(_ sender: UIButton) {
        reloadIndicator.startAnimating()
        reloadButton.setImage(UIImage(named: "loading"), for: .normal)
        reloadButton.isEnabled = false
        contentViewModel.refreshData()
    }
   
    @IBAction func pressOnAstro(_ sender: UILongPressGestureRecognizer) {
        // do not toggle if air quality popup is visible
        if airQualityView.isHidden == false {
            return
        }
        
        if sender.state == .began {
            astroView.popUp()
        } else if sender.state == .cancelled || sender.state == .ended {
            astroView.goDown()
        }
    }
    
    @IBAction func pressOnAirQuality(_ sender: UILongPressGestureRecognizer) {
        // do not toggle if astro popup is visible
        if astroView.isHidden == false {
            return
        }
        
        if sender.state == .began {
            airQualityView.popUp()
        } else if sender.state == .cancelled || sender.state == .ended {
            airQualityView.goDown()
        }
    }
    
    @IBAction func alertButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "viewAlerts", sender: Any?.self)
    }
}

extension ContentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentViewModel.getForecastTotal()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecastCell", for: indexPath) as! ForecastCollectionViewCell
        
        cell.day.text = contentViewModel.getForecastDay(index: indexPath.row)
        cell.forecastImage.image = contentViewModel.getForecastWeatherImage(index: indexPath.row)
        cell.temperature.text = contentViewModel.getForecastTemp(index: indexPath.row)
        cell.humidity.text = contentViewModel.getForecastHumidity(index: indexPath.row)
        cell.uv.text = contentViewModel.getForecastUV(index: indexPath.row)
        cell.windSpeed.text = contentViewModel.getForecastWind(index: indexPath.row)
        cell.rainChance.text = contentViewModel.getRainChance(index: indexPath.row)
        cell.snowChance.text = contentViewModel.getSnowChance(index: indexPath.row)
        cell.sunrise.text = contentViewModel.getSunrise(index: indexPath.row)
        cell.sunset.text = contentViewModel.getSunset(index: indexPath.row)
        cell.moonrise.text = contentViewModel.getMoonrise(index: indexPath.row)
        cell.moonset.text = contentViewModel.getMoonset(index: indexPath.row)
        cell.phase.text = contentViewModel.getMoonPhase(index: indexPath.row)
        cell.illumination.text = contentViewModel.getMoonIllumination(index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset

        let referenceHeight: CGFloat = 210 // height of cell
        
        let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width - sectionInset.left - sectionInset.right - collectionView.contentInset.left - collectionView.contentInset.right
        
        if referenceWidth > 800 && referenceWidth < 1200 {
            let newWidth = (collectionView.safeAreaLayoutGuide.layoutFrame.width/2) - sectionInset.left - sectionInset.right - collectionView.contentInset.left - collectionView.contentInset.right - 5
            return CGSize(width: newWidth, height: referenceHeight)
        } else if referenceWidth > 1200 {
            let newWidth = (collectionView.safeAreaLayoutGuide.layoutFrame.width/3) - sectionInset.left - sectionInset.right - collectionView.contentInset.left - collectionView.contentInset.right - 5
            return CGSize(width: newWidth, height: referenceHeight)
        } else {
            return CGSize(width: referenceWidth, height: referenceHeight)
        }
    }
}

//
//  WeatherViewController.swift
//  WeatherTest
//
//  Created by minimani on 2021/10/13.
//

import UIKit

class WeatherViewController: UIViewController {

    var weathers:[[String:Any]]?
    var temp:[String:Any]?
    let API_KEY = ""
    let LAT = "37.51140797441832"
    let LON = "127.09817235908818"
    
    @IBOutlet weak var lblWeather: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search()
    }

    
    func search() {
        let strUrl = "https://api.openweathermap.org/data/2.5/weather?appid=\(API_KEY)&lat=\(LAT)&lon=\(LON)&units=metric&lang=kr"
        guard let url = URL(string: strUrl) else {return}
        let request = URLRequest(url: url)
        let session = URLSession.shared
//        let task = session.dataTask(with: request, completionHandler: dataTaskHandler(data:response:error:))
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {return}
            
            do {
                if let root = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                    self.weathers = root["weather"] as? [[String:Any]]
                    self.temp = root["main"] as? [String:Any]
                    
                    guard let temp = self.temp, let weathers = self.weathers else {return}
                    guard let tempText = temp["temp"] as? Double, let humiText = temp["humidity"] as? Double else {return}
                    var weatherText: String?
                    
                    for weather in weathers {
                        weatherText = weather["description"] as? String
                    }
                    
            
                    DispatchQueue.main.async {
                        self.lblWeather.text = weatherText
                        self.lblTemp.text = "온도: \(tempText)"
                        self.lblHumidity.text = "습도: \(humiText)"
                    }
                }
            } catch {}
        }
        task.resume()
    }

}

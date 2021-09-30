//
//  ViewController.swift
//  WebViewTest
//
//  Created by minimani on 2021/09/29.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showWebView()
        
    }
    
    func showWebView(link: String = "https://www.aladin.co.kr") {
        guard let url = URL(string: link) else {
            return
        }
        let request = URLRequest(url: url)
        
        webView.load(request)
    }

    @IBAction func goToAlradin(_ sender: UIButton) {
        let alLink = "https://www.aladin.co.kr/home/welcome.aspx"
        showWebView(link: alLink)
    }
    
    @IBAction func goToPage(_ sender: UIButton) {
        let pageLink = "https://page.kakao.com/main"
        showWebView(link: pageLink)
    }
    
    @IBAction func goToSeries(_ sender: UIButton) {
        let seriesLink = "https://series.naver.com/novel/home.series"
        showWebView(link: seriesLink)
    }

}


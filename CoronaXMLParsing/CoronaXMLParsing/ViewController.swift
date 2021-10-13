//
//  ViewController.swift
//  CoronaXMLParsing
//
//  Created by minimani on 2021/10/12.
//

import UIKit

class ViewController: UIViewController {

    let serviceKey = "iGmpA8Nig1A6KiflTrlTLWr6eOjrMeOdLIegfAC0JvrjrwU5mgRXpHvyPQQhF6MlX2LWhexdWuRhIW5ZyAchIA%3D%3D"
    
    var hospitals: [[String:Any]] = []
    var item: [String:Any] = [:]
    var key: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func actStartParsing(_ sender: Any) {
        let strUrl = "https://api.odcloud.kr/api/apnmOrg/v1/list?serviceKey=\(serviceKey)&returnType=XML"
        guard let url = URL(string: strUrl) else {return}
        
        let parser = XMLParser(contentsOf: url)
        parser?.delegate = self
        parser?.parse()
    }
    
}

extension ViewController: XMLParserDelegate {
    func parserDidStartDocument(_ parser: XMLParser) {
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "data" {
            hospitals.removeAll()
        } else if elementName == "item" {
            item = [:]
        } else if elementName == "col" {
            // key = elementName
            key = attributeDict["name"]
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if let key = self.key {
            item[key] = string
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            hospitals.append(item)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print(hospitals)
    }
}

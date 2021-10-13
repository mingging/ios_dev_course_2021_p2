//
//  ViewController.swift
//  ClosureTest
//
//  Created by minimani on 2021/10/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething(name: "홍길동", handler: sayHello)
        doSomething(name: "홍길동", handler: {
                        (name: String) -> Void in print("hi \(name)")
        })
        doSomething(name: "홍길동") { n1 in
            print("hi \(n1)")
        }
        
        doSomething1 { n1 in
            print("hi \(n1)")
        }
        
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        
        let sortedNamed = names.sorted(by: backward(_:_:))
        let sortedNamed1 = names.sorted(by: {
            (s1:String, s2: String) -> Bool in
            return s1 > s2
        })
        print(sortedNamed1)
        let sortedNamed2 = names.sorted(by: {$0 > $1})
        let sortedNamed3 = names.sorted(by: > )
        
    }
    
    // 역순 정렬
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }
    
    func sayHello(name: String) {
        print("Hello \(name)")
    }
    
    // Closure
    func doSomething(name: String, handler:(_ n1:String)->Void){
          handler(name)
    }

    func doSomething1(handler:(_ n1:String)->Void) {
        
    }

}


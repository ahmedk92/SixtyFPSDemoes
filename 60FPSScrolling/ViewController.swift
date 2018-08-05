//
//  ViewController.swift
//  60FPSScrolling
//
//  Created by Ahmed Khalaf on 8/3/18.
//  Copyright © 2018 Ahmed Khalaf. All rights reserved.
//

import UIKit

func randomArabicString(length: Int) -> String {
    let allowedChars = "آبتثجحخدذرزسشصضطظعغفقكلمنهوي "
    let allowedCharsCount = UInt32(allowedChars.count)
    var randomString = ""
    
    for _ in 0..<length {
        let randomNum = Int(arc4random_uniform(allowedCharsCount))
        let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
        let newCharacter = allowedChars[randomIndex]
        randomString += String(newCharacter)
    }
    
    return randomString
}

func randomAlphaNumericString(length: Int) -> String {
    let allowedChars = "abcdefghijklmnopqrstuvwxyz1234567890 "
    let allowedCharsCount = UInt32(allowedChars.count)
    var randomString = ""
    
    for _ in 0..<length {
        let randomNum = Int(arc4random_uniform(allowedCharsCount))
        let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
        let newCharacter = allowedChars[randomIndex]
        randomString += String(newCharacter)
    }
    
    return randomString
}

class ViewController: UIViewController {
    
    @IBOutlet weak var arTableView: UITableView!
    
    @IBOutlet weak var enTableView: UITableView!
    
    let data: [String] = {
        var data: [String] = []
        
        for _ in 0...1000 {
            data.append(randomAlphaNumericString(length: max(10, Int(arc4random_uniform(500)))))
        }
        
        return data
    }()
    
    let arabicData: [String] = {
        var data: [String] = []
        
        for _ in 0...1000 {
            data.append(randomArabicString(length: max(10, Int(arc4random_uniform(500)))))
        }
        
        return data
    }()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        arTableView.rowHeight = UITableViewAutomaticDimension
        arTableView.estimatedRowHeight = 350
        
        enTableView.rowHeight = UITableViewAutomaticDimension
        enTableView.estimatedRowHeight = 350
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class Cell: UITableViewCell {
    @IBOutlet private weak var label: UILabel!
    
    func configure(withString string: String) {
        self.label.text = string
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        cell.configure(withString: tableView.tag == 1 ? self.data[indexPath.row] : self.arabicData[indexPath.row])
        
        return cell
    }
}



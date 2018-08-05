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
    
    private lazy var heights: [CGFloat] = { [unowned self] in
        var heights: [CGFloat] = []
        for i in 0..<self.data.count {
            heights.append(height(index: i))
        }
        return heights
    }()
    
    func height(index: Int) -> CGFloat {
        let labelWidth = UIScreen.main.bounds.width / 2 - 8 * 2
        let text = NSMutableAttributedString.init(string: self.data[index])
        text.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 17), range: NSRange.init(location: 0, length: (self.data[index] as NSString).length))
        text.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: NSRange.init(location: 0, length: (self.data[index] as NSString).length))
        
        let boundingRect = text.boundingRect(with: CGSize.init(width: labelWidth, height: CGFloat.greatestFiniteMagnitude), options: [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading], context: nil)
        
        return ceil(boundingRect.size.height + 1) + 8 * 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.heights[indexPath.row]
    }
}


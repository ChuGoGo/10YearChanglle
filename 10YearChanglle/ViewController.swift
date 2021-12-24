//
//  ViewController.swift
//  10YearChanglle
//
//  Created by Chu Go-Go on 2021/12/23.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet weak var myYear: UILabel!
    @IBOutlet weak var yearSlider: UISlider!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
//    使用在自動播放
    var timer: Timer?
//    控制你的年份
    var year = 2011
 
//  建立一個func讓設定時間的動作
    func timeChange() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
//        照片從2011開始
        myImageView.image = UIImage(named: "2011")
        datePicker.setDate(dateFormatter.date(from: "2011")!, animated: true)
        yearSlider.setValue(2011, animated: true)
    }
    func changeYourYear(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
//        把年份轉成文字
        let year = dateFormatter.string(from: date)
//        變更文字
        myYear.text = "\(year)的我"
//        變更照片
        myImageView.image = UIImage(named: "\(year)")
//        變更DatePicker
        datePicker.setDate(date, animated: true)
//        變更slider
        yearSlider.value = Float(year)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timeChange()
    }
//    override func viewDidDisappear(_ animated: Bool) {
//        if timer != nil {
//            timer?.invalidate()
//            timer = nil
//        }
//    }
    @IBAction func yearPicker(_ sender: UIDatePicker) {
        changeYourYear(date: datePicker.date)
    }
    @IBAction func slideYear(_ sender: UISlider) {
//        定義時間
        let dateFormatter = DateFormatter()
//        定義時間的年份
        dateFormatter.dateFormat = "yyyy"
//        設定他動作的值，每拉一格就是一年，rounded就是把他化為一年的整數。
        yearSlider.setValue(yearSlider.value.rounded(), animated: true)
//        設定一年就是拉一格
        let year = yearSlider.value.rounded()
//        把日期設定成整數一年
        let date = dateFormatter.date(from: "\(Int(year))")
//        加入前面的func一個就是一年
        changeYourYear(date: date!)
    }
    @IBAction func autoPlay(_ sender: UISwitch) {
//        這邊就要用到if else了，先如果switch開關打開就代表自動播放。
        if sender.isOn {
//            這裡就是設定你自動播放的時間timeInterva，target你的對象，selector你要執行的func。userInfo有沒有要觸發的東西。 repeats是否重複循環。
           
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setYear), userInfo: nil, repeats: true)}
//        接下來就是如果關起來的話，invalidate就是關閉你的自動播放
        else {
                timer?.invalidate()
                timer = nil
                year = 2011
            }
    }
    //    建立一個計時器
        @objc func setYear(){
    //        每動一次加一年
            self.year += 1
    //        如果時間超過你的最大年份2021就會跳回2011
            if year > 2021 {
                year = 2011
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
    //        最後套入changeYourYear就可以同時變更你最新的年份
            changeYourYear(date: dateFormatter.date(from: "\(year)")!)
        }

    
}
    


//
//  ThirdViewController.swift
//  CurrenC
//
//  Created by Jun suk Bang on 05/02/2018.
//  Copyright © 2018 Jun Bang. All rights reserved.
//

import UIKit

protocol PickerViewControllerTwo {
    func currencyPickedTwo(currencyTwo : String)
    func iconPickedTwo(iconTwo : String)
    
}

class ThirdViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
   
   
    let currencyArrayTwo = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","KRW","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencyIconArrayTwo = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥","￦", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var countryPickedTwo : String = ""
    var countryIconTwo : String = ""
    
    var delegateTwo : PickerViewControllerTwo?
    
    
    @IBOutlet weak var currencyPickerTwo: UIPickerView!
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPickerTwo.dataSource = self
        currencyPickerTwo.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArrayTwo.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArrayTwo[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryPickedTwo = currencyArrayTwo[row]
        countryIconTwo = currencyIconArrayTwo[row]
        delegateTwo?.currencyPickedTwo(currencyTwo : countryPickedTwo)
        delegateTwo?.iconPickedTwo(iconTwo: countryIconTwo)
        
        
         dismiss(animated: true, completion: nil)
    }
    

   

}

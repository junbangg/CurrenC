//
//  SecondViewController.swift
//  CurrenC
//
//  Created by Jun suk Bang on 04/02/2018.
//  Copyright © 2018 Jun Bang. All rights reserved.
//

import UIKit


protocol PickerViewController{
    func currencyPicked(currency: String)
    func iconPicked(icon: String)
}


class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
   let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","KRW","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencyIconArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥","￦", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var delegate : PickerViewController?
    var countryPicked : String = ""
    var countryIcon : String = ""
    
    

    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryPicked = currencyArray[row]
        countryIcon = currencyIconArray[row]
        
        delegate?.currencyPicked(currency: countryPicked)
        delegate?.iconPicked(icon: countryIcon)
        
        
        dismiss(animated: true, completion: nil )
    }

   
}

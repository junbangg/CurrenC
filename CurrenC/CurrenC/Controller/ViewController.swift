//
//  ViewController.swift
//  CurrenC
//
//  Created by Jun suk Bang on 04/02/2018.
//  Copyright © 2018 Jun Bang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, PickerViewController, PickerViewControllerTwo {
    
    @IBOutlet weak var firstCurrencyLabel: UILabel!
    @IBOutlet weak var secondCurrencyLabel: UILabel!
    @IBOutlet weak var convertedCurrency: UILabel!
    @IBOutlet weak var inputedCurrency: UILabel!
    
    
    let beginningURL = "https://free.currencyconverterapi.com/api/v5/convert?q="
    var finalCurrency = ""
    let underScore = "_"
    var finalCurrencyTwo = ""
    let endURL = "&compact=y"
    var finalURL = ""
    let currencyDataModel = CurrencyDataModel()
    var inputedValue : String = ""
    var finalValue : Double = 0
    var tenCount : Int = 0
    var decimalCount : Int = 0
    var decimalValue : String = ""
    var finalDecimalValue : Double = 0
    var currencyIcon : String = ""
    var currencyIconTwo : String = ""
    
    
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
       
        if inputedValue == "." || decimalValue.starts(with: "0.")  {
            
            
            
            if sender.tag == 0 {
                
                decimalValue += "\(sender.tag)"
                tenCount = tenCount * 10
                inputedCurrency.text = currencyIcon + decimalValue
                decimalCalculation()
            }else {
                decimalValue += "\(sender.tag)"
                inputedCurrency.text = currencyIcon +  decimalValue
                decimalCalculation()
            }
            
           
            
            
        }else {
        
        inputedValue += "\(sender.tag)"
        inputedCurrency.text = currencyIcon +  inputedValue
        calculation()
        
        }
    }
    
    @IBAction func zeroZero(_ sender: UIButton) {
        if inputedValue == "" {
            
            print("fuck")
        }else {
            inputedValue += "00"
            inputedCurrency.text = currencyIcon +  inputedValue
            calculation()
        }
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        inputedValue = ""
        decimalValue = ""
        tenCount = 0
        finalValue = 0
        finalDecimalValue = 0
        convertedCurrency.text = currencyIconTwo +  "0"
        inputedCurrency.text = currencyIcon + "0"
        decimalCount = 0
    }
    
    @IBAction func decimalPressed(_ sender: UIButton) {
        
        if (inputedValue.last != ".") {
            
            
            if inputedValue == "0" || inputedValue == "" {
                
                decimalValue = "0."
                inputedCurrency.text = currencyIcon +  decimalValue
                tenCount += 10
                decimalCount += 1
                
                
            }else {
                inputedValue += "."
                inputedCurrency.text = currencyIcon +  inputedValue
                calculation()
            }
            
        }
        else {
            print("pressed multiple decimals in a row")
        }
       
    }
    
    @IBAction func backSpacePressed(_ sender: UIButton) {
        
        if inputedValue.isEmpty && decimalValue.isEmpty {
            print("pressed backspace")
        }else if decimalCount > 0 {
            
            decimalValue.removeLast()
            
            if decimalValue.isEmpty || decimalValue == "0" {
                inputedCurrency.text = currencyIcon + "0"
                convertedCurrency.text = currencyIconTwo +  "0"
                decimalCount = 0
                decimalValue = ""
                inputedValue = ""
            }else {
                decimalCalculation()
                inputedCurrency.text = currencyIcon +  decimalValue
            
        }
        }else if decimalCount == 0 {
        
            inputedValue.removeLast()
            
            if inputedValue.isEmpty {
                
                inputedCurrency.text = currencyIcon + "0"
                convertedCurrency.text = currencyIconTwo +  "0"
                
            }else {
                calculation()
                inputedCurrency.text = currencyIcon + inputedValue
            }
            
        }
    }
    
    /*@IBAction func switchButton(_ sender: UIButton) {
        
     
        
        
        
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func currencyPicked(currency: String) {
        print("Currency:\(currency)")
        firstCurrencyLabel.text = currency
        finalCurrency = currency
        getFinalURL()
        
    }
    func currencyPickedTwo(currencyTwo: String) {
        print("Currency:\(currencyTwo)")
        secondCurrencyLabel.text = currencyTwo
        finalCurrencyTwo = currencyTwo
        getFinalURL()
        getData(url: finalURL)
        
    }
    func iconPicked(icon: String) {
        currencyIcon = ""
        currencyIcon += "\(icon)"
        inputedCurrency.text = currencyIcon
        
    }
    func iconPickedTwo(iconTwo: String) {
        currencyIconTwo = ""
        currencyIconTwo += "\(iconTwo)"
        convertedCurrency.text = currencyIconTwo
        
    }
    func getFinalURL()  {
        finalURL = beginningURL + finalCurrency + underScore + finalCurrencyTwo + endURL
        
        
    }
    func getData(url: String) {
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    let currencyJSON: JSON = JSON(response.result.value!)
                    self.updateCurrencyData(json: currencyJSON)
                print("success")
                }else {
                    print("error")
                }
    }
    }
    func updateCurrencyData(json: JSON) {
        if let currencyResult = json["\(finalCurrency)_\(finalCurrencyTwo)"]["val"].double {
            currencyDataModel.currency = Double(currencyResult)
            
        
        }else{
            print("fuck")
        }
        
        
    }
    func calculation()  {
        
        if inputedValue.first != "." {
            
            finalValue = Double(inputedValue)! * currencyDataModel.currency
            convertedCurrency.text = currencyIconTwo + String(finalValue)
            
        }else {
            print("no")
            
        }
        
        
    }
    
    func decimalCalculation() {
        finalDecimalValue = Double(decimalValue)! * Double(tenCount) * currencyDataModel.currency / Double(tenCount)
        convertedCurrency.text = currencyIconTwo + String(finalDecimalValue)
    }
   
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstSegue"{
            let destinationVC = segue.destination as! SecondViewController
            
            
            destinationVC.delegate = self
        }else if segue.identifier == "secondSegue" {
            let destinationTwoVC = segue.destination as! ThirdViewController
            
            destinationTwoVC.delegateTwo = self
        }
        
        
        

        
        
        
    }
    
    
}


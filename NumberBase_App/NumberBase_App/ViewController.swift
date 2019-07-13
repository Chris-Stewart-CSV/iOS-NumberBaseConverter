//
//  ViewController.swift
//  NumberBase_App
//
//  Created by Stewart, Christopher Michael on 6/28/19.
//  Copyright © 2019 Christopher. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //WelcomeView Outlets
    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var welcomeBanner: UIImageView!
    @IBOutlet weak var binaryImage: UIImageView!

    //CalculateView Outlets
    @IBOutlet var calculateView: UIView!
    @IBOutlet weak var enteredNum: UILabel!
    @IBOutlet weak var incrementNum: UILabel!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var selectionSeg: UISegmentedControl!
    @IBOutlet weak var convertTo: UIPickerView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var errorMessage: UILabel!
    
    //Output Labels
    @IBOutlet weak var binary: UILabel!
    @IBOutlet weak var octal: UILabel!
    @IBOutlet weak var decimal: UILabel!
    @IBOutlet weak var hexa: UILabel!
    @IBOutlet weak var binOut: UILabel!
    @IBOutlet weak var octOut: UILabel!
    @IBOutlet weak var decOut: UILabel!
    @IBOutlet weak var hexOut: UILabel!
    
    var calculateBases = CalculateBases()
       
    //Function to control UIStepper - GET THIS WORKING FRIDAY!!!
    @IBAction func stepperControl(_ sender: UIStepper) {
        
        if getInputVal(){
            if stepper.value == 1{
                calculateBases.inType += 1
            }else{
                calculateBases.inType -= 1
            }
        }else{
            errorMessage.text = "UhOh Again 2"
            errorMessage.isHidden = false
            return
        }
        setInputVal()
        setOutputVal()
        errorMessage.isHidden = true
    }//end stepperControl
    
    //Function to control button presses
    @IBAction func doStuff(_ sender: Any) {
        
        let whichButtonPressed = (sender as! UIButton).currentTitle!
        switch whichButtonPressed {
            case "Enter":
                welcomeView.isHidden = true
                calculateView.isHidden = false
            case "Convert":
                makeOutputsHidden()
                if getInputVal(){
                    setOutputVal()
                }
            default:
                break
        }//end switch
    }//end
    
    func getInputVal() -> Bool{
        switch selectionSeg.selectedSegmentIndex{
            case 0:
                if let num = Int(inputField.text!, radix: 2){
                    calculateBases.inType = num
                    return true
                }
            case 1:
                if let num = Int(inputField.text!, radix: 8){
                    calculateBases.inType = num
                    return true
                }
            case 2:
                if let num = Int(inputField.text!, radix: 10){
                    calculateBases.inType = num
                    return true
                }
            case 3:
                if let num = Int(inputField.text!, radix: 16){
                    calculateBases.inType = num
                    return true
                }
            default:
                errorMessage.text = "UhOh"
                errorMessage.isHidden = false
        }//end switch
        return false
    }//end getInputVal
    
    func setInputVal(){
        //Set inputField to accept a number in whatever base is selected at the top
        switch selectionSeg.selectedSegmentIndex{
            case 0:
                inputField.text = calculateBases.binary()
            case 1:
                inputField.text = calculateBases.octal()
            case 2:
                inputField.text = calculateBases.decimal()
            case 3:
                inputField.text = calculateBases.hex()
            default:
                errorMessage.text = "UhOh Again"
            errorMessage.isHidden = false
        }//end switch
    }//end setInputVal
    
    func setOutputVal(){
        //Set output text value
        binOut.text = calculateBases.binary()
        octOut.text = calculateBases.octal()
        decOut.text = calculateBases.decimal()
        hexOut.text = calculateBases.hex()
        //Determine which output labels to show
        switch convertTo.selectedRow(inComponent: 0){
            case 0:
                binOut.isHidden = false
                octOut.isHidden = true
                decOut.isHidden = true
                hexOut.isHidden = true
            case 1:
                binOut.isHidden = true
                octOut.isHidden = false
                decOut.isHidden = true
                hexOut.isHidden = true
            case 2:
                binOut.isHidden = true
                octOut.isHidden = true
                decOut.isHidden = false
                hexOut.isHidden = true
            case 3:
                binOut.isHidden = true
                octOut.isHidden = true
                decOut.isHidden = true
                hexOut.isHidden = false
            case 4:
                binOut.isHidden = false
                octOut.isHidden = false
                decOut.isHidden = false
                hexOut.isHidden = false
            default:
                enteredNum.text = "Default"
        }//end switch
    }//end setOutputVal
    
    //PickerView Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }//end numberOfComponents
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return calculateBases.outputChoice.count
    }//end pickerView
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return calculateBases.outputChoice[row]
    }//end
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.inputField.resignFirstResponder()
        self.view.endEditing(true)
    }//end touchesBegan
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.inputField{
            self.inputField.resignFirstResponder()
        }
        return true
    }//end textFieldShouldReturn
    
    func makeOutputsHidden(){
        binOut.isHidden = true
        octOut.isHidden = true
        decOut.isHidden = true
        hexOut.isHidden = true
    }//end makeOutputsHidden
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateView.isHidden = true
        self.inputField.delegate = self
        inputField.becomeFirstResponder()
        self.convertTo.delegate = self
        self.convertTo.dataSource = self
    }//end override
    
}//end class


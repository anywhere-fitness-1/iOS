//
//  AddClassViewController.swift
//  AnywhereFitness
//
//  Created by Norlan Tibanear on 8/24/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit



class AddClassViewController: UIViewController, UITextFieldDelegate {
    
    // Outlets
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var instructorNameTextField: UITextField!
    @IBOutlet weak var addDatePickerView: UIDatePicker!
    @IBOutlet weak var addTimePickerView: UIDatePicker!
    @IBOutlet weak var intensitySegmentedControl: UISegmentedControl!
    
 
    @IBOutlet weak var durationSegmentControl: UISegmentedControl!
    @IBOutlet weak var addTypePickerView: UIPickerView!
    @IBOutlet weak var stepperControl: UIStepper!
    @IBOutlet weak var maxClassSizeLabel: UILabel!
    
    
    @IBOutlet weak var bottomConstrain: NSLayoutConstraint!
    
    // MARK: - Properties
    private let dataSource = ["Yoga", "Pilates", "Aerobics", "Zumba", "Cross Fit", "Strength Training"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        instructorNameTextField.delegate = self
//        durationTextField.delegate = self
//        maxClassSizeTextField.delegate = self
        
        addTypePickerView.delegate = self
        addTypePickerView.dataSource = self
        
//        self.hideKeyBoard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
//        durationSegmentControl.layer.borderColor = UIColor.systemOrange.cgColor
//        durationSegmentControl.layer.borderWidth = 2
//        durationSegmentControl.backgroundColor = UIColor.white
//        durationSegmentControl.layer.backgroundColor = UIColor.white.cgColor
        
    }
    
    @IBAction func maxClassSizeStepper(_ sender: UIStepper) {
        var number = 0
        number = Int(sender.value)
        maxClassSizeLabel.text = String(number)
    }
    
    
    
    // Selector Objc Keyboard function
    @objc func Keyboard(notification: Notification) {
        
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = UIEdgeInsets.zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    // Methods or Functions
    func hideKeyBoard() {
        nameTextField.resignFirstResponder()
        instructorNameTextField.resignFirstResponder()
//        durationTextField.resignFirstResponder()
//        maxClassSizeTextField.resignFirstResponder()
    }
    
    // UITextField Delegates Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyBoard()
        return true
    }

    
 
    
    
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
    }
    
   
    @IBAction func cancelBtn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
} // CLASS

// MARK: - Type PickerView

extension AddClassViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return dataSource.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
} //


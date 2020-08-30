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
    @IBOutlet weak var addDatePickerView: UIDatePicker!
    @IBOutlet weak var locationPickerView: UIPickerView!
    @IBOutlet weak var intensitySegmentedControl: UISegmentedControl!
    
 
    @IBOutlet weak var durationSegmentControl: UISegmentedControl!
    @IBOutlet weak var addTypePickerView: UIPickerView!
    @IBOutlet weak var stepperControl: UIStepper!
    @IBOutlet weak var maxClassSizeLabel: UILabel!
    
    
    @IBOutlet weak var bottomConstrain: NSLayoutConstraint!
    
    // MARK: - Properties
    
    private let classTypes = ClassType.allCases.map { $0.rawValue }
    private let locations = Location.allCases.map { $0.rawValue }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginController.shared.setCurrentUser()
        nameTextField.delegate = self
//        instructorNameTextField.delegate = self
//        durationTextField.delegate = self
//        maxClassSizeTextField.delegate = self
        
        addTypePickerView.delegate = self
        addTypePickerView.dataSource = self
        locationPickerView.delegate = self
        locationPickerView.dataSource = self
        
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
//        instructorNameTextField.resignFirstResponder()
//        durationTextField.resignFirstResponder()
//        maxClassSizeTextField.resignFirstResponder()
    }
    
    // UITextField Delegates Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyBoard()
        return true
    }

    
 
    
    
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        
        guard let classTitle = nameTextField.text,
            !classTitle.isEmpty,
            let instructorID = LoginController.shared.currentUser?.identifier else { return }
        let startTime = addDatePickerView.date
        let intensityIndex = intensitySegmentedControl.selectedSegmentIndex
        let intensity = Intensity.allCases[intensityIndex]
        let durationIndex = durationSegmentControl.selectedSegmentIndex
        let duration = Duration.allCases[durationIndex]
        let classTypeIndex = addTypePickerView.selectedRow(inComponent: 0)
        let classType = ClassType.allCases[classTypeIndex]
        let locationIndex = locationPickerView.selectedRow(inComponent: 0)
        let location = Location.allCases[locationIndex]
        let maxClassSize = Int(stepperControl.value)

        let classListing = ClassListing(classTitle: classTitle, classType: classType, instructorID: instructorID, startTime: startTime, duration: duration, intensity: intensity, location: location, maxClassSize: maxClassSize)
        ClassController.shared.createClass(classListing: classListing)
        
//        do {
//            try CoreDataStack.shared.mainContext.save()
//            navigationController?.dismiss(animated: true, completion: nil)
//        } catch {
//            NSLog("Error saving managed object context: \(error)")
//        }
        
        dismiss(animated: true, completion: nil)
        
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
        switch pickerView {
        case locationPickerView:
            return locations.count
        default:
            return classTypes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case locationPickerView:
            return locations[row]
        default:
            return classTypes[row]
        }
    }
    
} //


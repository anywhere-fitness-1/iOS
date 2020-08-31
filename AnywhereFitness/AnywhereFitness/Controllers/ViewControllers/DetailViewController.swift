//
//  DetailViewController.swift
//  AnywhereFitness
//
//  Created by John McCants on 8/27/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class DetailViewController: UIViewController {

       // Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var instructorLabel: UILabel!
    @IBOutlet weak var intensityLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var attendeesTextView: UITextView!
    @IBOutlet weak var maxClassSizeLabel: UILabel!

    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var centerBackgroundView: UIView!
    @IBOutlet weak var bottomBackgroundView: UIView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var smallViewLeft: UIView!
    @IBOutlet weak var smallViewCenter: UIView!
    @IBOutlet weak var smallViewRight: UIView!
    @IBOutlet weak var registerButton: UIButton!

    // MARK: - Properties
    let customUI = CustomUI()

    var classListing: ClassListing?

    private let dateFormatter = DateFormatter()
    private let timeFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        updateView()
//        setUpViews()
    }

    func updateView() {
        guard let classListing = classListing else { return }

        nameLabel.text = classListing.classTitle
        dateFormatter.dateStyle = .short
        if let date = classListing.startTime {
            dateLabel.text = dateFormatter.string(from: date)
        }
        timeFormatter.timeStyle = .short
        if let time = classListing.startTime {
            timeLabel.text = timeFormatter.string(from: time)
        }
        locationLabel.text = classListing.location
        intensityLabel.text = classListing.intensity
        durationLabel.text = classListing.duration
        typeLabel.text = classListing.classType
        attendeesTextView.text = classListing.attendees
        maxClassSizeLabel.text = String(classListing.maxClassSize)

        guard let instructorId = classListing.instructorID else { return }

        LoginController.shared.getUser(with: instructorId) { (user) in
            DispatchQueue.main.async {
                self.instructorLabel.text = user.name
            }
        }

    }//

    func configureView() {
        customUI.customCardView(card: topBackgroundView)
        customUI.customCardView(card: centerBackgroundView)
        customUI.customCardView(card: bottomBackgroundView)
        customUI.customSmallCardView(card: smallViewLeft)
        customUI.customSmallCardView(card: smallViewCenter)
        customUI.customSmallCardView(card: smallViewRight)
        locationView.layer.borderWidth = 1
        locationView.layer.borderColor = UIColor.white.cgColor
    }

    @IBAction func registerButtonTapped(_ sender: UIButton) {
        if sender.titleLabel?.text == "Register" {
            sender.setTitle("Registered", for: .normal)
        } else if sender.titleLabel?.text == "Registered" {
            showAlert()
        }
    }

    @IBAction func xButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func showAlert() {
        let alert = UIAlertController(title: "Unregistering from Class", message: "Are you sure you want to unregister from the class?", preferredStyle: .alert)

        alert.addAction(UIAlertAction.init(title: "Yes", style: .default, handler: { (action) in
                print("Something")
            self.registerButton.setTitle("Register", for: .normal)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        self.present(alert, animated: true)
    }

//    func setUpViews() {
//
//        guard let classListing = classListing else {
//            return
//        }
//        nameLabel.text = classListing.classTitle
//        dateLabel.text = "\(classListing.startTime)"
//        timeLabel.text = "2:30pm"
//        locationLabel.text = classListing.location
//        instructorLabel.text = classListing.instructorName
//        intensityLabel.text = classListing.intensity
//        durationLabel.text = classListing.duration
//        typeLabel.text = classListing.classType
//        attendeesTextView.text = "\(classListing.attendees)"
//        maxClassSizeLabel.text = "\(classListing.maxClassSize)"
//    }
}

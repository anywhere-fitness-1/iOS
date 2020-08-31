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
import FirebaseAuth
import FirebaseDatabase

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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ClassController.shared.getClasses { (_) in
            DispatchQueue.main.async {
                ClassController.shared.getUserClasses { (_) in
                    DispatchQueue.main.async {
                    }
                }
            }
        }
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
        maxClassSizeLabel.text = String(classListing.maxClassSize)

        guard let instructorId = classListing.instructorID else { return }

        LoginController.shared.getUser(with: instructorId) { (user) in
            DispatchQueue.main.async {
                self.instructorLabel.text = user.name
            }
        }
        ClassController.shared.getClasses { (_) in
            ClassController.shared.getAttendees(classListing: classListing) { (attendeeNames) in
                DispatchQueue.main.async {
                    self.attendeesTextView.text = attendeeNames
                    guard let identifierString = classListing.attendees else { return }
                    let attendeeArray = (identifierString.components(separatedBy: ", ")).map { $0 }
                    if let identifier = Auth.auth().currentUser?.uid {
                        if attendeeArray.contains(identifier) {
                            self.navigationItem.rightBarButtonItem?.isEnabled = false
                            self.navigationItem.rightBarButtonItem?.tintColor = .clear
                            self.view.layoutIfNeeded()
                        } else {
                            self.navigationItem.rightBarButtonItem?.isEnabled = true
                            self.navigationItem.rightBarButtonItem?.tintColor = .black
                            self.view.setNeedsDisplay()
                        }
                    }
                }
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

    @IBAction func registerButton(_ sender: UIBarButtonItem) {
        guard let classListing = classListing else { return }
            ClassController.shared.register(classListing: classListing)
            ClassController.shared.getUserClasses { (userClasses) in
                DispatchQueue.main.async {
                    ClassController.shared.userClasses = userClasses
                    ClassController.shared.getAttendees(classListing: classListing) { (attendeeNames) in
                        DispatchQueue.main.async {
                            self.attendeesTextView.text = attendeeNames
                            self.view.layoutSubviews()
                    }
                }
            }
        }
    }

}

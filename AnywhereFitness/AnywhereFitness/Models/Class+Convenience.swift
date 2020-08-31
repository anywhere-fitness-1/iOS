//
//  Class+Convenience.swift
//  AnywhereFitness
//
//  Created by Cora Jacobson on 8/20/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation
import CoreData

enum Intensity: String, CaseIterable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
}

enum ClassType: String, CaseIterable {
    case yoga = "Yoga"
    case pilates = "Pilates"
    case aerobics = "Aerobics"
    case dance = "Dance"
    case crossFit = "Cross Fit"
    case strengthTraining = "Strength Training"
    case martialArts = "Martial Arts"
    case other = "Other"
}

enum Location: String, CaseIterable {
    case sanFran = "San Francisco"
    case newYork = "New York"
}

enum Duration: String, CaseIterable {
    case thirtyMin = "30 Minutes"
    case fortyFiveMin = "45 Minutes"
    case sixtyMin = "60 Minutes"
    case ninetyMin = "90 Minutes"
}

extension ClassListing {

    var classRepresentation: ClassRepresentation? {
        guard let identifier = identifier?.uuidString,
            let classTitle = classTitle,
            let classType = classType,
            let instructorID = instructorID,
            let startTime = startTime,
            let duration = duration,
            let intensity = intensity,
            let location = location,
            let attendees = attendees else { return nil }

        return ClassRepresentation(identifier: identifier, classTitle: classTitle, classType: classType, instructorID: instructorID, startTime: startTime, duration: duration, intensity: intensity, location: location, maxClassSize: Int(maxClassSize), attendees: (attendees.components(separatedBy: ", ")).map { $0 })
    }

    @discardableResult convenience init(identifier: UUID = UUID(),
                                        classTitle: String,
                                        classType: ClassType,
                                        instructorID: String,
                                        startTime: Date,
                                        duration: Duration,
                                        intensity: Intensity,
                                        location: Location,
                                        maxClassSize: Int,
                                        attendees: [String],
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.identifier = identifier
        self.classTitle = classTitle
        self.classType = classType.rawValue
        self.instructorID = instructorID
        self.startTime = startTime
        self.duration = duration.rawValue
        self.intensity = intensity.rawValue
        self.location = location.rawValue
        self.maxClassSize = Int16(maxClassSize)
        self.attendees = (attendees.map {$0}).joined(separator: ", ")
    }

    @discardableResult convenience init?(classRepresentation: ClassRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        guard let identifier = UUID(uuidString: classRepresentation.identifier),
            let classType = ClassType(rawValue: classRepresentation.classType),
            let intensity = Intensity(rawValue: classRepresentation.intensity),
            let location = Location(rawValue: classRepresentation.location),
            let duration = Duration(rawValue: classRepresentation.duration) else { return nil }
        self.init(identifier: identifier,
                  classTitle: classRepresentation.classTitle,
                  classType: classType,
                  instructorID: classRepresentation.instructorID,
                  startTime: classRepresentation.startTime,
                  duration: duration,
                  intensity: intensity,
                  location: location,
                  maxClassSize: classRepresentation.maxClassSize,
                  attendees: classRepresentation.attendees,
                  context: context)
    }

}

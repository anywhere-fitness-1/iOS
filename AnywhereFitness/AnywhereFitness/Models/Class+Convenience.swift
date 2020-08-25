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

enum Type: String, CaseIterable {
    case yoga = "Yoga"
    case pilates = "Pilates"
    case aerobics = "Aerobics"
    case zumba = "Zumba"
    case crossFit = "Cross Fit"
    case strengthTraining = "Strength Training"
}

enum Location: String, CaseIterable {
    case sanFran = "San Francisco"
    case newYork = "New York"
}

extension Class {
    
    var classRepresentation: ClassRepresentation? {
        guard let uuid = uuid?.uuidString,
            let name = name,
            let type = type,
            let date = date,
            let startTime = startTime,
            let intensity = intensity,
            let location = location,
            let attendees = attendees else { return nil }
        
        return ClassRepresentation(uuid: uuid, id: Int(id), name: name, type: type, instructorID: Int(instructorID), date: date, startTime: startTime, duration: Int(duration), intensity: intensity, location: location, maxClassSize: Int(maxClassSize), attendeeCount: Int(attendeeCount), attendees: (attendees.components(separatedBy: ", ")).map { Int($0)!})
    }
    
    @discardableResult convenience init(uuid: UUID = UUID(),
                                        id: Int,
                                        name: String,
                                        type: Type,
                                        instructorID: Int,
                                        date: String,
                                        startTime: String,
                                        duration: Int,
                                        intensity: Intensity,
                                        location: Location,
                                        maxClassSize: Int,
                                        attendeeCount: Int = 0,
                                        attendees: [Int] = [],
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.uuid = uuid
        self.id = Int16(id)
        self.name = name
        self.type = type.rawValue
        self.instructorID = Int16(instructorID)
        self.date = date
        self.startTime = startTime
        self.duration = Int16(duration)
        self.intensity = intensity.rawValue
        self.location = location.rawValue
        self.maxClassSize = Int16(maxClassSize)
        self.attendeeCount = Int16(attendeeCount)
        self.attendees = (attendees.map{String($0)}).joined(separator: ", ")
    }
    
    @discardableResult convenience init?(classRepresentation: ClassRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        guard let uuid = UUID(uuidString: classRepresentation.uuid),
            let type = Type(rawValue: classRepresentation.type),
            let intensity = Intensity(rawValue: classRepresentation.intensity),
            let location = Location(rawValue: classRepresentation.location) else { return nil }
        self.init(uuid: uuid,
                  id: classRepresentation.id,
                  name: classRepresentation.name,
                  type: type,
                  instructorID: classRepresentation.instructorID,
                  date: classRepresentation.date,
                  startTime: classRepresentation.startTime,
                  duration: classRepresentation.duration,
                  intensity: intensity,
                  location: location,
                  maxClassSize: classRepresentation.maxClassSize,
                  attendeeCount: classRepresentation.attendeeCount,
                  attendees: classRepresentation.attendees,
                  context: context)
    }
    
}

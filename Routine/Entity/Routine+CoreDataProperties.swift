//
//  Routine+CoreDataProperties.swift
//  Routine
//
//  Created by Mostafa Junayed on 5/23/22.
//
//

import Foundation
import CoreData


extension Routine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Routine> {
        return NSFetchRequest<Routine>(entityName: "Routine")
    }

    @NSManaged public var day: Set<String>?
    @NSManaged public var name: String?

}

extension Routine : Identifiable {

}

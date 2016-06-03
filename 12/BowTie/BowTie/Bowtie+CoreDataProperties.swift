//
//  Bowtie+CoreDataProperties.swift
//  BowTie
//
//  Created by 季勤强 on 16/6/2.
//  Copyright © 2016年 季勤强. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Bowtie {

    @NSManaged var name: String?
    @NSManaged var isFavorate: NSNumber?
    @NSManaged var lastWorn: NSDate?
    @NSManaged var rating: NSNumber?
    @NSManaged var searchKey: String?
    @NSManaged var timesWorn: NSNumber?
    @NSManaged var photoData: NSData?
    @NSManaged var tintColor: NSObject?

}

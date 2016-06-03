//
//  CoreDataStack.swift
//  WalkDog
//
//  Created by 季勤强 on 16/6/2.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import CoreData

class CoreDataStack {
    let context: NSManagedObjectContext
    let psc: NSPersistentStoreCoordinator
    let model: NSManagedObjectModel
    let store: NSPersistentStore?
    
    init() {
        let bundle = NSBundle.mainBundle()
        let modelURL = bundle.URLForResource("Dog Walk", withExtension: "momd")
        model = NSManagedObjectModel(contentsOfURL: modelURL!)!
        
        psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        context = NSManagedObjectContext()
        context.persistentStoreCoordinator = psc
        
        let documentsURL = self.applicationDocumentsDirectory()
        let storeURL = documentsURL.URLByAppendingPathComponent("Dog Walk")
        
    }
    
    func applicationDocumentsDirectory() -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentationDirectory, inDomains: .UserDomainMask) as [NSURL]
        return urls[0]
    }
    
}

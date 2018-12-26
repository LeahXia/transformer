//
//  CoreDataStack.swift
//  Transformer
//
//  Created by Leah Xia on 2018-12-25.
//  Copyright © 2018 Leah Xia. All rights reserved.
//

import UIKit
import CoreData

/// CoreData Stack Setup
final class CoreDataStack: NSObject {
   
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Transformer")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                self.showError(message: "\(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true

        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                self.showError(message: "\(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Helper
    
    /**
     Display an error message to user with default UIAlertController.

     - Parameters:
         - title: Alert title which will be displayed to user. (Default to "Error")
         - message: Alert message which will be displayed to user.

     */
    func showError(title: String = "Error", message: String) {
        if var topController = UIApplication.shared.delegate?.window??.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            topController.present(alert, animated: true)
        }
    }
}

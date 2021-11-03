//
//  CoreDataManager.swift
//  SteamList
//
//  Created by Andrei Atrakhimovich on 1.11.21.
//

import Foundation
import CoreData

class DataManagerImplementation: DataManager {

    static var shared = DataManagerImplementation()

    private var context: NSManagedObjectContext

    init() {
        let persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "Games")
            container.loadPersistentStores(completionHandler: { (_, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
        context = persistentContainer.newBackgroundContext()
    }

    func getGamesList() -> ([GamesListItem], DataStatus) {
        let fetchRequest: NSFetchRequest<GameItem> = GameItem.fetchRequest()
        do {
            let objects = try context.fetch(fetchRequest)
            if objects.count == 0 {
                return ([GamesListItem](), .empty)
            }
            var list = [GamesListItem]()
            for item in objects {
                let newItem = GamesListItem(gameID: Int(item.gameID), name: item.name)
                list.append(newItem)
            }
            return (list, .success)
        } catch {
            return ([GamesListItem](), .error)
        }
    }

    func saveGamesList(gamesList: [GamesListItem]) {
        clearGamesList()
        for item in gamesList {
            let gameItem = GameItem(context: context)
            gameItem.gameID = Int64(item.gameID)
            gameItem.name = item.name
        }
        saveContext()
    }

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private func clearGamesList() {
        let fetchRequest: NSFetchRequest<GameItem> = GameItem.fetchRequest()
        do {
            let objects = try context.fetch(fetchRequest)
            for item in objects {
                context.delete(item)
            }
            saveContext()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

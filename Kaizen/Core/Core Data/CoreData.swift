//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    init() {
        guard let modelURL = Bundle(for: type(of: self)).url(forResource: "KaizenCoreData", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL),
              let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("KaizenCoreData.sqlite") else {
            fatalError("Managed object model not found")
        }
        
        context.persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        do {
            _ = try context.persistentStoreCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil,
                                                                           at: url, options: [NSMigratePersistentStoresAutomaticallyOption: true,
                                                                                                    NSInferMappingModelAutomaticallyOption: true])
        } catch {
            print(error)
        }
    }
    
    func saveContext() {
        DispatchQueue.main.async {
            guard self.context.hasChanges else { return }
            
            do {
                try self.context.save()
            } catch {
                print(error)
            }
        }
    }
    
    func deleteContext(request: NSBatchDeleteRequest) {
        DispatchQueue.main.async {
            do {
                try self.context.execute(request)
            } catch {
                print(error)
            }
        }
    }
}

extension CoreDataManager {
    
    func createFavoriteEvent(sportEvent: APIResponseSportEvent) {
        let event = Event(context: context)
        
        let encoder = JSONEncoder()
        guard let eventData = try? encoder.encode(sportEvent) else { return }
        
        event.sportId = sportEvent.sportId
        event.eventId = sportEvent.eventId
        event.event = eventData
        
        saveContext()
    }
    
    func getFavoriteEvents() -> [APIResponseSportEvent] {
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        
        do {
            let eventsResult = try context.fetch(fetchRequest)
            
            var events: [APIResponseSportEvent] = []
            
            for event in eventsResult {
                let decoder = JSONDecoder()
                let eventsDecoded = try decoder.decode(APIResponseSportEvent.self, from: event.event ?? Data())
                events.append(eventsDecoded)
            }
            
            return events
        } catch {
            print(error)
            return []
        }
    }
    
    func deleteFavoriteEvent(eventId: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Event")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "eventId = %@", eventId)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        deleteContext(request: deleteRequest)
    }
}

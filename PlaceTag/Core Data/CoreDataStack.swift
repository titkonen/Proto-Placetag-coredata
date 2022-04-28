import CoreData

final class CoreDataStack {
  static let shared = CoreDataStack()
  let context: NSManagedObjectContext

  private init() {
    guard let modelURL = Bundle.main.url(forResource: "PlaceTag", withExtension: "momd") else {
      fatalError("Error loading model from bundle")
    }
    guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
      fatalError("Error initializing mom from: \(modelURL)")
    }

    let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
    context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    context.persistentStoreCoordinator = psc

    do {
      try psc.addPersistentStore(
        ofType: NSSQLiteStoreType,
        configurationName: nil,
        at: CoreDataStack.storeURL,
        options: CoreDataStack.storeOptions)
    } catch {
      fatalError("Error adding store: \(error)")
    }
  }

  private static let storeOptions: [AnyHashable: Any] = [
    NSMigratePersistentStoresAutomaticallyOption: true,
    NSInferMappingModelAutomaticallyOption: true,
    NSPersistentStoreUbiquitousContentNameKey: "CloudStore"
  ]

  private static var storeURL: URL {
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    guard let docURL = urls.last else {
      fatalError("Error fetching document directory")
    }
    let storeURL = docURL.appendingPathComponent("PlaceTag.sqlite")
    return storeURL
  }

  func saveContext() {
    context.saveContext()
  }
}

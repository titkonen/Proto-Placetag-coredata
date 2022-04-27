/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

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

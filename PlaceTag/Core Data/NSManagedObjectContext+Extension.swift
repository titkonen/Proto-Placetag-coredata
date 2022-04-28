import CoreData

extension NSManagedObjectContext {
	func saveContext() {
		do {
			try save()
		} catch {
			let nserror = error as NSError
			fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
		}
	}

	func delete(_ places: [Place]) {
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Place")
		request.predicate = NSPredicate(format: "id IN %@", places.map { $0.id?.uuidString })
		do {
			let results = (try fetch(request) as? [Place]) ?? []
			results.forEach { delete($0) }
		} catch {
			print("Failed removing provided objects")
			return
		}
		saveContext()
	}
}

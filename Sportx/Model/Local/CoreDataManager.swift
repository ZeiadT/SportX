//
//  CoreDataManager.swift
//  SportX
//
//  Created by Zeiad Mohammed on 7/5/2026.
//

import Foundation
import UIKit
import CoreData

final class CoreDataManager {

    static let shared = CoreDataManager()

    private let appDelegate: AppDelegate
    private let context: NSManagedObjectContext

    private init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }

    func addLeague(id: String, name: String, badgeURL: String, sportName: String) {
        let newLeague = LeagueDBEntity(context: context)
        newLeague.id = id
        newLeague.name = name
        newLeague.badge = badgeURL
        newLeague.sportName = sportName
        appDelegate.saveContext()
    }

    func fetchLeagues() -> [LeagueDBEntity] {
        let fetchRequest: NSFetchRequest<LeagueDBEntity> = LeagueDBEntity.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return []
        }
    }

    func deleteLeague(league: LeagueDBEntity) {
        context.delete(league)
        appDelegate.saveContext()
    }

    func deleteLeague(id: String) {
        let fetchRequest: NSFetchRequest<LeagueDBEntity> = LeagueDBEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let results = try context.fetch(fetchRequest)
            results.forEach { context.delete($0) }
            appDelegate.saveContext()
        } catch {}
    }

    func isFavorite(id: String) -> Bool {
        let fetchRequest: NSFetchRequest<LeagueDBEntity> = LeagueDBEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            return try context.count(for: fetchRequest) > 0
        } catch {
            return false
        }
    }

    func toggleFavorite(id: String, name: String, badgeURL: String, sportName: String) -> Bool {
        if isFavorite(id: id) {
            deleteLeague(id: id)
            return false
        } else {
            addLeague(id: id, name: name, badgeURL: badgeURL, sportName: sportName)
            return true
        }
    }
}

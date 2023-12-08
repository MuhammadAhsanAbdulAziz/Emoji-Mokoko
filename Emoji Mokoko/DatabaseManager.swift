//
//  DatabaseManager.swift
//  Emoji Mokoko
//
//  Created by Macbook Pro on 22/11/2023.
//

import GRDB

struct Emoji: Identifiable, Codable, FetchableRecord, MutablePersistableRecord {
    var id: Int64?
    var name: String
}

struct DatabaseManager {
    static let shared = DatabaseManager()

    private var dbQueue: DatabaseQueue

    private init() {
        do {
            // Choose a suitable file URL for your database
            let databaseURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("emojiDatabase.sqlite")

            // Connect to the database
            dbQueue = try DatabaseQueue(path: databaseURL.path)

            // Create the Emoji table
            try dbQueue.write { db in
                try db.create(table: "emoji") { t in
                    t.autoIncrementedPrimaryKey("id")
                    t.column("name", .text).notNull().unique()
                }
            }
        } catch {
            fatalError("Error initializing database: \(error)")
        }
    }

    func addEmoji(name: String) {
        do {
            try dbQueue.write { db in
                var emoji = Emoji(name: name)
                try emoji.save(db)
            }
        } catch {
            print("Error adding emoji to database: \(error)")
        }
    }

    func getRecentEmojis() -> [Emoji] {
        do {
            return try dbQueue.read { db in
                try Emoji.order(Column("id").desc).limit(10).fetchAll(db)
            }
        } catch {
            print("Error fetching recent emojis: \(error)")
            return []
        }
    }
}

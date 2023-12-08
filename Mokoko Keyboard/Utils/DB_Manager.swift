//
//  DB_Manager.swift
//  Emoji Mokoko
//
//  Created by Macbook Pro on 24/11/2023.
//

import Foundation
import SQLite3

class DB_Manager {
    
    // sqlite3 instance
    private var db: OpaquePointer? = nil
    
    // table name
    private let emojisTableName = "emojis"
    
    init() {
        do {
            // path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            let dbPath = "\(path)/my_users.sqlite3"
            
            // open database connection
            if sqlite3_open(dbPath, &db) == SQLITE_OK {
                // check if the table is already created
                if !UserDefaults.standard.bool(forKey: "is_db_created") {
                    // if not, create the table
                    if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS \(emojisTableName) (id INTEGER PRIMARY KEY, name TEXT UNIQUE);", nil, nil, nil) == SQLITE_OK {
                        // set the value to true, so it will not attempt to create the table again
                        UserDefaults.standard.set(true, forKey: "is_db_created")
                    }
                }
            } else {
                print("Error opening database")
            }
        }
    }
    
    public func addEmoji(nameValue: String) {
        let insertStatementString = "INSERT INTO \(emojisTableName) (name) VALUES (?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            let nameCString = nameValue.cString(using: .utf8)
            sqlite3_bind_text(insertStatement, 1, nameCString, -1,nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        
        sqlite3_finalize(insertStatement)
    }
    
    public func getEmojis() -> [EmojiModel] {
        var emojiModels: [EmojiModel] = []
        let queryStatementString = "SELECT * FROM \(emojisTableName) ORDER BY id ASC;"
        var queryStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let emojiModel = EmojiModel()
                emojiModel.id = Int(sqlite3_column_int(queryStatement, 0))
                if let name = sqlite3_column_text(queryStatement, 1) {
                    emojiModel.name = String(cString: name)
                }
                emojiModels.append(emojiModel)
            }
        } else {
            print("SELECT statement could not be prepared.")
        }
        
        sqlite3_finalize(queryStatement)
        return emojiModels
    }
    
    deinit {
        sqlite3_close(db)
    }
}

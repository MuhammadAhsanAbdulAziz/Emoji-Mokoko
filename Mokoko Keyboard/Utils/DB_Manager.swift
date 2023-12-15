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
                    // if not, create the table with the dateTimeAddedUpdated column
                    let createTableString = """
                        CREATE TABLE IF NOT EXISTS \(emojisTableName) (
                            id INTEGER PRIMARY KEY,
                            name TEXT UNIQUE,
                            dateTimeAddedUpdated TEXT
                        );
                    """
                    if sqlite3_exec(db, createTableString, nil, nil, nil) == SQLITE_OK {
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
        let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        let dbPath = "\(path)/my_users.sqlite3"
        print(dbPath)
        
        let selectStatementString = "SELECT * FROM \(emojisTableName) WHERE name = ?;"
        var selectStatement: OpaquePointer? = nil

        // Check if the emoji with the given name already exists
        if sqlite3_prepare_v2(db, selectStatementString, -1, &selectStatement, nil) == SQLITE_OK {
            let nameCString = nameValue.cString(using: .utf8)
            let dateTimeAddedUpdated = getCurrentDateTime().cString(using: .utf8)
            sqlite3_bind_text(selectStatement, 1, nameCString, -1, nil)

            if sqlite3_step(selectStatement) == SQLITE_ROW {
                // Emoji with the same name already exists, update the datetime
                let updateStatementString = "UPDATE \(emojisTableName) SET dateTimeAddedUpdated = ? WHERE name = ?;"
                var updateStatement: OpaquePointer? = nil

                if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
                    sqlite3_bind_text(updateStatement, 1, dateTimeAddedUpdated, -1, nil)
                    sqlite3_bind_text(updateStatement, 2, nameCString, -1, nil)

                    if sqlite3_step(updateStatement) != SQLITE_DONE {
                        let errorMessage = String(cString: sqlite3_errmsg(db))
                        print("Error updating existing row: \(errorMessage)")
                    }
                } else {
                    let errorMessage = String(cString: sqlite3_errmsg(db))
                    print("UPDATE statement could not be prepared: \(errorMessage)")
                }

                sqlite3_finalize(updateStatement)
            } else {
                // Emoji with the given name does not exist, insert a new row
                let insertStatementString = "INSERT INTO \(emojisTableName) (name, dateTimeAddedUpdated) VALUES (?, ?);"
                var insertStatement: OpaquePointer? = nil

                if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                    sqlite3_bind_text(insertStatement, 1, nameCString, -1, nil)
                    sqlite3_bind_text(insertStatement, 2, dateTimeAddedUpdated, -1, nil)

                    if sqlite3_step(insertStatement) != SQLITE_DONE {
                        let errorMessage = String(cString: sqlite3_errmsg(db))
                        print("Error inserting row: \(errorMessage)")
                    }
                } else {
                    let errorMessage = String(cString: sqlite3_errmsg(db))
                    print("INSERT statement could not be prepared: \(errorMessage)")
                }

                sqlite3_finalize(insertStatement)
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("SELECT statement could not be prepared: \(errorMessage)")
        }

        sqlite3_finalize(selectStatement)
    }




    
    public func getEmojis() -> [EmojiModel] {
        var emojiModels: [EmojiModel] = []
        let queryStatementString = "SELECT * FROM \(emojisTableName) ORDER BY datetime(dateTimeAddedUpdated) DESC;"
        var queryStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let emojiModel = EmojiModel()
                emojiModel.id = Int(sqlite3_column_int(queryStatement, 0))
                
                if let name = sqlite3_column_text(queryStatement, 1) {
                    emojiModel.name = String(cString: name)
                }
                
                if let dateTimeAddedUpdated = sqlite3_column_text(queryStatement, 2) {
                    emojiModel.dateTimeAddedUpdated = String(cString: dateTimeAddedUpdated)
                }
                
                // Add additional fields as needed

                emojiModels.append(emojiModel)
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("SELECT statement could not be prepared: \(errorMessage)")
        }
        
        sqlite3_finalize(queryStatement)

        // Reorder the array to ensure it's in descending order by dateTimeAddedUpdated
        emojiModels.sort { $0.dateTimeAddedUpdated > $1.dateTimeAddedUpdated }

        return emojiModels
    }




    
    deinit {
        sqlite3_close(db)
    }
    
    private func getCurrentDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: Date())
    }

}

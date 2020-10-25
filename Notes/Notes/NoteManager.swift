//
//  NoteManager.swift
//  Notes
//
//  Created by Salman Faris on 25/10/2020.
//

import Foundation
import SQLite3

class NoteManager {
    
    var database: OpaquePointer!
    
    static let main = NoteManager()
    
    private init() {}
    
    // Get a path to somewhere on the device where it is safe to save, read and write files. Open the path, and make sure the table we need to exist, exists.
    func connectDatabase() {
        // If database is already connected previously, don't do it again.
        if database != nil { return }
        
        do {
            let databaseURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("notes.sqlite3")
            
            if sqlite3_open(databaseURL.path, &database) == SQLITE_OK {
                if sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS notes (contents TEXT)", nil, nil, nil) == SQLITE_OK {
                    
                }
                else {
                    print("Could not create table")
                }
            }
            else {
                print("Could not connect")
            }
        }
        catch let error {
            print("Could not create database. Error: \(error).")
        }
    }
    
    
    func create() -> Int {
        connectDatabase()
        
        var statement: OpaquePointer!
        
        if sqlite3_prepare_v2(database, "INSERT INTO notes (contents) VALUES ('New note')", -1, &statement, nil) != SQLITE_OK {
            print("Could not create query")
            return -1
        }
        
        if sqlite3_step(statement) != SQLITE_DONE {
            print("Could not insert note")
            return -1
        }
        
        sqlite3_finalize(statement)
        return Int(sqlite3_last_insert_rowid(database))
    }
    
    
    func getAllNotes() -> [Note] {
        connectDatabase()
        
        var result: [Note] = []
        var statement: OpaquePointer!
        
        if sqlite3_prepare_v2(database, "SELECT rowid, contents FROM notes", -1, &statement, nil) != SQLITE_OK {
            print("Error fetching notes")
            return []
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            result.append(Note(id: Int(sqlite3_column_int(statement, 0)), contents: String(cString: sqlite3_column_text(statement, 1))))
        }
        
        sqlite3_finalize(statement)
        
        return result
    }
    
    
    func saveNote(for note: Note) {
        connectDatabase()
        
        var statement: OpaquePointer!
        
        if sqlite3_prepare_v2(database, "UPDATE notes SET contents = ? WHERE rowid = ?", -1, &statement, nil) != SQLITE_OK {
            print("Error updating statement!")
        }
        
        sqlite3_bind_text(statement, 1, NSString(string: note.contents).utf8String, -1, nil)
        sqlite3_bind_int(statement, 2, Int32(note.id))
        
        if sqlite3_step(statement) != SQLITE_DONE {
            print("Error running update!")
        }
        
        sqlite3_finalize(statement)
    }
}

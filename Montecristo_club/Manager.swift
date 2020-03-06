//
//  Manager.swift
//  Montecristo_club
//
//  Created by Enfasis on 3/5/20.
//  Copyright © 2020 html. All rights reserved.
//

// Get a URL to Application Support directory
private var appSupportDirectory:URL = {
    let url = FileManager().urls(for:.applicationSupportDirectory,in: .userDomainMask).first!
    //Checks if directory exists
    if !FileManager().fileExists(atPath: url.path) {
        //Creates directory if necessary
        do {
            try FileManager().createDirectory(at: url,
                                              withIntermediateDirectories: false)
        } catch let error as NSError {
            print("\(error.localizedDescription)")
        }
        
    }
    //Returns the path
    return url
}()

//Gets URL to Books.db file
private var booksFile:URL = {
    
    let filePath = appSupportDirectory.appendingPathComponent("Books").appendingPathExtension("db")
    print(filePath)
    if !FileManager().fileExists(atPath: filePath.path) {
        if let bundleFilePath = Bundle.main.resourceURL?.appendingPathComponent("Books").appendingPathExtension("db") {
            do {
                try FileManager().copyItem(at: bundleFilePath, to: filePath)
            } catch let error as NSError {
                //fingers crossed
                print("\(error.localizedDescription)")
            }
        }
    }
    return filePath
}()

import Foundation


class Manager {
    

    
    
    
    
    
    //Uses the FMDB wrapper to get a reference to the Books database on the specific path
    func getOpenDB()->FMDatabase? {
        let db = FMDatabase(path: booksFile.path)
        guard db.open() else {
            print("Unable to open database")
            return nil
        }
        return db
    }

}


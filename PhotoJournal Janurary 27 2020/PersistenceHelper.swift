//
//  PersistenceHelper.swift
//  PhotoJournal Janurary 27 2020
//
//  Created by Margiett Gil on 1/27/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation
enum DataPersistenceError: Error { // conforming to the Error protocol
  case savingError(Error) // associative value
  case fileDoesNotExist(String)
  case noData
  case decodingError(Error)
  case deletingError(Error)
}

class PersistenceHelper {
    
    private var arrayPhotos = [Pictures]()
    
    private var filename: String
    
    init(filenameInit: String){
        self.filename = filenameInit
    }
    //MARK: This is the C for create in CRUD
    
    //MARK: Adding something to the array and than we will be saving. we always want to save the state of array of  photos
    private func create(item: Pictures) throws {
        arrayPhotos.append(item)
        
        do{
            try save()
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    //MARK: This is were we are actually saving. 
    // throw: means thats it may throw out an error
    private func save() throws {
        
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        do {
            //MARK: Step 3.
            // convert (serialize) the events array to Data
            // in this code, it turns my array into data
            let data = try PropertyListEncoder().encode(arrayPhotos)
            
            //MARK: step 4.
            // writes, saves, persist the data to the documents directory
            // write: adding the data to the arrayPhotos inside the filename
            // atomic: it replaces what you have in your filename with write and deletes what was there before
            try data.write(to: url, options: .atomic)
        } catch {
            //MARK: Step 5.
            throw DataPersistenceError.savingError(error)
        }
    }
    // for re-ordering
    //
    public func sync(item: [Pictures]) {
        self.arrayPhotos = item
        try? save()
        
    }
}



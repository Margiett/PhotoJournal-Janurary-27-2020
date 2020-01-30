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
//MARK: DataPresistence is not type constrained to only work with codable types
// typealias Codable = Encodable & Decodable
typealias Writable = Codable & Equatable
class PersistenceHelper<T: Writable> {
    
    private var arrayPhotos: [T]
    private var filename: String
    
    // this is making an initializer
   public init(filenameInit: String) {
        self.filename = filenameInit
    self.arrayPhotos = []
    }
    //MARK: This is the C for create in CRUD
    
    //MARK: Adding something to the array and than we will be saving. we always want to save the state of array of  photos
    private func create(item: T) throws {
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
    // you are deleting, an item from the array of ImageObject and than rearranging the items and than saving the new array of items.
    // this code is mainly for deleting / updating and saving.
    public func sync(_ item: [T]) {
        self.arrayPhotos = item
        try? save()
        
    }

//MARK: This is the R: read in CRUD this loads all the events into the view controller

    public func loadPhotoJournal() throws -> [T] {
        // we need access to the filename URL that we are reading from
        // this give the location inside the device
        let url = FileManager.pathToDocumentsDirectory(with: filename)
      // if there is an actual file in the device than you take the data in that device
          // this verify if the file exsit
        if FileManager.default.fileExists(atPath: url.path) {
            //checks what is in the file
            if let data = FileManager.default.contents(atPath: url.path) {
            do {
                 // This converts the information inside url.path into data than if it cant it will throw an error because it cant decode from the url data into image
                arrayPhotos = try PropertyListDecoder().decode([T].self, from: data)
            } catch {
                throw DataPersistenceError.decodingError(error)
            }
            
            } else {
                throw DataPersistenceError.noData
            }
    }
        else {
            throw DataPersistenceError.fileDoesNotExist(filename)
        }
        return arrayPhotos

}
    //MARK: This is the D: delete in the C R U D 
    // delete - remove item from documents directory
    public func delete(event index: Int) throws {
        // remove the item from the arrayPhotos array
        arrayPhotos.remove(at: index)
        // save our arrayPhotos to the docyments directory
        do {
            try save()
            
        } catch {
            throw DataPersistenceError.deletingError(error)
        }
    }
    //MARK: Update This is the U in C R U D
    
    @discardableResult // silences the warning if the return value is not used by th caller
    // discardable result - its up the user to use or not use the return value
    public func update(_ oldItem: T, with newItem: T) -> Bool {
        if let index = arrayPhotos.firstIndex(of: oldItem) {
            
            let result = update(newItem, at: index)
            return result
            
        }
        return false
    }
    //MARK: Editing
    @discardableResult
    public func update(_ item: T, at Index: Int) -> Bool {
         // arguements within differenciates should the name of the function be the same as another.
        arrayPhotos[Index] = item
        // save items to documents directory
        do {
            try save()
            return true
        } catch {
            return false
        }
    }
}

//
//  DataPersistenceManager.swift
//  Netflix
//
//  Created by Hậu Nguyễn on 16/3/25.
//

import Foundation
import CoreData
import UIKit
class DataPersistenceManager {
    
    enum DatabaseError: Error {
        case faildToSavedData
        case faildToFetchData
        case faildToDeleteData
    }
    static let shared = DataPersistenceManager()
    
    func fetchingTitlesFromDataBase(completion: @escaping (Result<[TitleItem], Error>) -> Void ) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        
        do {
            
          let titles =  try context.fetch(request)
            completion(.success(titles))
            
        } catch {
            completion(.failure(DatabaseError.faildToFetchData))
            print(error.localizedDescription)
        }
    }
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void ) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TitleItem(context: context)
        
        item.original_title = model.original_title
        item.id = Int64(model.id)
        item.overview = model.overview
        item.original_name = model.original_name
        item.poster_path = model.poster_path
        item.media_type = model.media_type
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        item.vote_average = model.vote_average
        
        do {
           try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.faildToFetchData))
        }
    }
    
    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        
        do {
           try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.faildToDeleteData))
        }

    }
}

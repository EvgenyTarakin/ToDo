//
//  DataManager.swift
//  ToDo
//
//  Created by Евгений Таракин on 20.11.2024.
//

import Foundation
import CoreData

final class DataManager: Hashable {
    
    // MARK: - property
    
    private var tableDatas: [TaskModel] {
        let fetchRequest: NSFetchRequest<TaskModel> = TaskModel.fetchRequest()

        do {
            return try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }
    
    // MARK: - private property
    
    private let context = CoreDataManager().persistentContainer.viewContext

    // MARK: - func
    
    func saveData(title: String, description: String, completed: Bool) {
        guard let entity = NSEntityDescription.entity(forEntityName: "TaskModel", in: context) else {
            return
        }
        
        let object = TaskModel(entity: entity, insertInto: context)
        object.id = 0
        object.todo = title
        object.descriptions = description
        object.date = Date()
        object.completed = completed
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func updateCheckData(index: Int) {
        let fetchRequest: NSFetchRequest<TaskModel> = TaskModel.fetchRequest()
        if let objects = try? context.fetch(fetchRequest) {
            let object = objects[index]
            object.completed.toggle()
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func updateInformationData(index: Int, title: String, description: String) {
        let fetchRequest: NSFetchRequest<TaskModel> = TaskModel.fetchRequest()
        if let objects = try? context.fetch(fetchRequest) {
            let object = objects[index]
            object.todo = title
            object.descriptions = description
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteData(index: Int) {
        let fetchRequest: NSFetchRequest<TaskModel> = TaskModel.fetchRequest()
        if let objects = try? context.fetch(fetchRequest) {
            context.delete(objects[index])
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func getDatas() -> [TaskModel] {
        return tableDatas
    }
    
    let uuid = UUID()
    static func ==(lhs: DataManager, rhs: DataManager) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
}

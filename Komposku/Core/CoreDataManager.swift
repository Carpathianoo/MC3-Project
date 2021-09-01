//
//  CoreDataManager.swift
//  Komposku
//
//  Created by Clara Anggraini on 27/07/21.
//

import UIKit
import CoreData

enum processType{
    case create
    case extend
}

class CoreDataManager{
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    let notificationPublisher = NotificationPublisher()
    
    var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    private init(){
        persistentContainer = NSPersistentContainer(name: "Komposku")
        persistentContainer.loadPersistentStores{ (description, error) in
            if let error = error{
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
    
    func save(){
        if viewContext.hasChanges{
            do{
                try viewContext.save()
            }catch{
                viewContext.rollback()
                fatalError("Unable to save \(error)")
            }
        }
    }
    
    func createCompost(name: String, photo: String, moisture: Double){
        let compostsCount = getAllCompost().count
        let compost = Compost(context: viewContext)
        let processes = createProcess(compost: compost, name: name)
        
        var index = 0
        if compostsCount != 0{
            index = compostsCount-1
        }
        
        compost.identifier = Int64(index+1)
        compost.name = name
        compost.photo = photo
        compost.estimated_date = Calendar.current.date(byAdding: .day, value: 15, to: Date())
        compost.moisture = moisture
        compost.process = processes as NSSet
        save()
    }
    
    func createProcess(compost: Compost, name: String)-> Set<Process>{
        
        var processArr: Set<Process> = compost.process as! Set<Process>
        
        let detailArr = ["Aduk dan cek kondisi", "Aduk dan cek kondisi", "Aduk dan cek kondisi", "Aduk dan cek kondisi", "Panen"]
        
        var index = 1
        
        if processArr.isEmpty{
            let process = Process(context: viewContext)
            process.identifier = Int64(index)
            process.detail = "Kompos dibuat"
            process.date = Date()
            process.isDone = true
            processArr.insert(process)
        }else{
            index = processArr.count
        }
        
        for i in 0...4{
            let process = Process(context: viewContext)
            index += 1
            
            process.identifier = Int64(index)
            process.detail = detailArr[i]
            process.isDone = false
            process.date = Calendar.current.date(byAdding: .day, value: 3*(i+1), to: Date())
            notificationPublisher.sendNotification(title: name, body: process.detail!, badge: 1, date: process.date!)
            processArr.insert(process)
        }
        
        return processArr
    }
    
    func extendProcess(from compost: Compost, date: Date){
        var processes = getAllProcess(from: compost)
        
        guard let process = processes.last else{ return}
        
        process.detail = "Perpanjang"
        process.date = date
        process.isDone = true
        
        processes.append(process)
        
        compost.process = NSSet(array: processes)
        compost.process = createProcess(compost: compost, name: compost.name!) as NSSet
        compost.estimated_date = Calendar.current.date(byAdding: .day, value: 15, to: Date())
        save()
    }
    
    func getAllCompost() -> [Compost]{
        let request: NSFetchRequest<Compost> = Compost.fetchRequest()
        do{
            return try viewContext.fetch(request)
        }catch{
            return []
        }
    }
    
    func getAllProcess(from compost: Compost) -> [Process]{
        var processes: [Process] = []
        
        if let procs = compost.process as? Set<Process>{
            for p in procs{
                processes.append(p)
            }
            processes = processes.sorted{procA, procB in procA.identifier < procB.identifier}
        }
        return processes
    }
    
    //update process kalo udah selesai
    func updateProcessStatus(process: Process){
        process.isDone = true
        save()
    }
    
    func scheduleNotification(process: Process) {
        guard let unwrappedDetail = process.detail else {return}
        guard let unwrappedDate = process.date else {return}
        guard let unwrappedCompost = process.compost?.name else {return}
        notificationPublisher.sendNotification(title: unwrappedCompost, body: "Waktunya \(unwrappedDetail) kompos kamu.", badge: 1, date: unwrappedDate)
            
        
    }
    
    func deleteCompost(compost: Compost){
            viewContext.delete(compost)
            save()
        }
}

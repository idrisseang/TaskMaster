//
//  TaskList.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 09/04/2023.
//

import Foundation

class TaskList : ObservableObject{
    @Published var tasks : [Task]
    
    init(tasks: [Task]) {
        self.tasks = tasks
    }
    
    static func save(tasks : [Task], completion : @escaping (Result<Int,Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(tasks)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(tasks.count))
                }
            } catch{
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func load(completion : @escaping (Result<[Task],Error>) -> Void){
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let tasks = try JSONDecoder().decode([Task].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(tasks))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private static func fileURL() throws -> URL {
        let path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let url = path.appendingPathComponent("tasks.data")
        return url 
    }
}

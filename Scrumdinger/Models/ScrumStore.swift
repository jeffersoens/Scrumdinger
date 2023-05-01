//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by Вячеслав Горбатенко on 30.04.2023.
//

import SwiftUI

@MainActor
final class ScrumStore: ObservableObject {
    
    @Published var scrums: [DailyScrum] = []
    
    private static func fileURL() throws -> URL {
        
        // находит пусть к разделу с файлами. В этом случае это .documentDirectory
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        // создает файл с нужным названием
        .appending(path: "scrums.data")
    }
    
    func load() async throws {
        // В Task указывается <Success, Failure> – что получается при успехе или неудаче.
        let task = Task<[DailyScrum], Error> {
            // Получаем путь к файлу
            let fileURL = try Self.fileURL()
            // Проверяем, что файл существует. Если нет, то даем пустой результат
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            // Если файл существует, то декодируем JSON файл в нужный тип
            let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: data)
            return dailyScrums
        }
        // Поскольку Task – асинхронное действие, используем await, чтобы дождаться его результата. В данном случае value – это результат Task: успех или неудача
        let scrums = try await task.value
        self.scrums = scrums
    }
    
    func save(scrums: [DailyScrum]) async throws {
        let task = Task {
            // Кодируем свойство scrums в JSON формат
            let data = try JSONEncoder().encode(scrums)
            // Находим путь к файлу
            let outfile = try Self.fileURL()
            // Записываем JSON в файл
            try data.write(to: outfile)
        }
        
        // Здесь имя свойсва указывается как _, потому что оно нам больше не понадобится
        _ = try await task.value
    }
}




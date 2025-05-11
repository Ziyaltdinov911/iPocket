//
//  PostItem.swift
//  iPocket
//
//  Created by KAMA . on 03.05.2025.
//

import Foundation

class PostDate: Identifiable {
    let id = UUID().uuidString
    let items: [PostItem]
    let date: Date
    
    init(items: [PostItem], date: Date) {
        self.items = items
        self.date = date
    }
    
    static func getMockData() -> [PostDate] {
        return [
            PostDate(
                items: [
                    PostItem(
                        photos: ["img1", "img2"],
                        comments: nil,
                        tags: ["Дом", "Nature"],
                    ),
                    PostItem(
                        photos: ["img3"],
                        comments: nil,
                        tags: ["Nature", "Home", "Education", "Work", "Game"],

                    )
                ],
                date: Date()
            ),
            PostDate(
                items: [
                    PostItem(
                        photos: ["img2"],
                        comments: nil,
                        tags: ["Nature", "Home", "Education", "Work", "Game"],
                    ),
                    PostItem(
                        photos: ["img3"],
                        comments: nil,
                        tags: ["Nature", "Home", "Education", "Work", "Game"],
                    )
                ],
                date: Date().addingTimeInterval(-86400) // 1 день назад
            ),
            PostDate(
                items: [
                    PostItem(
                        photos: ["img2", "img3"],
                        comments: nil,
                        tags: ["Nature", "Home", "Education", "Work", "Game"],
                    ),
                    PostItem(
                        photos: ["img3"],
                        comments: nil,
                        tags: ["Nature", "Home", "Education", "Work", "Game"],

                    )
                ],
                date: Date().addingTimeInterval(-172800) // 2 дня назад
            )
        ]
    }

}

class PostItem: Identifiable {
    let id = UUID().uuidString
    let photos: [String]
    let comments: [Comment]?
    let tags: [String]?
    let description: String?

        self.photos = photos
        self.comments = comments
        self.tags = tags
        self.description = description
    
}

class Comment: Identifiable {
    let id = UUID().uuidString
    let date: Date
    let comment: String
    
    init(date: Date, comment: String) {
        self.date = date
        self.comment = comment
    }
}

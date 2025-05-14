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
                        description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
                        date: Date()
                    ),
                    PostItem(
                        photos: ["img3"],
                        comments: nil,
                        tags: ["Nature", "Home", "Education", "Work", "Game"],
                        description: "Tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
                        date: Date()
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
                        description: "Labore et dolore magna aliqua. Ut enim ad veniam",
                        date: Date()
                    ),
                    PostItem(
                        photos: ["img3"],
                        comments: nil,
                        tags: ["Nature", "Home", "Education", "Work", "Game"],
                        description: "Ut enim ad minim veniam tempor incididunt ut labore et dolore magna aliqua",
                        date: Date()
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
                        description: "Labore et dolore magna aliqua",
                        date: Date()
                    ),
                    PostItem(
                        photos: ["img3"],
                        comments: nil,
                        tags: ["Nature", "Home", "Education", "Work", "Game"],
                        description: "Labore et veniam tempor incididunt ut labore et dolore magna aliqua",
                        date: Date()
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
    let isFavorite: Bool
    let date: Date
    
    init(photos: [String], comments: [Comment]?, tags: [String]?, description: String?, isFavorite: Bool = false, date: Date) {
        self.photos = photos
        self.comments = comments
        self.tags = tags
        self.description = description
        self.date = date
        self.isFavorite = isFavorite
    }
    
    static func getMockItem() -> [PostItem] {
        return [
            PostItem(
                photos: ["img1", "img2"],
                comments: nil,
                tags: ["Дом", "Nature"],
                description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
                isFavorite: true,
                date: Date()
            ),
            PostItem(
                photos: ["img2", "img3"],
                comments: nil,
                tags: ["Дом", "Nature"],
                description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
                isFavorite: true,
                date: Date()
            ),
            PostItem(
                photos: ["img3", "img1"],
                comments: nil,
                tags: ["Дом", "Nature"],
                description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
                isFavorite: true,
                date: Date()
            ),
            PostItem(
                photos: ["img1", "img3"],
                comments: nil,
                tags: ["Дом", "Nature"],
                description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
                isFavorite: true,
                date: Date().addingTimeInterval(-86400)
            ),
            PostItem(
                photos: ["img2", "img3"],
                comments: nil,
                tags: ["Дом", "Nature"],
                description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
                isFavorite: true,
                date: Date().addingTimeInterval(-86400)
            ),
            PostItem(
                photos: ["img3", "img1"],
                comments: nil,
                tags: ["Дом", "Nature"],
                description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
                isFavorite: true,
                date: Date().addingTimeInterval(-86400)
            ),
            PostItem(
                photos: ["img2", "img1"],
                comments: nil,
                tags: ["Дом", "Nature"],
                description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
                isFavorite: true,
                date: Date().addingTimeInterval(-172800)
            ),
            PostItem(
                photos: ["img3", "img1"],
                comments: nil,
                tags: ["Дом", "Nature"],
                description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
                isFavorite: true,
                date: Date().addingTimeInterval(-172800)
            )
        ]
    }

    
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

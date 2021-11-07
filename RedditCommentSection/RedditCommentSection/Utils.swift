//
//  Utils.swift
//  RedditCommentSection
//
//  Created by Alked Ejupi on 04/11/2021.
//

import Foundation
import SwiftUI


extension Bundle {
    func decode<T: Codable>(type: T.Type, from file: String) -> T {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("No file named: \(file) in Bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load")
        }
        
        let decoder = JSONDecoder()
        
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundel, missing file '\(key.stringValue)' - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Type mismatch context \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(type) - context: \(context.debugDescription)")
        }  catch DecodingError.dataCorrupted(_) {
            fatalError("Wrong JSON")
        } catch {
            fatalError("Filed to decode \(file) from bundle")
        }
    }
}


struct NoButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}

struct ListItem<Content: View>: View {
        let content: () -> Content
    
        var body: some View {
                List {
                    self.content()
                }
                .listStyle(PlainListStyle())
                .buttonStyle(NoButtonStyle())
            
        }
    }



extension String {
    func toDate() -> Date {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: self) ?? Date()

    }
}

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))

        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month =  4 * week
        let year =  12 * month


        if secondsAgo < 50 {
            return "just now"
        } else if secondsAgo < minute {
            return "\(secondsAgo) second\(secondsAgo == 1 ? "" : "s") ago"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) minute\(secondsAgo / minute == 1 ? "" : "s") ago"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hour\(secondsAgo / hour == 1 ? "" : "s") ago"
        } else if secondsAgo < week {
            return "\(secondsAgo / day) day\(secondsAgo / day == 1 ? "" : "s") ago"
        } else if secondsAgo < month{
            return "\(secondsAgo / week) week\(secondsAgo / week == 1 ? "" : "s") ago"
        } else if secondsAgo<year{
            return "\(secondsAgo / month) month\(secondsAgo / month == 1 ? "" : "s") ago"
        }
        return "\(secondsAgo / year) year\(secondsAgo / year == 1 ? "" : "s") ago"
    }
}

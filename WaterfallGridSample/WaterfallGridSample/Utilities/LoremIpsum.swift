//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import Foundation

struct LoremIpsum {
    
    private static let title = [
        "Lorem ipsum dolor sit amet",
        "consectetur adipiscing elit",
        "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"
    ]
    
    private static let sentences = [
        "Cras semper auctor neque vitae.",
        "Pharetra diam sit amet nisl suscipit.",
        "Sodales neque sodales ut etiam.",
        "Mattis enim ut tellus elementum sagittis.",
        "Sed elementum tempus egestas sed sed risus pretium.",
        "Ut eu sem integer vitae justo eget.",
        "Aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque habitant morbi.",
        "Sit amet facilisis magna etiam tempor orci eu lobortis elementum.",
        "Nisl pretium fusce id velit ut tortor pretium viverra suspendisse.",
        "Viverra nam libero justo laoreet sit amet cursus sit."
    ]
    
    public static func randomTitle() -> String {
        title[0...Int.random(in: 0..<title.count)].joined(separator: ", ")
    }
    
    public static func randomSentences() -> String {
        sentences.shuffled()[0...Int.random(in: 0..<sentences.count)].joined(separator: " ")
    }
    
}

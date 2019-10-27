//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import Foundation
import SwiftUI

extension View {
    
    public func customNavigationBarTitle(_ title: Text, displayMode: NavigationBarItem.TitleDisplayMode) -> some View {
        #if os(tvOS)
        return self
        #else
        return self
            .navigationBarTitle(title, displayMode: displayMode)
        #endif
    }
    
    public func customNavigationBarItems<L, T>(leading: L, trailing: T) -> some View where L : View, T : View {
        #if os(tvOS)
        return VStack(alignment: .leading) {
            HStack() {
                leading
                Spacer()
                trailing
            }
            self
        }
        #else
        return self
            .navigationBarItems(leading: leading, trailing: trailing)
        #endif
    }
    
}

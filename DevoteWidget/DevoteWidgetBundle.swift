//
//  DevoteWidgetBundle.swift
//  DevoteWidget
//
//  Created by Labhesh Dudi on 30/12/25.
//

import WidgetKit
import SwiftUI

@main
struct DevoteWidgetBundle: WidgetBundle {
    var body: some Widget {
        DevoteWidget()
        DevoteWidgetControl()
        DevoteWidgetLiveActivity()
    }
}

import WidgetKit
import SwiftUI
import ActivityKit

@available(iOS 16.2, *)
@main
struct AppBundle: WidgetBundle {
    var body: some Widget {
        LiveActivityWidget()
    }
}

@available(iOS 16.2, *)
struct LiveActivityWidget: Widget {
    let kind: String = "LiveActivityWidget"
        
        var body: some WidgetConfiguration {
            ActivityConfiguration(for: ActivityAttribute.self) { context in
                Text("Lock Screen value: \(context.state.satellites)")
                    .padding()
            } dynamicIsland: { context in
            return DynamicIsland {
                let satellites = context.state.satellites
                DynamicIslandExpandedRegion(.leading) { dynamicIslandExpandedLeadingView(count: satellites) }
                DynamicIslandExpandedRegion(.trailing) { dynamicIslandExpandedTrailingView(count: satellites) }
                DynamicIslandExpandedRegion(.center) {dynamicIslandExpandedCenterView(count: satellites) }
            } compactLeading: {
                compactLeadingView(count: context.state.satellites)
                    .padding(1)
            } compactTrailing: {
                compactTrailingView(count: context.state.satellites)
                    .padding(1)
            } minimal: {
                minimalView(count: context.state.satellites)
            }
            .keylineTint(.white)
        }
    }
}





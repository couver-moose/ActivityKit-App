//
//  TimerWidget.swift
//  TimerWidget
//
//  Created by Dario Daßler on 30.10.24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TimerActivityView : View {
    
    let context: ActivityViewContext<TimerAttributes>
    
    var body: some View {
        HStack {
            if(context.isStale) {
                Image(systemName: "bell.fill")
                Text("Timer Ended")
                    .font(.title)
            } else {
                Image(systemName: "timer.circle")
                Text(context.attributes.timerName)
                    .font(.headline)
                
            
                Text(context.state.endTime, style: .timer)
                
            }
        }
        .padding()
    }
}

struct TimerDynamicIslandCountdownView : View {
    
    let context: ActivityViewContext<TimerAttributes>
    
    var body: some View {
        VStack {
            if (!context.isStale) {
                Text(context.state.endTime, style: .timer)
            } else {
                Text("Ended")
            }
            
        }
        .padding(.horizontal)
    }
}

struct TimerDynamicIslandNameView : View {
    
    let context: ActivityViewContext<TimerAttributes>
    
    var body: some View {
        VStack {
            if(context.isStale) {
                Text("Timer Ended")
                    .font(.title)
            } else {
                Text(context.attributes.timerName)
                    .font(.headline)
            }
        }
        .padding(.horizontal)
    }
}

struct TimerDynamicIslandIconView : View {
    
    let context: ActivityViewContext<TimerAttributes>
    
    var body: some View {
        if (!context.isStale) {
            Image(systemName: "timer.circle")
                .padding()
        } else {
            Image(systemName: "bell.fill")
                .padding()
        }
    }
}

struct TimerWidget: Widget {
    let kind: String = "TimerWidget"

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
            TimerActivityView(context: context)
        } dynamicIsland: { context in
            // Leere Ansichten für Dynamic Island konfigurieren
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    TimerActivityView(context: context)
                }
            } compactLeading: {
                TimerDynamicIslandIconView(context: context)
            } compactTrailing: {
                TimerDynamicIslandCountdownView(context: context)
            } minimal: {
                TimerDynamicIslandIconView(context: context)
            }
        }
    }
}


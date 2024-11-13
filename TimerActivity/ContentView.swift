//
//  ContentView.swift
//  TimerActivity
//
//  Created by Dario Daßler on 30.10.24.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    
    @State private var activity: Activity<TimerAttributes>? = nil
    @State private var active : Bool = false
    @State private var attributes : TimerAttributes = TimerAttributes(startTime: Date(), timerName: "Timer")
    @State private var state : TimerAttributes.TimerStatus?
    
    var body: some View {
        VStack (spacing: 16) {
            if (active) {
                Text(attributes.timerName)
                    .font(.headline)
                if (state != nil) {
                    Text(timerInterval: attributes.startTime...state!.endTime)
                }
                
            }
            Spacer()
            Button("Start") {
                StartActivity()
            }.disabled(active)
            
            Button("Stop") {
                StopActivity()
            }.disabled(!active)
            Spacer()
        }
        .padding()
        .buttonStyle(.bordered)
        .controlSize(.large)
    }
    
    func StartActivity() {
        attributes = TimerAttributes(startTime: Date(), timerName: "Timer")
        let date = Date().addingTimeInterval(130)
        state = TimerAttributes.TimerStatus(endTime: date)
        
        
        activity = try? Activity<TimerAttributes>.request(attributes: attributes, content: .init(state: state!, staleDate: date), pushType: nil)
        active.toggle()
    }
    
    func StopActivity() {
        let state = TimerAttributes.TimerStatus(endTime: .now)
        
        Task {
            await activity?.end(.init(state: state, staleDate: nil), dismissalPolicy: .immediate)
            active.toggle()
        }
    }
    
    
}

#Preview {
    ContentView()
}

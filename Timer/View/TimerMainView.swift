//
//  TimerMainView.swift
//  Timer
//
//  Created by LianHui Jiang on 11/12/2023.
//

import SwiftUI

enum TimerType {
    case timer(initialValue: Int, duration: Int, action: TimerAction)
}

enum TimerAction {
    case opacity
    case volume
    case none
}


struct TimerMainView: View {
    
    // MARK: - PROPERTIES
    @State private var selectedTimer: TimerType?
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TimerGradientButton(label: "Timer A", timerType: .timer(initialValue: 0, duration: 60, action: .opacity), colors: [.purple,.blue])
                TimerGradientButton(label: "Timer B", timerType: .timer(initialValue: 0, duration: 90, action: .volume),colors: [Color.red, Color.orange])
                TimerGradientButton(label: "Timer C", timerType: .timer(initialValue: 0, duration: 120, action: .none),colors: [Color.green, Color.blue])
            }
            .padding()
        }
    }
}

#Preview {
    TimerMainView()
}

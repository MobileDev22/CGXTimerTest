//
//  TimerGradientButton.swift
//  Timer
//
//  Created by LianHui Jiang on 11/12/2023.
//

import SwiftUI

struct TimerGradientButton: View {
    
    // MARK: - PROPERTIES
    let label: String
    let timerType: TimerType
    let colors: [Color]
    @State var percentage: Int = 0
    
    // MARK: - BODY
    var body: some View {
        NavigationLink(destination: DetailView(timerType: timerType, colors: colors, timerValue: $percentage)) {
                Text("\(label) \(percentage > 0 ? "\(percentage)%" : "")")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: colors),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(15)
                    .padding()
            }
            .isDetailLink(false)
    }
}

#Preview {
    TimerGradientButton(label: "Timer", timerType: .timer(initialValue: 0, duration: 60, action: .opacity), colors: [.blue, .purple])
}

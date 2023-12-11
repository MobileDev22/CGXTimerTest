//
//  DetailView.swift
//  Timer
//
//  Created by LianHui Jiang on 11/12/2023.
//

import SwiftUI
import MediaPlayer

struct DetailView: View {
    
    // MARK: - PROPERTIES
    var timerType: TimerType
    var colors : [Color]
    var volumeView : MPVolumeView = MPVolumeView()
    @State private var timer: Timer?
    @Binding var timerValue : Int
    @State private var isTimerRunning = false
    
    
    // MARK: - GETTERS
    var duration: Double {
        switch timerType {
        case .timer(_ , let duration, _):
            let durationRemaining = Double(duration) / 100.0
            return durationRemaining
        }
    }
    
    var action: TimerAction {
        switch timerType {
        case .timer(_ , _ , let action):
            return action
        }
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea()
            
            VStack (spacing:30) {
                Button {
                    self.toggleTimer()
                } label: {
                    Text(isTimerRunning ? "Pause" : "Start")
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
                .padding()
                Text("\(timerValue)%")
                    .font(.title)
                    .foregroundStyle(.blue)
            }
            .onDisappear() {
                pauseTimer()
            }
        }
    }
}

// MARK: - TIMER HELPER
extension DetailView {
    func toggleTimer() {
          isTimerRunning.toggle()
          if isTimerRunning {
              if timerValue >= 100 {
                  timerValue = 0
              }
              startTimer()
          } else {
              pauseTimer()
          }
      }

      func startTimer() {
          timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(duration), repeats: true) { timer in
              if timerValue < 100 {
                  self.timerValue += 1
                  switch action {
                  case .volume:
                      self.changeSystemVolume()
                  case .opacity:
                      self.changeSystemBrightness()
                      break
                  case .none:
                      break
                  }
              } else {
                  isTimerRunning.toggle()
                  self.pauseTimer()
              }
              
          }
          timer?.fire()
      }

      func pauseTimer() {
          timer?.invalidate()
      }
}

// MARK: - BRIGHTNESS HELPER
extension DetailView {
    func changeSystemBrightness()  {
        if timerValue > 20 {
            UIScreen.main.brightness = 1 - (CGFloat(timerValue) / 100)
        }
    }
}

// MARK: - VOLUME HELPER
extension DetailView {
    func changeSystemVolume() {
        volumeView.setVolume(value: Float(volumeValue()))
    }
    
    func volumeValue() -> Double {
        let value = Double(timerValue) / 90
        return value > 1.0 ? 1.0 : value
    }
}

#Preview {
    return DetailView(timerType: .timer(initialValue: 0, duration: 60, action: .opacity), colors: [.blue, .purple], timerValue: .constant(0))
}

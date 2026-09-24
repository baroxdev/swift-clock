//
//  CreateAlarmView.swift
//  Clocks
//
//  Created by admin on 23/9/26.
//

import SwiftUI

enum Weekday: Int, CaseIterable, Identifiable {
    case monday = 1, tuesday, wednesday, thursday, friday, saturday, sunday
    
    var id: Int { rawValue }
    
    
    var name: String {
        switch self {
        case .monday:    return "Monday"
        case .tuesday:   return "Tuesday"
        case .wednesday: return "Wednesday"
        case .thursday:  return "Thursday"
        case .friday:    return "Friday"
        case .saturday:  return "Saturday"
        case .sunday:    return "Sunday"
        }
    }

    var initial: String { String(name.prefix(1)) }   // M T W T F S S
    var abbreviation: String { String(name.prefix(3)) }  // Mon, Tue...

}

struct CustomTimeWheel: View {
    @Binding var time: Date
    @State private var hour: Int = 0
    @State private var minute: Int = 0

    private let itemHeight: CGFloat = 40

    var body: some View {
        ZStack {
            // Pill nền cho hàng đang chọn — vẽ tay vì không còn pill có sẵn của DatePicker
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemGray5))
                .frame(height: itemHeight)

            HStack(spacing: 0) {
                Picker("", selection: $hour) {
                    ForEach(0..<24, id: \.self) { h in
                        Text(String(format: "%02d", h))
                            .font(.system(size: 32))
                            .tag(h)
                    }
                }
                .pickerStyle(.wheel)
                .frame(maxWidth: .infinity)

                Picker("", selection: $minute) {
                    ForEach(0..<60, id: \.self) { m in
                        Text(String(format: "%02d", m))
                            .font(.system(size: 32))
                            .tag(m)
                    }
                }
                .pickerStyle(.wheel)
                .frame(maxWidth: .infinity)
            }
        }
        .frame(height: 180)
        .onAppear { syncFromTime() }
        .onChange(of: hour) { _, _ in updateTime() }
        .onChange(of: minute) { _, _ in updateTime() }
    }

    private func syncFromTime() {
        let comps = Calendar.current.dateComponents([.hour, .minute], from: time)
        hour = comps.hour ?? 0
        minute = comps.minute ?? 0
    }

    private func updateTime() {
        var comps = Calendar.current.dateComponents([.year, .month, .day], from: time)
        comps.hour = hour
        comps.minute = minute
        time = Calendar.current.date(from: comps) ?? time
    }
}

struct CreateAlarmView: View {
    @State private var draft = Alarm(name: "", isEnabled: true)
    
    private var repeatSummary: String {
        let days = draft.repeatDays
           if days.isEmpty {
               return "Never"
           } else if days.count == 7 {
               return "Every day"
           } else if days == Set([.monday, .tuesday, .wednesday, .thursday, .friday]) {
               return "Weekdays"
           } else if days == Set([.saturday, .sunday]) {
               return "Weekends"
           } else {
               return Weekday.allCases
                   .filter { days.contains($0) }
                   .map { $0.abbreviation }
                   .joined(separator: ", ")
           }
    }
    
    private func toggle(_ day: Weekday) {
        if draft.repeatDays.contains(day) {
            draft.repeatDays.remove(day)
        } else {
            draft.repeatDays.insert(day)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                 List {
                     Section {
                         DatePicker("", selection: $draft.time, displayedComponents: .hourAndMinute)
                             .datePickerStyle(.wheel)
                             .labelsHidden()
                             .frame(maxWidth: .infinity)
                         HStack {
                             Text("Repeat")
                             Spacer()
                             Text(repeatSummary)
                                        .foregroundStyle(.secondary)
                         }
                         HStack (spacing: 8){
                                 ForEach(Weekday.allCases) { day in
                                     Button {
                                         toggle(day)
                                     } label: {
                                         Text(day.initial)
                                             .foregroundStyle(.white)
                                             .frame(width: 36, height: 36)
                                             .background(Circle().fill(draft.repeatDays.contains(day) ? Color.orange : Color(.systemGray5)))
                                     }
                                     .buttonStyle(.plain)
                                     .frame(maxWidth: .infinity)
                                 }
                         }
                     }
                     
                     Section {
                         HStack {
                             Text("Label")
                             Spacer()
                             TextField("Alarm", text: $draft.name)
                                 .multilineTextAlignment(.trailing)
                         }
                         HStack {
                             Text("Sound")
                             Spacer()
                             NavigationLink {} label: {
                                 Text("Radar")
                             }
                         }
                         HStack {
                             Toggle (isOn: $draft.isEnabled) {
                                 Text("Snooze")
                             }
                         }
                         HStack {
                             Text("Snooze Duration")
                             Spacer()
                             Text("9 min")
                         }
                     }
                 }.listStyle(.insetGrouped)
            }
            .scrollEdgeEffectStyle(.hard, for: .top)
            .contentMargins(.top, 18, for: .scrollContent)
            .navigationTitle("Add Alarm")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.primary)
                    }
                    .buttonStyle(.bordered)
                    .clipShape(Capsule())
                }
                
                ToolbarSpacer(.fixed, placement: .topBarTrailing)
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button (action: {
                    }) {
                        Image(systemName: "checkmark")
                    }
                    .buttonStyle(.glassProminent)
                    .tint(.orange)
                    .clipShape(Circle())
                }
            }
        }
      
        
    }
}

#Preview() {
    CreateAlarmView()
}

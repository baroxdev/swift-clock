//
//  ContentView.swift
//  Clocks
//
//  Created by admin on 17/9/26.
//

import SwiftUI


struct ContentView: View {
    @State private var alarmData: [AlarmCategory] = [
        AlarmCategory(title: "Sleep | Wake Up", alarms: [
        ]),
        AlarmCategory(title: "Other", alarms: [
            Alarm(name: "02:30", isEnabled: false),
            Alarm(name: "03:30", isEnabled: true),
            Alarm(name: "04:30", isEnabled: false),
            Alarm(name: "05:30", isEnabled: true),
            Alarm(name: "06:30", isEnabled: false),
            Alarm(name: "07:30", isEnabled: false),
            Alarm(name: "08:30", isEnabled: false),
            Alarm(name: "09:30", isEnabled: false),
            Alarm(name: "10:30", isEnabled: false),
        ])
    ]
    
    @State private var showingAddAlarm = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($alarmData) { $category in
                    Section {
                        if category.alarms.isEmpty {
                            HStack {
                                Text("No Alarm")
                                    .font(.system(size: 40, weight: .light))
                                    .foregroundStyle(.secondary)
                                    .padding(.vertical, 16)
                                Spacer()
                                Button{} label: {
                                    Text("CHANGE")
                                        .font(.system(size: 14))
                                }
                                    .buttonStyle(.bordered)
                                    .buttonBorderShape(.capsule)
                                    .tint(.orange)
                                    .fontWeight(.semibold)
                            }
                            .listRowSeparator(.visible, edges: .top)
                        } else {
                            ForEach($category.alarms) { $alarm in
                                    Toggle (isOn: $alarm.isEnabled) {
                                        Text(alarm.name)
                                            .font(.system(size: 48, weight: .light, design: .rounded))
                                            .monospacedDigit()
                                            .tracking(-2)
                                            .foregroundStyle(.secondary)
                                        Text("Alarm")
                                            .font(.system(size: 16, weight: .light))
                                            .foregroundStyle(.secondary)
                                    }
                                .listRowSeparator(.visible, edges: .top)
                            }
                        }
                        
                    } header: {
                        Label(category.title, systemImage: "bed.double.fill")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .backgroundStyle(.background)
                            .textCase(nil)
                            .frame(maxWidth: .infinity, alignment: .leading)
                                  .padding(.horizontal)
                                  .padding(.vertical, 8)
                                  .listRowInsets(EdgeInsets())
                    }
                }
            }
            .listStyle(.plain)
            .scrollEdgeEffectStyle(.hard, for: .top)
            .contentMargins(.top, 18, for: .scrollContent)
            .navigationTitle("Alarms")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                    } label: {
                        Text("Edit")
                            .foregroundStyle(.orange)
                    }
                    .buttonStyle(.bordered)
                    .clipShape(Capsule())
                }
                
                ToolbarSpacer(.fixed, placement: .topBarTrailing)
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button (action: {
                        showingAddAlarm = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundStyle(.orange)
                    }
                    .buttonStyle(.bordered)
                    .clipShape(Circle())
                }
            }
            .sheet(isPresented: $showingAddAlarm) {
                CreateAlarmView()
            }
        }
    }
}

#Preview {
    ContentView()
}

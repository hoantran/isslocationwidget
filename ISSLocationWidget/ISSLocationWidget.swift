//
//  ISSLocationWidget.swift
//  ISSLocationWidget
//
//  Created by Hoan Tran on 12/29/20.
//

import WidgetKit
import SwiftUI
import Intents

struct LocationModel: TimelineEntry {
    var date: Date
    var currentTime: String
}

//struct DataProvider: IntentTimelineProvider {
struct DataProvider: TimelineProvider {
    func placeholder(in context: Context) -> LocationModel {
        LocationModel(date: Date(), currentTime: "")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (LocationModel) -> Void) {
//    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (LocationModel) -> ()) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        let time = formatter.string(from: date)
        let entryData = LocationModel(date: date, currentTime: time)
        completion(entryData)
    }
  
    func getTimeline(in context: Context, completion: @escaping (Timeline<LocationModel>) -> Void) {
//    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        let time = formatter.string(from: date)
        let entryData = LocationModel(date: date, currentTime: time)
        
//        let refresh = Calendar.current.date(byAdding: .second, value: 5, to: date)!
        
        let timeLine = Timeline(entries: [entryData], policy: .atEnd)
        print("Updated")
        completion(timeLine)
        
        
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
    }
    
//
//
//
//    func placeholder(in context: Context) -> LocationModel {
//        return LocationModel(date: Date(), currentTime: "")
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (LocationModel) -> Void) {
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "hh:mm:ss a"
//        let time = formatter.string(from: date)
//        let entryData = LocationModel(date: date, currentTime: time)
//        completion(entryData)
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<LocationModel>) -> Void) {
//    }
}

struct ISSLocationWidgetEntryView : View {
    var entry: DataProvider.Entry
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Time")
                Spacer()
            }
                .padding(.all)
                .background(Color.yellow)
            Spacer()
            Text(entry.date, style: .time)
                .padding(.horizontal, 15)
                .foregroundColor(Color.white)
            Spacer()
        }
        .background(Color.black)
    }
}

@main
struct ISSLocationWidget: Widget {
    let kind: String = "com.bluepego.ISSLocation.ISSLocationWidget"

//    var body: some WidgetConfiguration {
//        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: DataProvider()) { entry in
//            ISSLocationWidgetEntryView(entry: entry)
//        }
//        .configurationDisplayName("ISSLocationWidget")
//        .description("Shows the current coordinate of International Space Station.")
//    }
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: DataProvider()
            ) { entry in
            ISSLocationWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("ISSLocationWidget")
        .description("Shows the current coordinate of International Space Station")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct ISSLocationWidget_Previews: PreviewProvider {
    static var previews: some View {
        ISSLocationWidgetEntryView(entry: LocationModel(date: Date(), currentTime: "Curent Time"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


/*
struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        
        print("updated")
        
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct ISSLocationWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

@main
struct ISSLocationWidget: Widget {
    let kind: String = "ISSLocationWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            ISSLocationWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct ISSLocationWidget_Previews: PreviewProvider {
    static var previews: some View {
        ISSLocationWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

*/
 

//
//  LocationWidget.swift
//  LocationWidget
//
//  Created by Hoan Tran on 12/29/20.
//

import WidgetKit
import SwiftUI

struct LocationEntry: TimelineEntry {
    var date: Date
    var currentTime: String
    let latitude: Double
    let longitude: Double
}

struct Provider: TimelineProvider {
    @AppStorage("POSITION", store: UserDefaults(suiteName: "group.com.bluepego.ISSLocation")) var positionData = Data()
    
    func placeholder(in context: Context) -> LocationEntry {
        return LocationEntry(date: Date(), currentTime: "current time", latitude: 3.0, longitude: 10.0)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (LocationEntry) -> ()) {
        let entry = LocationEntry(date: Date(), currentTime: "current time", latitude: 5.0, longitude: 10.0)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<LocationEntry>) -> ()) {
        let locationEntry = decodeLocation()
        let refresh = Calendar.current.date(byAdding: .second, value: 10, to: locationEntry.date)!
        let timeLine = Timeline(entries: [locationEntry.entry], policy: .after(refresh))
//        #if DEBUG
            NSLog("%@", "Updated")
//        #endif
        completion(timeLine)
    }
    
    func decodeLocation() -> (entry: LocationEntry, date: Date) {
        var entry: LocationEntry
        var date: Date
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"

        if let location = try? JSONDecoder().decode(ISSPosition.self, from: positionData) {
            date = Date(timeIntervalSince1970: location.timestamp)
            let time = formatter.string(from: date)
            entry = LocationEntry(date: date, currentTime: time, latitude:location.latitude, longitude:location.longitude)
        } else {
            date = Date()
            let time = formatter.string(from: date)
            entry = LocationEntry(date: date, currentTime: time, latitude:5, longitude:19)
        }
        return (entry, date)
    }
}

struct LocationWidgetEntryView : View {
    var entry: Provider.Entry
    
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
//            Text(entry.date, style: .time)
            
            VStack {
                Text(entry.currentTime)
                Text("[\(entry.latitude), \(entry.longitude)]")
            }
            .padding(.horizontal, 15)
            .foregroundColor(Color.white)
        Spacer()
        }
        .background(Color.black)
    }
}

@main
struct LocationWidget: Widget {
    let kind: String = "com.bluepego.ISSLocation.ISSLocationWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            LocationWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("ISSLocationWidget")
        .description("Shows the current coordinate of International Space Station")
        .supportedFamilies([.systemSmall])
    }
}

struct LocationWidget_Previews: PreviewProvider {
    static var previews: some View {
        LocationWidgetEntryView(entry: LocationEntry(date: Date(), currentTime: "Current Time", latitude: 9.0, longitude: 10.0))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


/*
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct LocationWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

@main
struct LocationWidget: Widget {
    let kind: String = "LocationWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            LocationWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct LocationWidget_Previews: PreviewProvider {
    static var previews: some View {
        LocationWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

 */

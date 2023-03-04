//
//  DataTraffic2Widget.swift
//  DataTraffic2Widget
//
//  Created by 丹羽雄一朗 on 2022/05/27.
//

import WidgetKit
import SwiftUI
import Intents

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
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct DataTraffic2WidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text(entry.date, style: .date)
                .padding()
            Text("許容通信量: \(dataTrafficLimitFromUserdefaults) GB")
        }
    }
    
    var dataTrafficLimitFromUserdefaults: Int {
        UserDefaults(suiteName: "group.com.Niwa.DataTraffic2")!.integer(forKey: "dataTrafficLimitKey")
    }
}

@main
struct DataTraffic2Widget: Widget {
    let kind: String = "DataTraffic2Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            DataTraffic2WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("許容通信量")
        .description("今日までにどのくらいの通信量が許容されるのかが分かります。")
        .supportedFamilies([.systemSmall])
    }
}

struct DataTraffic2Widget_Previews: PreviewProvider {
    static var previews: some View {
        DataTraffic2WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

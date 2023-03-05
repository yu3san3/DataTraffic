//
//  ContentView.swift
//  DataTraffic2
//
//  Created by 丹羽雄一朗 on 2022/05/24.
//
//  2022/01/23 Alpha 1.0.0(1)
//       01/24 Alpha 1.0.1(2)
//       02/07 Alpha 1.0.1(3)
//       02/07 Alpha 1.0.2(4)
//       04/17 Alpha 1.1.0(5)
//       05/24 Alpha 2.0.0(6)
//       05/26 Alpha 2.1.0(7)
//       05/30 Alpha 2.1.1(8)
//       06/11 Alpha 2.1.2(9)
//       10/07 Alpha 2.1.2(10)
//          Widgetの実装に失敗。dataTrafficLimitをDataTraffic2Widget.swiftへ渡す方法が不明であったため。
//

import SwiftUI

//バージョン情報
let globalVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
//ビルド情報
let globalBuildNum = Bundle.main.infoDictionary!["CFBundleVersion"] as! String

//メインビュー
struct ContentView: View {
    
    //インスタンスを作成
    let dataTraffic = DataTraffic()
    @ObservedObject var observedDate = ObservedDate()
    
    //画面遷移フラグ
    @State private var isShowingConfig: Bool = false
    
    var body: some View {
        NavigationView {
            //日付と限界通信量を表示
            VStack {
                Text(observedDate.current)
                    .padding()
                Text("許容通信量")
                PieChartView(progress: dataTraffic.limit/dataTraffic.contracted)
                    .frame(width: 180.0, height: 180.0)
                    .padding(32.0)
            }
            .onAppear() {
                dataTraffic.calculateLimit()
            }
            //ツールバー
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button(action: {
                            isShowingConfig = true
                        }) {
                            Image(systemName: "gearshape")
                        }
                        //画面を遷移
                        .sheet(
                            isPresented: $isShowingConfig,
                            onDismiss: {
//                                dataTraffic.objectWillChange.send() //値の変化を通知する
                            }
                        ) {
                            ConfigView()
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("データ通信量")
        }
    }
}

//日付の変更で更新
class ObservedDate: ObservableObject {
    
    @Published var currentDate: Date = Date()

    var current: String {
        Self.dateFormatter.string(from: currentDate)
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_jp")
        formatter.dateFormat = "y年M月d日(E)"
        return formatter
    }()
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(dayDidChange),
            name: .NSCalendarDayChanged,
            object: nil
        )
    }
    
    @objc
    func dayDidChange() {
        currentDate = Date()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
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
    
    //DataTrafficクラスのインスタンスを共有する
    @EnvironmentObject var dataTraffic: DataTraffic
    
    @ObservedObject var observedDate = ObservedDate()
    
    //画面遷移フラグ
    @State private var isShowingConfig: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Spacer()
                    VStack {
                        Text("\(observedDate.current) 現在")
                            .font(.caption)
                            .padding()
                        PieChartView(progress: dataTraffic.limit/dataTraffic.contracted)
                            .frame(width: 210, height: 210)
                            .padding(.bottom, 27)
                    }
                    Spacer()
                }
                .onAppear() {
                    dataTraffic.calculateLimit()
                }
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
                        .sheet(isPresented: $isShowingConfig) {
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

//変更を監視された日付を提供する
class ObservedDate: ObservableObject {
    
    //日付が変わると自動で値が入れ替わる
    @Published var currentDate: Date = Date()

    //DateFormatterを定義
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_jp")
        formatter.dateFormat = "y年M月d日(E)"
        return formatter
    }()
    
    //フォーマットされた日付を提供
    var current: String {
        Self.dateFormatter.string(from: currentDate)
    }
    
    init() {
        //日付の変更を監視するNotificationCenterを設定
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(dayDidChange),
            name: .NSCalendarDayChanged,
            object: nil
        )
    }
    
    //日付の変更で実行される
    @objc
    func dayDidChange() {
        currentDate = Date()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataTraffic())
    }
}

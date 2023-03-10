//
//  DataTraffic.swift
//  DataTraffic2
//
//  Created by 丹羽雄一朗 on 2023/02/13.
//

import SwiftUI

class DataTraffic: ObservableObject {
    
    @AppStorage("contractedDataTrafficKey") var contracted: Double = 20 //契約通信量
    @AppStorage("dataTrafficLimitKey") var limit: Double = 0 //許容通信量
    
    //限界通信量を計算する関数
    func calculateLimit() {
        
        let dF = DateFormatter()

        let date = Date()
        let calendar = Calendar.current
        
        //月初を取得
        let comps = calendar.dateComponents([.year, .month], from: date)
        let firstday = calendar.date(from: comps)!
        //月末を取得
        let add = DateComponents(month: 1, day: -1)
        let lastday = calendar.date(byAdding: add, to: firstday)!
        
        //フォーマット形式を指定(日付のみ取得)
        dF.dateFormat = "dd"
        //月初・月末の日付を取得
        let todayDate = Double(dF.string(from: date))!
        let lastDate = Double(dF.string(from: lastday))!
        
        //計算
        let dataTrafficLimit = (contracted/lastDate)*todayDate
        
        limit = dataTrafficLimit
    }
}

//
//  PieChartView.swift
//  DataTraffic2
//
//  Created by 丹羽雄一朗 on 2023/03/06.
//

import SwiftUI

struct PieChartView: View {
    var progress: CGFloat
    
    var dataTraffic = DataTraffic()
    
    var body: some View {
        ZStack {
            // 背景の円
            Circle()
            // ボーダーラインを描画するように指定
                .stroke(lineWidth: 24.0)
                .opacity(0.3)
                .foregroundColor(.blue)
            
            // 進捗を示す円
            Circle()
            // 始点/終点を指定して円を描画する
            // 始点/終点には0.0-1.0の範囲に正規化した値を指定する
                .trim(from: 0.0, to: min(progress, 1.0))
            // 線の端の形状などを指定
                .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .round, lineJoin: .round))
                .foregroundColor(.blue)
            // デフォルトの原点は時計の12時の位置ではないので回転させる
                .rotationEffect(Angle(degrees: 270.0))
            
            // 進捗率のテキスト
            VStack {
                Text(String(format: "%.2f GB", dataTraffic.limit))
                    .font(.largeTitle)
                    .bold()
                Text(String(format: "%.0f GB", dataTraffic.contracted))
            }
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(progress: 0.3)
            .frame(width: 150.0, height: 150.0)
            .padding(32.0)
    }
}

//
//  ConfigView.swift
//  DataTraffic2
//
//  Created by 丹羽雄一朗 on 2023/02/13.
//

import SwiftUI

//設定ビュー
struct ConfigView: View {
    
    @EnvironmentObject var dataTraffic: DataTraffic
    
    @Environment(\.dismiss) var dismiss
    
    @State private var textFieldContent: String = ""
    @State private var isTapped: Bool = false

    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: ContractedPlanConfigView()) {
                        HStack {
                            Text("契約データ量")
                            Spacer()
                            Text("\(String(format: "%.0f", dataTraffic.contracted)) GB")
                        }
                    }
                } header: {
                    Text("一般")
                }
                Section {
                    HStack {
                        Text("バージョン")
                        Spacer()
                        Text(globalVersion + " (" + globalBuildNum + ")")
                    }
                } header: {
                    Text("このアプリについて")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Text("完了")
                        }
                    }
                }
            }
            .navigationTitle("設定")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//契約プラン設定ビュー
struct ContractedPlanConfigView: View {
    
    //インスタンスを作成
    @EnvironmentObject var dataTraffic: DataTraffic
    
    @FocusState var isInputActive: Bool //フォーカスがあるか確認
    
    @State private var textFieldContent: String = "0"
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("契約データ量")
                    Spacer()
                    TextField("0", text: $textFieldContent)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .frame(width: 100)
                        .focused($isInputActive) //テキストフィールドのフォーカスを設定
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("完了") {
                                    dataTraffic.contracted = Double(textFieldContent)!
                                    dataTraffic.calculateLimit()
                                    isInputActive = false
                                }
                            }
                        }
                        .onAppear() {
                            textFieldContent = String(format: "%.0f", dataTraffic.contracted)
                        }
                    Text("GB")
                }
            } footer: {
                Text("許容量は月末締めで計算されます。")
            }
        }
    }
}

struct Config_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
            .environmentObject(DataTraffic())
        ContractedPlanConfigView()
            .environmentObject(DataTraffic())
    }
}

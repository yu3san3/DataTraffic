//
//  ConfigView.swift
//  DataTraffic2
//
//  Created by 丹羽雄一朗 on 2023/02/13.
//

import SwiftUI

//設定ビュー
struct ConfigView: View {
    
    //インスタンスを作成
    @ObservedObject var dataTraffic = DataTraffic()
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: ContractedDataTrafficConfigView(dataTraffic: dataTraffic)) {
                        HStack {
                            Text("契約データ量")
                            Spacer()
                            Text("\(dataTraffic.contracted) GB")
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

//契約通信量設定ビュー
struct ContractedDataTrafficConfigView: View {
    
    //インスタンスを作成
    @ObservedObject var dataTraffic: DataTraffic
    
    @Environment(\.dismiss) var dismiss
    
    @FocusState var isInputActive: Bool //フォーカスがあるか確認
    
    @State var simpleConfigVar: Int?
    
    var body: some View {
        VStack {
            List(selection: $simpleConfigVar) {
                Section {
                    //                    HStack{
                    Text("3 GB").tag(3)
                    //                        Spacer()
                    //                    }
                    Text("20 GB").tag(20)
                    Text("100 GB").tag(100)
                } header: {
                    Text("簡易設定")
                }
//                                .contentShape(Rectangle())
//                                .onTapGesture {
//                                    print(simpleConfigVar)
//                                    dataTraffic.contracted = String(simpleConfigVar ?? 0)
//                                }
                Section {
                    HStack {
                        Text("契約通信量: ")
                        TextField("0", text: $dataTraffic.contracted)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .frame(width: 100)
                            .focused($isInputActive) //テキストフィールドのフォーカスを設定
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button("完了") {
                                        dataTraffic.calculateLimit()
                                        isInputActive = false
                                    }
                                }
                            }
                    }
                } header: {
                    Text("詳細設定")
                } footer: {
                    Text("許容通信量は月末締めで計算されます。")
                }
            }
            .environment(\.editMode, .constant(.active))
        }
    }
}

struct Config_Previews: PreviewProvider {
    static var previews: some View {
        let dataTraffic = DataTraffic()
        ConfigView()
        ContractedDataTrafficConfigView(dataTraffic: dataTraffic)
    }
}

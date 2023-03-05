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
    @EnvironmentObject var dataTraffic: DataTraffic
    
    @Environment(\.dismiss) var dismiss
    
    @State private var textFieldContent: String = ""
    @State private var isTapped: Bool = false

    var body: some View {
        NavigationView {
            List {
                Section {
//                    HStack {
//                        Text("契約データ量")
//                        Spacer()
//                        Text("\(dataTraffic.contracted) GB")
//                        Image(systemName: "chevron.forward") //Disclosure Indicator(>)
//                            .font(Font.system(.caption).weight(.bold))
//                            .foregroundColor(Color(UIColor.tertiaryLabel))
//                    }
//                    .contentShape(Rectangle())
//                    .onTapGesture {
//                        textFieldContent = String(dataTraffic.contracted)
//                        isTapped = true
//                    }
//                    .alert(
//                        "契約データ量",
//                        isPresented: $isTapped,
//                        actions: {
//                            TextField("0", text: $textFieldContent)
//                                .keyboardType(.numberPad)
//                                .onReceive( //テキストを全選択
//                                    NotificationCenter.default.publisher(
//                                        for: UITextField.textDidBeginEditingNotification
//                                    )
//                                ) { obj in
//                                    if let textField = obj.object as? UITextField {
//                                        textField.selectedTextRange = textField.textRange(
//                                            from: textField.beginningOfDocument,
//                                            to: textField.endOfDocument
//                                        )
//                                    }
//                                }
//                            Button("OK") {
//                                dataTraffic.contracted = Double(textFieldContent) ?? 0
//                            }
//                            Button("キャンセル", role: .cancel) {}
//                        },
//                        message: {
//                            Text("現在の値: \(dataTraffic.contracted)")
//                        }
//                    )
                    NavigationLink(destination: ContractedDataTrafficConfigView()) {
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

//契約通信量設定ビュー
struct ContractedDataTrafficConfigView: View {
    
    //インスタンスを作成
    @EnvironmentObject var dataTraffic: DataTraffic
    
//    @Environment(\.dismiss) var dismiss
    
    @FocusState var isInputActive: Bool //フォーカスがあるか確認
    
    @State private var textFieldContent: String = "0"
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("契約通信量: ")
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
                }
            } header: {
                Text("詳細設定")
            } footer: {
                Text("許容通信量は月末締めで計算されます。")
            }
        }
//        .environment(\.editMode, .constant(.active))
    }
}

struct Config_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
            .environmentObject(DataTraffic())
        ContractedDataTrafficConfigView()
            .environmentObject(DataTraffic())
    }
}

//
//  ContentView.swift
//  MyOkashi
//
//  Created by tsuchiya39 on 2022/03/14.
//

import SwiftUI

struct ContentView: View {
    // OkashiDataを参照する状態変数
    @StateObject var okashiDataList = OkashiData()
    // 入力された文字列を保持する状態変数
    @State var inputText = ""
    // SafariViewの表示有無を管理する変数
    @State var showSafari = false
    
    var body: some View {
        
        VStack {
            // 文字を受け取るTextFieldを表示
            TextField("キーワード", text: $inputText,
                      prompt: Text("キーワードを入力してください"))
                .onSubmit {
                    // Taskは非同期で処理を実行
                    Task {
                        // 入力完了後に検索
                        await okashiDataList.searchOkashi(keyword: inputText)
                    }
                }
                // キーボードの改行を検索に変更
                .submitLabel(.search)
                .padding()
            
            // リストを表示
            List(okashiDataList.okashiList) { okashi in
                // 1つ1つの要素が取り出される
                
                Button(action: {
                    showSafari.toggle()
                }) {
                    // Listの表示内容を生成
                    HStack {
                        AsyncImage(url: okashi.image) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 40)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(okashi.name)
                    } // HStack ... end
                } // Button ... end
                .sheet(isPresented: self.$showSafari, content: {
                    SafariView(url: okashi.link)
                        // 画面下部がセーフエリア外までいっぱいになるように指定
                        .edgesIgnoringSafeArea(.bottom)
                })
                
                
            } // List ... end
        } // VStack ... end
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

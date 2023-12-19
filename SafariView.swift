//
//  SafariView.swift
//  MyOkashi
//
//  Created by 土谷慧太 on 2022/03/15.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    // 表示するホームページのURLを受ける変数
    var url: URL
        
    //表示するViewを生成する時に実行
    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}


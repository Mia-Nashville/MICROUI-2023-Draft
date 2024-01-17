//
//  DailyReportCollectView.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/16/24.
//

import Foundation
import SwiftUI
import Kingfisher

struct DailyReportCollectView: View {
    @ObservedObject var viewmodel: DailyViewModel
    @State private var searchText: String = ""
    @Environment(\.dismiss) var dismiss
    
    var filterDailyReport: [DailySiteModel] {
        guard !searchText.isEmpty else {
            return viewmodel.dailyVM.sorted { $0.reportDate < $1.reportDate }
        }
        return viewmodel.dailyVM.filter { searchreport in
            searchreport.siteActivity.contains(searchText)
        }
    }
    
    private func dailyRowView(daily: DailySiteModel) -> some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                if let imageUrlString = daily.imageUrlString {
                    KFImage(URL(string: imageUrlString))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                }
                VStack {
                    Text("Daily Report: \(daily.reportDate)").textCase(.uppercase)
                        .font(.headline)
                        .fontWeight(.medium)
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewmodel.dailyVM, id: \.self) { reports in
                        NavigationLink(destination: {
                            
                        }, label: {
                            dailyRowView(daily: reports)
                        })}
                    .modifier(lighttabViewModifiers())
                }
            }
            .onAppear {
                viewmodel.fetchDailyReport()
            }
        }
    }
}

struct lighttabViewModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
        
            .padding(10)
            .background(Color("Background 1"))
        // Set backgroundColor of column to light color
            .background(VisualEffectBlur(blurStyle: .systemUltraThinMaterialLight))
            .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(Color.white, lineWidth: 1).blendMode(.overlay))
            .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(.top, 10)
    }
}

struct DailyReportCollectionView_Preview: PreviewProvider {
    static var previews: some View {
        DailyReportCollectView(viewmodel: DailyViewModel(projects: devPreview.mockProjects))
    }
}

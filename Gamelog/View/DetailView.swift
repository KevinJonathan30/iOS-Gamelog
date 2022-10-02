//
//  DetailView.swift
//  Gamelog
//
//  Created by Kevin Jonathan on 29/09/22.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    
    init(id: Int) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(id: id))
    }
    
    var body: some View {
        ScrollView {
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                        .frame(alignment: .center)
                case .fail, .empty:
                    Text("Loading Failed")
                case .loaded:
                    VStack {
                        Header()
                        
                        Content()
                    }
                }
            }
            .navigationTitle("Game Detail")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.getGameDetail()
            }
        }
    }
}

private extension DetailView {
    @ViewBuilder func Header() -> some View {
        AsyncImage(
            url: URL(string: viewModel.game?.backgroundImage ?? ""),
            content: { image in
                image.resizable()
                    .frame(height: 240)
            },
            placeholder: {
                Spacer()
                
                ZStack {
                    ProgressView()
                }.frame(height: 240)
                
                Spacer()
            }
        )
    }
    
    @ViewBuilder func Content() -> some View {
        Group {
            VStack(spacing: 8) {
                Text(viewModel.game?.name ?? "")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text("\(String(viewModel.game?.rating ?? 0))")
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Released on: \(DateUtility.convertToHumanReadableDate(viewModel.game?.released ?? ""))")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .bold()
                
                Text(viewModel.game?.website ?? "")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        guard let url = URL(string: viewModel.game?.website ?? "") else { return }
                        UIApplication.shared.open(url)
                    }
                
                Divider()
                
                Text(viewModel.game?.description?.convertHtmlToString ?? "")
            }
        }
        .padding([.top, .leading, .trailing])
    }
}
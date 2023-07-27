//
//  SearchView.swift
//  Test
//
//  Created by Evgeny on 25.07.23.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        let networkChecker = isConnectToNetwork()
        if !networkChecker.hasInternetConnection() {
            Text("No Internet Connection")
        } else {
            NavigationView {
                VStack {
                    if viewModel.isLoading {
                        Color("Background")
                            .ignoresSafeArea()
                            .overlay {
                                ProgressView()
                            }
                    } else if let errorMessage = viewModel.errorMessage {
                        VStack {
                            Text(errorMessage)
                                .font(Font.custom("SFProText-Regular", size: 13))

                            Button {
                                viewModel.repeatButtonAction()
                            } label: {
                                Text("Repeat")
                                .font(Font.custom("SFProText-Regular", size: 17))
                                .foregroundColor(.white)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(.orange)
                                        .padding(.leading, -8)
                                        .padding(.trailing, -8)
                                        .padding(.vertical,-4)
                                }
                            }
                            .padding(.top, 8)
                        }
                    } else {
                        ZStack {
                            Color("Background")
                                .ignoresSafeArea()
                            VStack (spacing: 16) {
                                titleView
                                listBodyView
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.loadData()
            }
        }
    }
    
    var listBodyView: some View {
        ScrollView {
            ForEach(viewModel.results, id: \.id) { result in
                if viewModel.firstElementId == result.id {
                    NavigationLink(destination: FlightInfoView(flightTicketInfo: result, origin: viewModel.origin!, destination: viewModel.destination!)) {
                        CellView(info: result,
                                 origin: viewModel.origin!,
                                 destination: viewModel.destination!,
                                 checkFirstElement: true,
                                 checkInfoElement: false)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .listRowBackground(Color("Background"))
                    .padding(.top, 6)
                    .padding(.bottom, 12)
                    
                } else {
                    NavigationLink(destination: FlightInfoView(flightTicketInfo: result, origin: viewModel.origin!, destination: viewModel.destination!)) {
                        CellView(info: result,
                                 origin: viewModel.origin!,
                                 destination: viewModel.destination!,
                                 checkFirstElement: false,
                                 checkInfoElement: false)
                        
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .listRowBackground(Color("Background"))
                    .padding(.bottom, 12)
                }
            }
        }.padding(.horizontal, 16)
    }
    
    
    var titleView: some View {
        VStack(spacing: 2) {
            Text("\(viewModel.origin!.name) - \(viewModel.destination!.name)")
                .font(
                    Font.custom("SFProText-Semibold", size: 15)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.050, green: 0.070, blue: 0.110))
            
            Text("3 сентября, 1 чел")
                .font(Font.custom("SFProText-Regular", size: 11))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.350, green: 0.390, blue: 0.450))
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

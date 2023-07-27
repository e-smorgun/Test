//
//  FlightInfoView.swift
//  Test
//
//  Created by Evgeny on 25.07.23.
//

import SwiftUI

struct FlightInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false

    let flightTicketInfo: Results
    let origin: Origin
    let destination: Destination
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.94, green: 0.95, blue: 0.96)
                    .ignoresSafeArea()
                
                VStack(spacing: 32) {
                    priceView
                    infoView
                        .padding(.horizontal, 16)
                    
                    Spacer()
                    
                    Button {
                        showingAlert = true
                    } label: {
                        Text("Купить билет за \(flightTicketInfo.price.value) ₽")
                          .font(
                            Font.custom("SFProText-Semibold", size: 17)
                          )
                          .multilineTextAlignment(.center)
                          .foregroundColor(.white)
                          .frame(maxWidth: .infinity, alignment: .top)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 0)
                    .frame(width: 359, height: 48, alignment: .center)
                    .background(Color(red: 1, green: 0.44, blue: 0.2))
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 8)
                    .alert(isPresented:$showingAlert) {
                        Alert(
                            title: Text("Билет куплен за \(flightTicketInfo.price.value) ₽"),
                            dismissButton: .default(
                                Text("Отлично")
                                .font(
                                Font.custom("SFProText-Semibold", size: 17)
                                ))
                        )
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .frame(width: 11.84814, height: 20.2373)
                    Text("Все рейсы")
                        .font(Font.custom("SFProText-Regular", size: 17))
                }
            })
    }
    
    var priceView: some View {
        VStack(spacing: 4) {
            Text("\(flightTicketInfo.price.value) ₽")
              .font(Font.custom("SFProText-Bold", size: 34))
              .multilineTextAlignment(.center)
              .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
              .frame(maxWidth: .infinity, alignment: .top)
            
            Text("Лучшая цена за 1 чел")
              .font(Font.custom("SFProText-Regular", size: 13))
              .multilineTextAlignment(.center)
              .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
              .frame(maxWidth: .infinity, alignment: .top)
        }
    }
    
    var infoView: some View {
        VStack(spacing: 16) {
            Text("Москва — Санкт-Петербург")
              .font(Font.custom("SFProText-Bold", size: 17))
              .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
              .frame(maxWidth: .infinity, alignment: .topLeading)
            
            CellView(info: flightTicketInfo, origin: origin, destination: destination, checkFirstElement: false, checkInfoElement: true)
        }
    }
}

struct FlightInfoView_Previews: PreviewProvider {
    static var previews: some View {
        FlightInfoView(flightTicketInfo: Results(id: "123", departure_date_time: "2023-09-03 12:40", arrival_date_time: "2023-09-03 14:15", price: Price(currency: "RUB", value: 4320), airline: "Аэрофлот", available_tickets_count: 9), origin: Origin(iata: "MSK", name: "Москва"), destination: Destination(iata: "SPB", name: "Санкт-Петербург"))
    }
}

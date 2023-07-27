//
//  CellVIew.swift
//  Test
//
//  Created by Evgeny on 26.07.23.
//

import SwiftUI

struct CellView: View {
    let info: Results
    let origin: Origin
    let destination: Destination
    let checkFirstElement: Bool
    let checkInfoElement: Bool
    
    var body: some View {
        VStack (alignment: .leading, spacing: -8){
            if checkFirstElement == true {
                Text("Самый дешёвый")
                    .padding(.leading, 16)
                    .zIndex(1)
                    .font(
                        Font.custom("SFProText-Semibold", size: 13)
                    )
                    .foregroundColor(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(red: 0.210, green: 0.780, blue: 0.410))
                            .padding(.leading, 8)
                            .padding(.trailing, -8)
                            .padding(.vertical, -2)
                    }
            }
            
            VStack(alignment: .leading, spacing: 12) {
                if checkInfoElement == false {
                    flightPrice
                } else {
                    flightAirline
                }
                departure
                arrival
            }.padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 12)
                .listRowSeparator(.hidden)
                .background {
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color("Table"))
                }
        }
    }
    
    var departure: some View {
        createFlightInfoView(
            name: origin.name,
            date: info.departure_date_time,
            iata: origin.iata
        )
    }
    
    var arrival: some View {
        createFlightInfoView(
            name: destination.name,
            date: info.arrival_date_time,
            iata: destination.iata
        )
    }
    
    
    var flightPrice: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack() {
                Text("\(info.price.value) ₽")
                    .font(
                        Font.custom("SFProText-Semibold", size: 19)                    )
                    .foregroundColor(Color(red: 0.050, green: 0.450, blue: 10))
                
                Spacer()
                
                coverImage
            }
            
            if info.available_tickets_count < 10 {
                Text("Осталось \(info.available_tickets_count) билетов по этой цене")
                    .font(Font.custom("SFProText-Regular", size: 13))
                    .foregroundColor(Color(red: 0.87, green: 0.26, blue: 0.31))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
        }
    }
    
    var flightAirline: some View {
        HStack(spacing: 0) {
            coverImage

            Text("\(info.airline)")
                .font(
                Font.custom("SFProText-Semibold", size: 15)
                )
                .foregroundColor(Color(red: 0.050, green: 0.070, blue: 0.110))
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.leading, 12)
        }
    }
    
    var coverImage: some View {
        Image(info.airline)
            .resizable()
            .frame(width: 26, height: 26)
            .padding(0)
            .background(Color.white)
            .clipShape(Circle())
    }
    
    func formatToTime(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "HH:mm"
            let timeString = dateFormatter.string(from: date)
            
            return timeString
        } else {
            return ("")
        }
    }
    
    func formatToDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let date = dateFormatter.date(from: dateString) {
            
            dateFormatter.dateFormat = "d MMM EE"
            let dateString = dateFormatter.string(from: date)
            
            return dateString
        } else {
            return ""
        }
    }
    
    func createFlightInfoView(name: String, date: String, iata: String) -> some View {
        return VStack(spacing: 2) {
            HStack {
                Text(name)
                    .font(Font.custom("SFProText-Semibold", size: 15))
                    .foregroundColor(Color(red: 0.050, green: 0.070, blue: 0.110))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Spacer()
                
                Text(formatToTime(dateString: date))
                    .font(Font.custom("SFProText-Semibold", size: 15))
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color(red: 0.050, green: 0.070, blue: 0.110))
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
            }
            
            HStack {
                Text(iata)
                    .font(Font.custom("SFProText-Regular", size: 13))
                    .foregroundColor(Color(red: 0.350, green: 0.390, blue: 0.450))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Spacer()
                
                Text(formatToDate(dateString: date))
                    .font(Font.custom("SFProText-Regular", size: 13))
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color(red: 0.350, green: 0.390, blue: 0.450))
            }
        }
    }
}

struct SearchView1_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


//
//  ContentView.swift
//  BarCodeScanner
//
//  Created by Kody Buss on 2/18/24.
//

import SwiftUI

struct BarcodeScannerView: View {
    var body: some View {
		VStack(spacing: 20) {
			HStack{
				Text("Barcode Scanner")
					.font(.largeTitle)
					.bold()
				Spacer()
			}
			
			Spacer()
			
			VStack{}
				.frame(width: 400, height: 300, alignment: .center)
				.background(.black)
			
			HStack{
				Image(systemName: "barcode.viewfinder")
					.resizable()
					.scaledToFit()
				
				Text("Scanned Barcode:")
					.font(.title)
					.fontWeight(.semibold)
					.foregroundStyle(.gray)
			}
			.frame(width: 300, height: 30)
			.padding()
			
			Text("Not Yet Scanned")
				.font(.largeTitle)
				.foregroundStyle(.red)
				.bold()
			
			Spacer()
        }
        .padding()
    }
}

#Preview {
    BarcodeScannerView()
}

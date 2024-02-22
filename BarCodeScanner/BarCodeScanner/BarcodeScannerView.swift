//
//  ContentView.swift
//  BarCodeScanner
//
//  Created by Kody Buss on 2/18/24.
//

import SwiftUI

struct BarcodeScannerView: View {
	@State private var scannedCode = ""
	
	var body: some View {
		NavigationStack{
			VStack(spacing: 20) {
				Spacer()
				
				ScannerView()
					.frame(maxWidth: .infinity, maxHeight: 300)
				
				Label("Scanned Barcode:", systemImage: "barcode.viewfinder")
					.font(.title)
				
				Text(scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode)
					.font(.largeTitle)
					.foregroundStyle(scannedCode.isEmpty ? .red : .green)
					.bold()
				
				Spacer()
			}
			.navigationTitle("Barcode Scanner")
		}
	}
}

#Preview {
	BarcodeScannerView()
}

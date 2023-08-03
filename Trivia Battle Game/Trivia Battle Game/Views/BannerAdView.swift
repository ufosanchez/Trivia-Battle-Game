//
//  BannerAdView.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-06-22.
//

import SwiftUI
import GoogleMobileAds

struct BannerAdView: View {
    
    let screen : String
    
    var body: some View {
        if(screen == "Levels"){
            AdBannerView(adUnitID: "ca-app-pub-3940256099942544/2934735716") // Replace with your ad unit ID
                .frame(height: 140)
        }
        else{
            AdBannerView(adUnitID: "ca-app-pub-3940256099942544/2934735716") // Replace with your ad unit ID
                .frame(height: 40)
        }
    }
}

//struct BannerAdView_Previews: PreviewProvider {
//    static var previews: some View {
//        BannerAdView()
//    }
//}

struct AdBannerView: UIViewRepresentable {
    let adUnitID: String

    func makeUIView(context: Context) -> GADBannerView {
        let bannerView = GADBannerView(adSize: GADAdSizeFromCGSize(CGSize(width: 320, height: 150))) // Set your desired banner ad size
        bannerView.adUnitID = adUnitID
        bannerView.rootViewController = UIApplication.shared.windows.first?.rootViewController
        bannerView.load(GADRequest())
        return bannerView
    }
    
    func updateUIView(_ uiView: GADBannerView, context: Context) {}
}


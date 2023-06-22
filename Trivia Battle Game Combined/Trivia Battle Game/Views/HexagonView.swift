//
//  HexagonView.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-06-12.
//

import SwiftUI

struct hexagon : Shape{
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: (rect.maxY)/4))
            path.addLine(to: CGPoint(x: rect.maxX, y: 3*(rect.maxY)/4))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: 3*(rect.maxY)/4))
            path.addLine(to: CGPoint(x: rect.minX, y: (rect.maxY)/4))
            path.addLine(to: CGPoint(x: rect.midX + 1, y: rect.minY))
        }
    }
}

struct HexagonView: View {
    
    let levelUser : Int
    var body: some View {
        ZStack{
//            Image("background_hexa")
//                .resizable()
//                .frame(width: 300, height: 300)
//                .clipShape(hexagon())
            hexagon()
                .stroke(style: StrokeStyle(lineWidth: 5))
                .foregroundColor(Color.black)
                .background(hexagon().fill(Color(red: 231/255, green: 233/255, blue: 205/255)))
                .frame(width: 70, height: 70)
                
            Text("\(levelUser)")
                .font(.custom("NerkoOne-Regular", size: 35))
            
//            hexagon()
//                .frame(width: 300, height: 300)
        }
    }
}

//struct HexagonView_Previews: PreviewProvider {
//    static var previews: some View {
//        HexagonView()
//    }
//}

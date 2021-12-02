//
//  DraggableModifier.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 01/12/2021.
//

import SwiftUI

struct DraggableModifier : ViewModifier {

    enum Direction {
        case vertical
        case horizontal
    }

    let direction: Direction
    
    let action: () -> Void

    @Binding var draggedOffset: CGSize 

    func body(content: Content) -> some View {
        content
        .offset(
            CGSize(width: direction == .vertical ? 0 : draggedOffset.width,
                   height: direction == .horizontal ? 0 : draggedOffset.height)
        )
        .gesture(
            DragGesture()
            .onChanged { value in
                self.draggedOffset = value.translation
            }
            .onEnded { value in
                
                if value.predictedEndTranslation.height > CGFloat(400) {
                    self.draggedOffset = value.translation
                    withAnimation {
                        self.draggedOffset = CGSize(width: 0, height: 3000)
                        action()
                        
                    }
                    
                } else if value.predictedEndTranslation.height < CGFloat(-400) {
                    self.draggedOffset = value.translation
                    withAnimation {
                        self.draggedOffset = CGSize(width: 0, height: -3000)
                        action()
                    }
                } else {
                    withAnimation {
                        self.draggedOffset = .zero
                    }
                }
            }
        )
    }

}

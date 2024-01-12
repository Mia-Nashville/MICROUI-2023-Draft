//
//  TabModifiers.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/12/24.
//

import Foundation
import SwiftUI
import UIKit

struct darktabViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        
            .padding(5)
            .background(Color("Background 1"))
            .background(VisualEffectBlur(blurStyle: .systemThickMaterialDark)).opacity(0.8)
            .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(Color.white, lineWidth: 1).blendMode(.overlay))
            .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(.top, 5)
    }
}

struct lighttabViewModifier: ViewModifier {
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


struct tabViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content

            .padding(16)
            .background(Color("Background 1"))
         //   .background(.ultraThinMaterial)
        //    .background(VisualEffectBlur(blurStyle: .systemUltraThinMaterialLight))
            .background(VisualEffectBlur(blurStyle: .systemUltraThinMaterialDark))
            .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.white, lineWidth: 1).blendMode(.overlay))
            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .padding(.top, 20)
            
    }
}

extension UIImage {
    func aspectFitToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        return renderer.image {_ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
            
            // Render UIImage to fit to scale and rectangle
            // Scale the image to new height and reduced size
        }
    }
    
    func compressImage(imageUI: UIImage) -> UIImage {
        let resizedImage = imageUI.aspectFitToHeight(200)
        resizedImage.jpegData(compressionQuality: 1)
        
        return resizedImage
    }
}



extension View {
    
    func withTabColorFormatting() -> some View {
        self
            .modifier(tabViewModifier())
    }
    
    func withTabColorlightFormatting() -> some View {
        self
            .modifier(lighttabViewModifier())
    }
    
    func withDarkTabColorFormatting() -> some View {
        self
            .modifier(darktabViewModifier())
    }
    
}

struct VisualEffectBlur<Content: View>: View {
    var blurStyle: UIBlurEffect.Style
    var vibrancyStyle: UIVibrancyEffectStyle?
    var content: Content
    
    init(blurStyle: UIBlurEffect.Style = .systemMaterial, vibrancyStyle: UIVibrancyEffectStyle? = nil, @ViewBuilder content: () -> Content) {
        self.blurStyle = blurStyle
        self.vibrancyStyle = vibrancyStyle
        self.content = content()
    }
    
    var body: some View {
        Representable(blurStyle: blurStyle, vibrancyStyle: vibrancyStyle, content: ZStack { content })
            .accessibility(hidden: Content.self == EmptyView.self)
    }
}

// MARK: - Representable

extension VisualEffectBlur {
    struct Representable<Content: View>: UIViewRepresentable {
        var blurStyle: UIBlurEffect.Style
        var vibrancyStyle: UIVibrancyEffectStyle?
        var content: Content
        
        func makeUIView(context: Context) -> UIVisualEffectView {
            context.coordinator.blurView
        }
        
        func updateUIView(_ view: UIVisualEffectView, context: Context) {
            context.coordinator.update(content: content, blurStyle: blurStyle, vibrancyStyle: vibrancyStyle)
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(content: content, blurStyle: blurStyle, vibrancyStyle: vibrancyStyle)
        }
        
        static func dismantleUIView(_ uiView: UIVisualEffectView, coordinator: Coordinator) {
            uiView.removeFromSuperview()
        }
    }
}

// MARK: - Coordinator

extension VisualEffectBlur.Representable {
    class Coordinator {
        let blurView = UIVisualEffectView()
        let vibrancyView = UIVisualEffectView()
        let hostingController: UIHostingController<Content>
        
        init(content: Content, blurStyle: UIBlurEffect.Style, vibrancyStyle: UIVibrancyEffectStyle?) {
            hostingController = UIHostingController(rootView: content)
            hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            hostingController.view.backgroundColor = nil

            let blurEffect = UIBlurEffect(style: blurStyle)
            blurView.effect = blurEffect
            if let vibrancyStyle = vibrancyStyle {
                vibrancyView.effect = UIVibrancyEffect(blurEffect: blurEffect, style: vibrancyStyle)
            } else {
                vibrancyView.effect = nil
            }

            blurView.contentView.addSubview(vibrancyView)
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            vibrancyView.contentView.addSubview(hostingController.view)
            vibrancyView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        
        func update(content: Content, blurStyle: UIBlurEffect.Style, vibrancyStyle: UIVibrancyEffectStyle?) {
            hostingController.rootView = content
            hostingController.view.setNeedsDisplay()
        }
    }
}

// MARK: - Content-less Initializer

extension VisualEffectBlur where Content == EmptyView {
    init(blurStyle: UIBlurEffect.Style = .systemMaterial) {
        self.init( blurStyle: blurStyle, vibrancyStyle: nil) {
            EmptyView()
        }
    }
}



// MARK: - SlideFadeIN

struct SlideFadeIn: ViewModifier {
    var show: Bool
    var offset: Double
    
    func body(content: Content) -> some View {
        content
            .opacity(show ? 1: 0)
            .offset(y: show ? 0: offset)
    }
}

struct OutlineModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var cornerRadiuses: CGFloat = 20
    
    func body(content: Content) -> some View {
        content.overlay(
        RoundedRectangle(cornerRadius: cornerRadiuses)
            .stroke(
                .linearGradient(colors: [.white.opacity(colorScheme == .dark ? 0.1 : 0.3), .black.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing)))
    }
}



struct BackgroundColor: ViewModifier {
    var opacity: Double = 0.6
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .overlay(
            Color("Background 1")
                .opacity(colorScheme == .dark ? opacity : 0)
                .blendMode(.overlay)
                .allowsHitTesting(false)
            )
    }
}
extension View {
    func backgroundColor(opacity: Double = 0.6) -> some View {
        self.modifier(BackgroundColor(opacity: opacity))
    }
}


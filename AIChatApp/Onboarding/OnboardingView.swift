//
//  OnboardingView.swift
//  AIChatApp
//
//  Created by Pankaj Rannaa on 23/02/26.
//

import SwiftUI

//struct OnboardingView: View {
//    
//    @EnvironmentObject var settings: AppSettings
//    @State private var currentPage = 0
//    var onFinish: () -> Void
//
//    private let pages = [
//        OnboardingPage(
//            title: "Welcome to Pankaj AI Chat",
//            subtitle: "Your personal AI assistant, ready to answer questions, generate content, and help you learn.",
//            imageName: "brain.head.profile"
//        ),
//        OnboardingPage(
//            title: "Speak or Type",
//            subtitle: "Use your voice or type messages. Chat seamlessly with the AI assistant anytime.",
//            imageName: "mic.fill"
//        ),
//        OnboardingPage(
//            title: "Smart & Fast",
//            subtitle: "Get intelligent responses instantly, powered by advanced AI technology.",
//            imageName: "bolt.fill"
//        )
//    ]
//    
//    var body: some View {
//        ZStack {
//            
//            // ✅ Full-screen gradient background
//            LinearGradient(
//                gradient: Gradient(colors: [settings.selectedTheme.accentColor.opacity(0.8), settings.selectedTheme.accentColor.opacity(0.3)]),
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//            .ignoresSafeArea()
//            
//            VStack(spacing: 30) {
//                Spacer()
//                
//                // ✅ Animated Image
//                Image(systemName: pages[currentPage].imageName)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 160, height: 160)
//                    .foregroundStyle(.white.opacity(0.9), .black.opacity(0.2))
//                    .shadow(color: .black.opacity(0.25), radius: 12, x: 0, y: 6)
//                    .scaleEffect(currentPage == pages.count - 1 ? 1.1 : 1)
//                    .animation(.easeInOut(duration: 0.6), value: currentPage)
//                
//                // ✅ Glassmorphic Text Panel
//                VStack(spacing: 16) {
//                    Text(pages[currentPage].title)
//                        .font(.largeTitle.bold())
//                        .foregroundStyle(settings.selectedTheme.gradient)
//                        .multilineTextAlignment(.center)
//                        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
//                    
//                    Text(pages[currentPage].subtitle)
//                        .font(.body)
//                        .foregroundColor(.white.opacity(0.85))
//                        .multilineTextAlignment(.center)
//                        .padding(.horizontal, 30)
//                }
//                .padding()
//                .background(.ultraThinMaterial)
//                .cornerRadius(25)
//                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
//                
//                Spacer()
//                
//                // ✅ Page Dots
//                HStack(spacing: 10) {
//                    ForEach(0..<pages.count, id: \.self) { index in
//                        Circle()
//                            .fill(index == currentPage ? .white : Color.white.opacity(0.5))
//                            .frame(width: index == currentPage ? 12 : 8, height: index == currentPage ? 12 : 8)
//                            .scaleEffect(index == currentPage ? 1.2 : 1)
//                            .animation(.spring(), value: currentPage)
//                    }
//                }
//                
//                // ✅ Modern Button
//                Button {
//                    if currentPage < pages.count - 1 {
//                        currentPage += 1
//                    } else {
//                        onFinish()
//                    }
//                } label: {
//                    Text(currentPage < pages.count - 1 ? "Next" : "Get Started")
//                        .font(.headline.bold())
//                        .foregroundStyle(
//                            settings.selectedTheme.gradient
//                        )
//                        .padding(.vertical, 16)
//                        .frame(maxWidth: .infinity)
//                        .background(
//                            RoundedRectangle(cornerRadius: 25)
//                                .fill(.ultraThinMaterial)
//                                .background(
//                                    settings.selectedTheme.gradient
//                                        .mask(RoundedRectangle(cornerRadius: 25))
//                                        .opacity(0.4)
//                                )
//                        )
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 25)
//                                .stroke(settings.selectedTheme.accentColor.opacity(0.8), lineWidth: 1)
//                        )
//                        .shadow(color: settings.selectedTheme.accentColor.opacity(0.5), radius: 12, x: 0, y: 6)
//                }
//                .buttonStyle(ScaleButtonStyle())
//                .padding(.horizontal, 40)
//                .padding(.bottom, 40)
//            }
//        }
//        .transition(.slide)
//    }
//    
//    struct ScaleButtonStyle: ButtonStyle {
//        func makeBody(configuration: Configuration) -> some View {
//            configuration.label
//                .scaleEffect(configuration.isPressed ? 0.95 : 1)
//                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
//        }
//    }
//}
//
//struct OnboardingPage {
//    let title: String
//    let subtitle: String
//    let imageName: String
//}


// MARK: - Data Model

struct OnboardingPage {
    let subtitle: String
}

// MARK: - Main Onboarding View

struct OnboardingView: View {

    @State private var currentPage = 0
    var onFinish: () -> Void

    private let pages: [OnboardingPage] = [
        OnboardingPage(subtitle: "Our AI assistant is designed to become your trusted companion in solving various tasks and issues"),
        OnboardingPage(subtitle: "Use your voice or type messages. Chat seamlessly with the AI assistant anytime."),
        OnboardingPage(subtitle: "Get intelligent responses instantly, powered by advanced AI technology."),
    ]

    var body: some View {
        ZStack {
            // Blob background
            BlobBackgroundView()
                .ignoresSafeArea()

            VStack(spacing: 0) {

                Spacer()

                // Robot illustration
                RobotView()
                    .frame(width: 220, height: 240)
                    .id(currentPage)
                    .transition(.scale(scale: 0.85).combined(with: .opacity))
                    .animation(.spring(response: 0.4, dampingFraction: 0.7), value: currentPage)

                Spacer()

                // Bottom content
                VStack(alignment: .leading, spacing: 20) {

                    // Page dots
                    HStack(spacing: 8) {
                        ForEach(0..<pages.count, id: \.self) { index in
                            Capsule()
                                .fill(index == currentPage ? Color(hex: "#1e1e1e") : Color(hex: "#1e1e1e").opacity(0.3))
                                .frame(width: index == currentPage ? 28 : 8, height: 8)
                                .animation(.spring(response: 0.4, dampingFraction: 0.7), value: currentPage)
                                .onTapGesture { currentPage = index }
                        }
                    }

                    // Subtitle text
                    Text(pages[currentPage].subtitle)
                        .font(.custom("AvenirNext-DemiBold", size: 22))
                        .foregroundColor(Color(hex: "#1a1a1a"))
                        .lineSpacing(5)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: 260, alignment: .leading)
                        .id("subtitle-\(currentPage)")
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                        .animation(.easeInOut(duration: 0.3), value: currentPage)

                    // Get Started button
                    Button(action: handleNext) {
                        HStack(spacing: 10) {
                            Text(currentPage < pages.count - 1 ? "Next" : "Get started")
                                .font(.custom("AvenirNext-Bold", size: 17))
                                .foregroundColor(.white)
                            Image(systemName: "arrow.right")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 18)
                        .padding(.horizontal, 32)
                        .background(
                            Capsule()
                                .fill(Color(hex: "#1e1e1e"))
                                .shadow(color: .black.opacity(0.3), radius: 12, x: 0, y: 8)
                        )
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 52)
            }

            // Large watermark title
            VStack {
                HStack {
                    Text("AI-vo")
                        .font(.system(size: 96, weight: .black, design: .rounded))
                        .foregroundColor(.white.opacity(0.22))
                        .padding(.leading, 18)
                        .padding(.top, 60)
                    Spacer()
                }
                Spacer()
            }
            .ignoresSafeArea()
        }
    }

    private func handleNext() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            if currentPage < pages.count - 1 {
                currentPage += 1
            } else {
                onFinish()
            }
        }
    }

    // MARK: - Scale Button Style
    struct ScaleButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
        }
    }
}

// MARK: - Blob Background

struct BlobBackgroundView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Teal base
                Color(hex: "#4fe9df")

                // Purple blob — top left
                Ellipse()
                    .fill(Color(hex: "#7c3aed").opacity(0.9))
                    .frame(width: 280, height: 280)
                    .offset(x: -geo.size.width * 0.3, y: -geo.size.height * 0.25)

                // Coral/red blob — right center
                Ellipse()
                    .fill(Color(hex: "#f05a5a").opacity(0.9))
                    .frame(width: 340, height: 340)
                    .offset(x: geo.size.width * 0.28, y: -geo.size.height * 0.05)

                // Small coral teardrop — bottom right
                Ellipse()
                    .fill(Color(hex: "#f05a5a").opacity(0.85))
                    .frame(width: 55, height: 75)
                    .rotationEffect(.degrees(20))
                    .offset(x: geo.size.width * 0.18, y: geo.size.height * 0.12)
            }
        }
    }
}

// MARK: - Robot SVG-style View

struct RobotView: View {
    var body: some View {
        ZStack {
            // Shadow base
            Ellipse()
                .fill(Color.black.opacity(0.15))
                .frame(width: 140, height: 20)
                .offset(y: 108)
                .blur(radius: 8)

            VStack(spacing: 0) {
                // Antenna
                ZStack(alignment: .bottom) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 14, height: 14)
                        .shadow(color: .gray.opacity(0.3), radius: 4)
                    Rectangle()
                        .fill(Color(white: 0.78))
                        .frame(width: 4, height: 30)
                        .offset(y: 22)
                }
                .frame(height: 44)

                // Head
                ZStack {
                    RoundedRectangle(cornerRadius: 22)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.12), radius: 10, x: 0, y: 4)

                    // Face screen
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(hex: "#1e1e1e"))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)

                    // Eyes
                    HStack(spacing: 18) {
                        Capsule()
                            .fill(Color(hex: "#4fe9df"))
                            .frame(width: 22, height: 10)
                        Capsule()
                            .fill(Color(hex: "#4fe9df"))
                            .frame(width: 22, height: 10)
                    }
                    .offset(y: -8)

                    // Smile arc
                    SmileShape()
                        .stroke(Color(hex: "#4fe9df"), style: StrokeStyle(lineWidth: 4.5, lineCap: .round))
                        .frame(width: 52, height: 18)
                        .offset(y: 12)

                    // Left ear
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(white: 0.82))
                        .frame(width: 18, height: 28)
                        .offset(x: -66)

                    // Right ear
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(white: 0.82))
                        .frame(width: 18, height: 28)
                        .offset(x: 66)
                }
                .frame(width: 140, height: 100)

                // Neck
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(white: 0.82))
                    .frame(width: 28, height: 14)

                // Body
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)

                    VStack(spacing: 12) {
                        // Chest bar
                        Capsule()
                            .fill(Color(hex: "#4fe9df").opacity(0.65))
                            .frame(width: 48, height: 9)

                        // Chest dots
                        HStack(spacing: 10) {
                            Circle().fill(Color(hex: "#4fe9df").opacity(0.4)).frame(width: 14, height: 14)
                            Circle().fill(Color(hex: "#4fe9df").opacity(0.75)).frame(width: 14, height: 14)
                            Circle().fill(Color(hex: "#4fe9df").opacity(0.4)).frame(width: 14, height: 14)
                        }
                    }
                }
                .frame(width: 120, height: 78)
            }
        }
        .frame(width: 220, height: 240)
    }
}

// MARK: - Smile Shape

struct SmileShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: 0),
            control: CGPoint(x: rect.midX, y: rect.maxY)
        )
        return path
    }
}

// MARK: - Color Hex Extension

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Preview

#Preview {
    OnboardingView(onFinish: {})
}

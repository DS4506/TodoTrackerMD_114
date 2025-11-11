
import SwiftUI
import PencilKit
import UIKit

// MARK: - Main SwiftUI screen for Apple Pencil, trackpad gestures, shortcuts
struct DrawingView: View {
    // Tool state
    @State private var selectedTool: Tool = .pen
    @State private var inkColor: UIColor = .systemBlue
    @State private var width: CGFloat = 8
    @State private var fingerDraws: Bool = true

    // Visual transform (for trackpad gestures)
    @State private var scale: CGFloat = 1.0
    @State private var rotation: CGFloat = 0.0
    @State private var translation: CGSize = .zero

    // Undo/redo
    @Environment(\.undoManager) private var undoManager

    var body: some View {
        VStack(spacing: 0) {
            // Toolbar
            toolBar

            // Canvas with transform gestures (pinch/rotate/drag)
            ZStack {
                Color(.secondarySystemBackground)

                PencilCanvasRepresentable(
                    selectedTool: $selectedTool,
                    inkColor: $inkColor,
                    width: $width,
                    fingerDraws: $fingerDraws
                )
                .scaleEffect(scale)
                .rotationEffect(.degrees(rotation))
                .offset(translation)
                .gesture(gesturePack)   // trackpad/touch gestures
                .accessibilityLabel("Drawing canvas")
            }
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .padding()
        }
        .navigationTitle("Canvas")
        .toolbarTitleDisplayMode(.inline)
    }

    // MARK: - Toolbar with tool controls + shortcuts
    private var toolBar: some View {
        HStack(spacing: 12) {
            // Tools
            Picker("Tool", selection: $selectedTool) {
                Label("Pen", systemImage: "pencil.tip").tag(Tool.pen)
                Label("Marker", systemImage: "highlighter").tag(Tool.marker)
                Label("Eraser", systemImage: "eraser").tag(Tool.eraser)
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 320)

            // Color
            ColorPicker("Color", selection: Binding(
                get: { Color(inkColor) },
                set: { newValue in
                    // Convert Color -> UIColor safely
                    let ui = UIColor(newValue)
                    inkColor = ui
                })
            )
            .disabled(selectedTool == .eraser)

            // Width
            HStack {
                Image(systemName: "line.horizontal.3.decrease.circle")
                Slider(value: $width, in: 1...30, step: 1)
                    .frame(width: 140)
                Text("\(Int(width))")
                    .font(.caption).monospacedDigit()
            }
            .disabled(selectedTool == .eraser)

            Spacer()

            // Finger drawing toggle
            Toggle(isOn: $fingerDraws) {
                Image(systemName: fingerDraws ? "hand.draw.fill" : "hand.draw")
            }
            .toggleStyle(.button)

            // Undo / Redo
            Button {
                undoManager?.undo()
            } label: { Image(systemName: "arrow.uturn.backward.circle.fill") }
            .keyboardShortcut("z", modifiers: [.command])

            Button {
                undoManager?.redo()
            } label: { Image(systemName: "arrow.uturn.forward.circle.fill") }
            .keyboardShortcut("Z", modifiers: [.command, .shift])
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(.thinMaterial)
    }

    // MARK: - Combined gesture pack (pinch + rotate + drag)
    private var gesturePack: some Gesture {
        let magnify = MagnificationGesture()
            .onChanged { value in
                scale = min(max(value, 0.5), 3.0)
            }

        let rotate = RotationGesture()
            .onChanged { angle in
                rotation = angle.degrees
            }

        let drag = DragGesture()
            .onChanged { v in
                translation = v.translation
            }
            .onEnded { _ in
                // allow “throw” feeling but clamp if needed later
            }

        // Allow pinch + rotate together, then drag
        return magnify.simultaneously(with: rotate).simultaneously(with: drag)
    }
}

// MARK: - Tool enum
enum Tool {
    case pen, marker, eraser
}

// MARK: - PencilKit wrapped in SwiftUI
struct PencilCanvasRepresentable: UIViewRepresentable {
    @Binding var selectedTool: Tool
    @Binding var inkColor: UIColor
    @Binding var width: CGFloat
    @Binding var fingerDraws: Bool

    // Keep a single PKCanvasView and PKToolPicker
    private let canvas = PKCanvasView()
    private let toolPicker = PKToolPicker()

    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput   // allow Apple Pencil and finger if enabled
        canvas.allowsFingerDrawing = fingerDraws
        canvas.backgroundColor = .clear
        canvas.isOpaque = false

        // show the tool picker floating palette
        if let window = canvas.window ?? UIApplication.shared.windows.first {
            toolPicker.addObserver(canvas)
            toolPicker.setVisible(true, forFirstResponder: canvas)
            DispatchQueue.main.async { canvas.becomeFirstResponder() }
        }

        // initial tool
        applyTool()
        return canvas
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.allowsFingerDrawing = fingerDraws
        applyTool()
    }

    private func applyTool() {
        switch selectedTool {
        case .pen:
            canvas.tool = PKInkingTool(.pen, color: inkColor, width: width)
        case .marker:
            canvas.tool = PKInkingTool(.marker, color: inkColor, width: width)
        case .eraser:
            canvas.tool = PKEraserTool(.vector)
        }
    }
}

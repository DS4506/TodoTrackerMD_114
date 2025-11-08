
import SwiftUI

// MARK: - Placeholder View (unchanged)
struct PlaceHolderView: View {
    var title: String
    var message: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "square.and.pencil")
                .font(.system(size: 64))
                .foregroundColor(.secondary)

            Text(title)
                .font(.title2).bold()

            Text(message)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 420)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

// MARK: - Profile Screen
struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                // Header background with gradient
                ZStack {
                    LinearGradient(
                        colors: [
                            Color.blue.opacity(0.25),
                            Color.green.opacity(0.25)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: 160)
                    .cornerRadius(20)
                    .padding(.horizontal)

                    // Circular Profile Image
                    Image("Profile Picture")               // ← YOUR IMAGE NAME
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 160)     // small circular size
                        .clipShape(Circle())                 // circular shape
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 4)
                                .shadow(radius: 6)
                        )
                        .offset(y: 80)
                }
                .padding(.top, 20)
                .padding(.bottom, 100)

                // Name + Subtitle
                VStack(spacing: 6) {
                    Text("David Smith")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("Entrepreneur • Vision Builder • iOS Student")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                // Profile Details (Email, Website, etc.)
                VStack(alignment: .leading, spacing: 12) {

                    InfoRow(
                        icon: "envelope.fill",
                        title: "Email",
                        value: "Davidsmith4506@gmail.com"
                    )

                    InfoRow(
                        icon: "globe",
                        title: "Website",
                        value: "StrategicSolutions.com"
                    )

                    InfoRow(
                        icon: "mappin.and.ellipse",
                        title: "Location",
                        value: "Central Texas"
                    )

                    InfoRow(
                        icon: "briefcase.fill",
                        title: "Role",
                        value: "Clarity Life Coach"
                    )
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemBackground))
                )
                .padding(.horizontal)

                Spacer()
            }
            .frame(maxWidth: 700)
        }
        .navigationTitle("Profile")
    }
}

// MARK: - Reusable Row Component
struct InfoRow: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {

            Image(systemName: icon)
                .frame(width: 22)
                .foregroundColor(.blue)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(value)
                    .font(.body)
            }

            Spacer()
        }
    }
}

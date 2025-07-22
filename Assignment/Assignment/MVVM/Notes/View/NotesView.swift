//
//  NotesView.swift
//  Assignment
//
//  Created by SACHETH D S. on 22/07/25.
//

import SwiftUI

struct NotesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Title
            VStack(spacing: 4) {
                Text("Notes")
                    .font(.largeTitle).bold()
                Text("Personal messages to you")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding(.top)

            // Main Card
            ZStack(alignment: .bottomLeading) {
                Image("meena") // Replace with your asset image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.black.opacity(0.1), lineWidth: 0.5)
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text("Meena, 23")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Tap to review 50+ notes")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding()
            }

            // Premium Section
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Interested In You")
                        .font(.headline)
                    Text("Premium members can\nview all their likes at once")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Spacer()

                Button(action: {}) {
                    Text("Upgrade")
                        .font(.subheadline.bold())
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .cornerRadius(20)
                }
            }

            // Horizontal Cards
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(["Teena", "Beena"], id: \.self) { name in
                        VStack {
                            Image(name.lowercased()) // Replace with your asset names
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Text(name)
                                .font(.caption)
                        }
                    }
                }
                .padding(.vertical)
            }

            Spacer()

            // Bottom Tab Bar
            HStack {
                TabBarItem(icon: "magnifyingglass", label: "Discover")
                TabBarItem(icon: "envelope.fill", label: "Notes", badge: "9")
                TabBarItem(icon: "heart.fill", label: "Matches", badge: "50+")
                TabBarItem(icon: "person.fill", label: "Profile")
            }
            .padding(.vertical, 12)
            .background(Color.white.shadow(radius: 2))
        }
        .navigationBarBackButtonHidden()
        .padding(.horizontal)
    }
}

struct TabBarItem: View {
    let icon: String
    let label: String
    var badge: String? = nil

    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                Image(systemName: icon)
                    .font(.title3)
                if let badge = badge {
                    Text(badge)
                        .font(.caption2.bold())
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color.purple)
                        .clipShape(Circle())
                        .offset(x: 8, y: -8)
                }
            }
            Text(label)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
    }
}

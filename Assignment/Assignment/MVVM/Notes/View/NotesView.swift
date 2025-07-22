//
//  NotesView.swift
//  Assignment
//
//  Created by SACHETH D S. on 22/07/25.
//

import SwiftUI

struct NotesView: View {
    @StateObject var notesVM = NotesVM()
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
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
                AsyncImage(url: URL(string: notesVM.notesDetails?.invites?.profiles?[0].photos?.filter({$0.selected == true}).first?.photo ?? "")) { phase in
                    if let image = phase.image {
                        image.resizable().aspectRatio(contentMode: .fill)
                    } else if phase.error != nil {
                        Image(systemName: "xmark.octagon")
                            .resizable().scaledToFit().foregroundColor(.red)
                    } else {
                        ProgressView()
                    }
                }
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.black.opacity(0.1), lineWidth: 0.5)
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text("\(notesVM.notesDetails?.invites?.profiles?[0].generalInformation?.firstName ?? ""), \(notesVM.notesDetails?.invites?.profiles?[0].generalInformation?.age ?? 0)")
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
                    if let profiles = notesVM.notesDetails?.likes?.profiles {
                        ForEach(profiles, id: \.id) { likedProfiles in
                            VStack {
                                ZStack(alignment: .bottomLeading) {
                                    
                                    AsyncImage(url: URL(string: likedProfiles.avatar ?? "")) { phase in
                                        if let image = phase.image {
                                            image.resizable().aspectRatio(contentMode: .fill)
                                        } else if phase.error != nil {
                                            Image(systemName: "xmark.octagon")
                                                .resizable().scaledToFit().foregroundColor(.red)
                                        } else {
                                            ProgressView()
                                        }
                                    }
                                    .frame(width: (UIScreen.main.bounds.width - (UIScreen.main.bounds.width * 0.1243)) / 2)
                                    .blur(radius: notesVM.notesDetails?.likes?.canSeeProfile ?? true ? 0 : 10)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.black.opacity(0.1), lineWidth: 0.5)
                                    )
                                    
                                    Text(likedProfiles.firstName ?? "")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()
                                }
                                .padding(.top, 20)
                            }
                        }
                    }
                }
            }
            .padding(.bottom, 20)


            // Bottom Tab Bar
            HStack {
                TabBarItem(icon: "magnifyingglass", label: "Discover")
                TabBarItem(icon: "envelope.fill", label: "Notes", badge: "9")
                TabBarItem(icon: "heart.fill", label: "Matches", badge: "50+")
                TabBarItem(icon: "person.fill", label: "Profile")
            }
            .background(Color.white.shadow(radius: 2))
            .frame(height: 30)
        }
        .task {
            await notesVM.getNotesDetails()
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
            ZStack(alignment: .center) {
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




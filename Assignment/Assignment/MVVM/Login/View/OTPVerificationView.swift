//
//  otpVerificationView.swift
//  Assignment
//
//  Created by SACHETH D S. on 22/07/25.
//

import SwiftUI

struct OTPVerificationView: View {
    @State private var otp: String = ""
    @State private var remainingTime = 59
    @State private var timerRunning = true
    var phoneNumber: String
    @State var isNavigating: Bool = false
    @Environment(\.dismiss) private var dismiss
    @StateObject var loginVM = LoginVM()
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 24) {
                
                // Phone number with edit icon
                HStack(spacing: 4) {
                    Text(phoneNumber)
                        .font(.subheadline)
                        .bold()
                    
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .onTapGesture {
                            dismiss()
                        }
                }
                
                // Heading
                Text("Enter The\nOTP")
                    .font(.system(size: 28, weight: .bold))
                
                // OTP input
                TextField("OTP", text: $loginVM.otp)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .frame(width: 100)
                
                // Continue button and timer
                HStack {
                    Button(action: {
                        Task {
                            await self.loginVM.verifyOtp()
                        }
                    }) {
                        Text("Continue")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 10)
                            .background(Color.yellow)
                            .cornerRadius(25)
                    }
                    .onChange(of: loginVM.token) {
                        if loginVM.token != "" {
                            isNavigating = true
                        }
                    }
                    
                    Spacer()
                    
                    Text(timeString)
                        .font(.subheadline)
                        .bold()
                }
                
                Spacer()
            }
            .blur(radius: loginVM.isLoading ?? false ? 2  : 0)
            .overlay {
                if loginVM.isLoading ?? false {
                    ProgressView()
                        .frame(width: 200, height: 200, alignment: .center)
                }
            }

        }
        .navigationDestination(isPresented: $isNavigating) {
            NotesView()
        }
        .padding()
        .onAppear(perform: startTimer)
        .navigationBarBackButtonHidden()
    }
    
    var timeString: String {
        String(format: "00:%02d", remainingTime)
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                timer.invalidate()
                timerRunning = false
            }
        }
    }
}


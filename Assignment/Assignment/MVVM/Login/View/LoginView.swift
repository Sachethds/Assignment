//
//  LoginView.swift
//  Assignment
//
//  Created by SACHETH D S. on 22/07/25.
//

import SwiftUI

struct LoginView: View {
      @State private var isNavigating: Bool = false
      @StateObject var loginVM = LoginVM()
    
      var body: some View {
          NavigationStack {
              VStack(alignment: .leading, spacing: 24) {
                  
                  // Heading
                  VStack(alignment: .leading, spacing: 4) {
                      Text("Get OTP")
                          .font(.subheadline)
                          .foregroundColor(.gray)
                      
                      Text("Enter Your\nPhone Number")
                          .font(.system(size: 28, weight: .bold))
                  }
                  
                  // Phone Input
                  HStack(spacing: 12) {
                      TextField("+91", text: $loginVM.countryCode)
                          .keyboardType(.phonePad)
                          .frame(width: 60)
                          .padding()
                          .background(Color.white)
                          .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                          )
                      
                      TextField("", text: $loginVM.mobileNumber)
                          .keyboardType(.phonePad)
                          .padding()
                          .background(Color.white)
                          .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                          )
                  }
                  
                  // Continue Button
                  Button(action: {
                      Task {
                          await loginVM.login()
                      }
                  }) {
                      Text("Continue")
                          .foregroundColor(.black)
                          .font(.headline)
                          .frame(maxWidth: .infinity)
                          .padding()
                          .background(Color.yellow)
                          .cornerRadius(25)
                  }
                  .onChange(of: loginVM.status){
                      if loginVM.status ?? false{
                          self.isNavigating = true
                      }
                  }
                  
                  Spacer()
              }
              .blur(radius: loginVM.isLoading ?? false ? 2 : 0)
              .padding()
              .onAppear {
                  loginVM.status = false
              }
              .overlay {
                  if loginVM.isLoading ?? false {
                      ProgressView()
                  }
              }
              .navigationDestination(isPresented: $isNavigating) {
                  OTPVerificationView(loginVM: self.loginVM)
               }
          }
      }
          
}

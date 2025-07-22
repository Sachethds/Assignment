//
//  LoginVM.swift
//  Assignment
//
//  Created by SACHETH D S. on 22/07/25.
//

import Foundation

@MainActor
class LoginVM: ObservableObject  {
    @Published var mobileNumber: String
    @Published var countryCode: String
    @Published var otp: String
    @Published var status: Bool?
    @Published var token: String?
    @Published var isLoading: Bool?
    
    let loginServices: LoginNetworking
    init(loginServices: LoginNetworking = LoginNetworkService(apiRequest: APIRequest(apiManager: APIManager()))) {
        self.loginServices = loginServices
        mobileNumber = ""
        countryCode = "+91"
        otp = ""
    }

    func login() async {
        isLoading = true
        defer {isLoading = false}
        
        let loginRequest = LoginRequest(number: "\(countryCode)\(mobileNumber)")
        var apiData = APIData(url: APPURL.login.url, parameters: loginRequest)
        do {
            let loginResponse: LoginModel? = try await self.loginServices.login(apiData: &apiData)
            status = loginResponse?.status
        } catch let error as ErrorHandling {
            print(error.errorDescription ?? "")
        } catch {
            print("unknown error \(error.localizedDescription)")
        }
    }
    
    func verifyOtp() async {
        
        isLoading = true
        defer {isLoading = false}
        
        let otpRequest = VerifyOtpRequest(number: "\(countryCode)\(mobileNumber)", otp: otp)
        var apiData = APIData(url: APPURL.verification.url, parameters: otpRequest)
        do {
            let verifyResponse: OTPVerificationModel? = try await self.loginServices.verifyOTP(apiData: &apiData)
            self.token = verifyResponse?.token
            UserDefaults.standard.set(token, forKey: "token")
        } catch let error as ErrorHandling {
            print(error.errorDescription ?? "")
        } catch {
            print("unknown error \(error.localizedDescription)")
        }
    }
}

struct LoginRequest: Codable {
    var number: String
}

struct VerifyOtpRequest: Codable {
    var number: String
    var otp: String
}

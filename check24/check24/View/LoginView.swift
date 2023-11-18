//
//  LoginView.swift
//  check24
//
//  Created by Georgy Chomakhashvili on 18.11.23.
//

import SwiftUI

struct LoginView: View {
    
    @State var name: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                Spacer()
                
                TextField("Name",
                          text: $name ,
                          prompt: Text("Login").foregroundColor(.blue)
                )
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(.horizontal)
                
                HStack {
                    Group {
                        if showPassword { // when this changes, you show either TextField or SecureField
                            TextField("Password",
                                      text: $password,
                                      prompt: Text("Password").foregroundColor(.red)) // How to change the color of the TextField Placeholder
                        } else {
                            SecureField("Password", // how to create a secure text field
                                        text: $password,
                                        prompt: Text("Password").foregroundColor(.red)) // How to change the color of the TextField Placeholder
                        }
                    }
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.red, lineWidth: 2) // How to add rounded corner to a TextField and change it colour
                    }
                    
                }.padding(.horizontal)
                
                Spacer()
                NavigationLink(destination: Home()
                    .navigationBarBackButtonHidden(true)) {
                    Text("Sign In")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(20)
                .padding()
            }
        }
    }
}

#Preview {
    LoginView()
}

//
//  AccountView.swift
//  Social-Reality
//
//  Created by Nick Crews on 6/22/21.
//

import SwiftUI
import Combine

class AccountViewModel: ObservableObject {
    
    @Published public var user: UserModel
    private let defaultUser = Testing.defaultUser
    
    init(user: UserModel?) {
        if let user = user {
            self.user = user
        } else {
            self.user = defaultUser
        }
        
    }

}

struct AccountHeaderView: View {
    
    @ObservedObject public var viewModel = AccountViewModel(user: nil)
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    print("button pressed")
                }) {
                    Image(systemName: "gear")
                }
                Spacer()
                Text(viewModel.user.first)
                    .font(.headline)
                Spacer()
                Button(action: {
                    print("button pressed")
                }) {
                    Image(systemName: "person.crop.circle.fill.badge.plus")
                }
            }
            .padding(.horizontal, .l1)
            .padding(.vertical, .m2)
            Divider()
        }
        
    }
    
}

struct AccountView: View {
    
    @ObservedObject private var viewModel = AccountViewModel(user: nil)
    
    var body: some View {
        
        VStack {
            AccountHeaderView(viewModel: viewModel)
            PKCircleImage(image: Images.profileImageDefault.rawValue, size: 100)
            Text(viewModel.user.username)
                .font(.title3)
            HStack(alignment: .center) {
                VStack {
                    Text("0")
                        .font(.title2)
                    Text("Posts")
                        .font(.caption)
                }
                VStack {
                    Text("0")
                        .font(.title2)
                    Text("Followers")
                        .font(.caption)
                }
                .padding(.horizontal, .m2)
                .padding(.vertical, .s1)
                VStack {
                    Text("0")
                        .font(.title2)
                    Text("Likes")
                        .font(.caption)
                }
                
            }
            Button(action: {
                print("button pressed")
            }) {
                Text("Edit Profile")
            }
            .buttonStyle(PKSquareBorderedButton())
            .padding(.vertical, .s3)
            
            Spacer()
        }
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

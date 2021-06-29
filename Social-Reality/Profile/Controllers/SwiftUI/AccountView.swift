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
    
    public var title: String
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    print("button pressed")
                }) {
                    Image(systemName: "gear")
                }
                Spacer()
                Text(title)
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
        }
        
    }
    
}

struct AccountInformationView: View {
    
    @ObservedObject public var viewModel = AccountViewModel(user: nil)
    
    var body: some View {
        
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
        .padding(.top, .s3)
        .padding(.bottom, .m3)
        
        
    }
}

struct AccountSectionView: View {
    @State private var favoriteColor = 0
    
    var body: some View {
        VStack {
            Picker(selection: $favoriteColor, label: Text("What is your favorite color?")) {
                Image(systemName: "square.grid.2x2.fill").tag(0)
                Image(systemName: "drop.fill").tag(1)
                Image(systemName: "heart.fill").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())

        }
    }
    
}


struct AccountView: View {
    
    @ObservedObject private var viewModel = AccountViewModel(user: nil)
    
    var body: some View {
        
        VStack {
            AccountHeaderView(title: viewModel.user.first)
            Divider()
            AccountInformationView(viewModel: viewModel)
            Divider()
            AccountSectionView()
            Spacer()

        }
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

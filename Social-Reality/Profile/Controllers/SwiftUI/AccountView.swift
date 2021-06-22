//
//  AccountView.swift
//  Social-Reality
//
//  Created by Nick Crews on 6/22/21.
//

import SwiftUI
import Combine

class AccountViewModel: ObservableObject {
    
    @Published var user: UserModel?
    
    init(user: UserModel?) {
        self.user = user
    }
    
}

struct AccountView: View {
    
//    @ObservedObject private var viewModel = AccountViewModel(user: nil)
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

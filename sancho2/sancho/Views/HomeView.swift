//
//  HomeView.swift
//  sancho
//
//  Created by Felipe Passos on 23/06/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewCode = HomeViewModel()
    
    var body: some View {
        Text("Home View")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

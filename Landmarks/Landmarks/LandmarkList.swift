/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a list of landmarks.
*/

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject private var userData: UserData
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationView {
            List {
                
                
                SearchBar(text: $searchTerm)
                
                Toggle(isOn: $userData.showFavoritesOnly) {
                    Text("Show Favorites Only")
                }
                
                /* Cite - https://stackoverflow.com/questions/56490963/how-to-display-a-search-bar-with-swiftui */
                ForEach(self.searchTerm.isEmpty ? userData.landmarks : userData.landmarks.filter {
                    return $0.name.localizedCaseInsensitiveContains(self.searchTerm)
                } ) { landmark in
                    if !self.userData.showFavoritesOnly || landmark.isFavorite {
                       NavigationLink(
                           destination: LandmarkDetail(landmark: landmark)
                               .environmentObject(self.userData)
                       ) {
                           LandmarkRow(landmark: landmark)
                       }
                    }
                }
         }
            .navigationBarTitle(Text("Landmarks"))
    }
}

struct LandmarksList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
        .environmentObject(UserData())
    }
}
}

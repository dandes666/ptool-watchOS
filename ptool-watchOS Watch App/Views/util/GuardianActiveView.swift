//
//  GuardianActiveView.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-09-30.
//

import SwiftUI

struct GuardianActiveView: View {
    @EnvironmentObject var db: AppManager
    var body: some View {
        Toggle(isOn: $db.guardianActive) {
            Text("Notification")
        }
    }
}

struct GuardianActiveView_Previews: PreviewProvider {
    static var previews: some View {
        GuardianActiveView()
    }
}

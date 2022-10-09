//
//  MotherView.swift
//  AuthenticationStarter
//
//  Created by Work on 13.12.21.
//

import SwiftUI
import Firebase
import UserNotifications

struct MotherView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        switch viewRouter.currentPage {
//        case .signUpPage:
//            SignUpView()
        case .signInPage:
            SignInView()
        case .homePage:
            HomeView()
        case .welcomePage:
            WelcomeView()
        case .loadingPage:
            LoadingView()
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                didReceive response: UNNotificationResponse,
                withCompletionHandler completionHandler:
                   @escaping () -> Void) {
       // Get the meeting ID from the original notification.
        print("trace reponse de notification")
       let userInfo = response.notification.request.content.userInfo
            
       if response.notification.request.content.categoryIdentifier ==
                  "MEETING_INVITATION" {
          // Retrieve the meeting details.
          let meetingID = userInfo["MEETING_ID"] as! String
          let userID = userInfo["USER_ID"] as! String
                
          switch response.actionIdentifier {
          case "ACCEPT_ACTION":
//             sharedMeetingManager.acceptMeeting(user: userID, meetingID: meetingID)
             break
                    
          case "DECLINE_ACTION":
//             sharedMeetingManager.declineMeeting(user: userID, meetingID: meetingID)
             break
                    
          case UNNotificationDefaultActionIdentifier,
               UNNotificationDismissActionIdentifier:
             // Queue meeting-related notifications for later
             //  if the user does not act.
//             sharedMeetingManager.queueMeetingForDelivery(user: userID, meetingID: meetingID)
             break
                    
          default:
             break
          }
       }
       else {
          // Handle other notification types...
       }
            
       // Always call the completion handler when done.
       completionHandler()
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}

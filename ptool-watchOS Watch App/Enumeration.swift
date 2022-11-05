//
//  Enumeration.swift
//  ptool-watchOS Watch App
//
//  Created by Dave Thibeault on 2022-10-23.
//

import Foundation

enum MasterRoute: Hashable {
    case reportList
    case deliveryNoteList
    case config
    case tool
    case complete
    case error
}
enum ToolRoute: Hashable {
    case fullbox
    case memo
}
enum ConfigRoute: Hashable {
    case officeSelect
    case routeSelect
    case userEdit
    case guardianSetting
}
enum Page {
//    case signUpPage
    case welcomePage
    case signInPage
    case loadingPage
    case homePage
}
enum TaskStatus {
    case none
    case inProgress
    case error
    case done
    case pause
    case success
}
enum MemoDest {
    case comitemixte
    case supervisor
}
enum MemoType {
    case officeReminder
    case messToSupervisor
    case messToComiteMixte
    case memoOnly
}
enum MemoListMode {
    case standart
    case officeSelected
    case paramFecth
    case memoSelect
}
enum AudioPlayerStatus {
    case stop
    case play
    case pause
}
enum AudioPlayerMode {
    case standard
    case buttonPlayOnly
    case buttonPLayAndTimeleft
    case buttonAndDetail
}
enum PdrType {
    case appartement
    case domicile
    case ferme
    case commerce
}
enum PdrTpType {
    case dtd
    case cmb
    case lba
    case aptlba
    case ksk
    case dflb
    case rmb
    case cntr
}

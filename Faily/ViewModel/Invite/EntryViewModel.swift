//
//  EntryViewModel.swift
//  Faily
//
//  Created by 구본의 on 2021/10/02.
//

import Foundation

class EntryViewModel {
    weak var entryView: ParticipantViewController?
    let useService = EntryService()
    
    func postEntryChat(_ parameters: EntryRequest) {
        useService.postEntryChat(parameters, onCompleted: { [weak self] response in
            guard let self = self else {return}
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                print("채팅방에 참가하였습니다. 참가한 채팅방 코드는 \(parameters.group_code)")
            }
        }, onError: {error in
            print("EntryViewModel - \(error)")
        })
    }
}

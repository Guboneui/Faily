//
//  EntryService.swift
//  Faily
//
//  Created by 구본의 on 2021/10/02.
//

import Foundation

class EntryService {
    let repository: EntryRepository = EntryRepository()
    
    func postEntryChat(_ parameters: EntryRequest, onCompleted: @escaping (EntryResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.postEntryChat(parameters, onCompleted: {response in
            let responseData = EntryResponse(isSuccess: response.isSuccess, code: response.code, message: response.message)
            onCompleted(responseData)
        }, onError: onError)
    }
}

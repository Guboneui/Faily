//
//  PostMakeEmoticonViewModel.swift
//  Faily
//
//  Created by 구본의 on 2021/11/02.
//

import Foundation

class PostMakeEmoticonViewModel {
    weak var makeEmoticonView: EmoticonPopUpViewController?
    
    let useService: PostMakeEmoticonService = PostMakeEmoticonService()
    
    func postMakeEmoticon(_ parameters: PostMakeEmoticonRequest) {
        useService.postMakeEmoticon(parameters, onCompleted: {[weak self] response in
            guard let self = self else {return}
            if response.isSuccess == true {
                print("이모티콘 만들기 성공")
            } else {
                print("이모티콘 만들기 실패")
            }
        }, onError: {error in
            print("\(error)")
        })
    }
}

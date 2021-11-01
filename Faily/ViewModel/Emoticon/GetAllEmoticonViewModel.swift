//
//  GetAllEmoticonViewModel.swift
//  Faily
//
//  Created by 구본의 on 2021/11/01.
//

import Foundation

class GetAllEmoticonViewModel {
    let useService: GetAllEmoticonService = GetAllEmoticonService()
    let deleteService: PostDeleteEmoticonService = PostDeleteEmoticonService()
    weak var emoticonView: EmoticonBoxViewController?
    
    var emoticonBox: [EmoticonInfo] = [] {
        didSet{
            self.emoticonView?.emoticonBoxCollectionView.reloadData()
        }
        
    }
    
    func getAllEmoticon(){
        useService.getAllEmoticon(onCompleted: {[weak self] response in
            guard let self = self else {return}
            if response.isSuccess == true {
                print("이모티콘을 불러 왔습니다.")
                self.emoticonBox = response.result!
            } else {
               print("이모티콘을 불러오지 못했습니다.")
            }
        }, onError: { error in
            print("\(error)")
        })
    }
    
    func postDeleteEmoticon(_ parameter: PostDeleteEmoticonRequest) {
        deleteService.postDeleteEmoticon(parameter, onCompleted: {[weak self] response in
            if response.isSuccess == true {
                print("이모티콘 삭제 성공")
            } else {
                print("이모티콘 삭제 실패")
            }
        }, onError: {error in
            print(error)
        })
    }
}

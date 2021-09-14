//
//  AgreeAuthorityViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/14.
//

import UIKit
import AVFoundation
import Photos

class AgreeAuthorityViewController: UIViewController {
    
    
    @IBOutlet weak var agreeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    func configUI() {
        
    }
    
    @IBAction func agreeButtonAction(_ sender: Any) {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { didAllow, error in
            if didAllow == true {
                print("알림 권한을 허용했습니다.")
            } else {
                print("알림 권한을 거부했습니다.")
            }
            
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    print("Camera: 권한 허용")
                } else {
                    print("Camera: 권한 거부")
                }
                
                PHPhotoLibrary.requestAuthorization( { status in
                    switch status{
                    case .authorized:
                        print("Album: 권한 허용")
                    case .denied:
                        print("Album: 권한 거부")
                    case .restricted, .notDetermined:
                        print("Album: 선택하지 않음")
                    default:
                        break
                    }
                })
            })
        })
    }
}

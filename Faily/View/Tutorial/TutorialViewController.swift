//
//  TutorialViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import UIKit

class TutorialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        self.navigationItem.backButtonTitle = ""
        self.title = "시작하기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
    }
    
    @IBAction func goFounderVCButtonAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Tutorial", bundle: nil)
        let founderVC = storyBoard.instantiateViewController(withIdentifier: "FounderViewController")
        self.navigationController?.pushViewController(founderVC, animated: true)
    }
    
    @IBAction func goParticipantVCButtonAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Tutorial", bundle: nil)
        let participantVC = storyBoard.instantiateViewController(withIdentifier: "ParticipantViewController")
        self.navigationController?.pushViewController(participantVC, animated: true)
    }
    
    
}

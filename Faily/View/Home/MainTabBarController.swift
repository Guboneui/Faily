//
//  MainTabBar.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    var homeButton: UIButton!
    var goChatView: UIView!
    var backgroundImg: UIImageView!
    var middleLabel: UILabel!
    
    private var shapeLayer: CALayer?
    
    private var shouldAllowPan: Bool = false
    private var isLongPressed: Bool = false
    
    
    
    override func loadView() {
        super.loadView()
        configUI()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 2
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(selectedIndex)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == (self.tabBar.items!)[2]{
            homeButton.setBackgroundImage(UIImage(named: "home_tab_selected"), for: .normal)
            }
        else {
            homeButton.setBackgroundImage(UIImage(named: "home_tab_default"), for: .normal)
        }
    }
   
    
    private func configUI() {
        
        let bounds: CGRect = UIScreen.main.bounds
        let height: CGFloat = bounds.size.height
        let k = height * 0.7
        
        self.goChatView = UIView(frame: CGRect(x: (self.view.frame.width / 2) - 40, y: height - k, width: 80, height: 80))
        goChatView.backgroundColor = UIColor.FailyColor.gradient4
        goChatView.layer.cornerRadius = 20
        goChatView.isHidden = true
        self.view.addSubview(goChatView)
        
        
        self.middleLabel = UILabel()
        middleLabel.translatesAutoresizingMaskIntoConstraints = false
        middleLabel.text = "채팅"
        middleLabel.textColor = UIColor.FailyColor.grayscale_4
        middleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        middleLabel.textAlignment = .center
        self.goChatView.addSubview(middleLabel)
        
        NSLayoutConstraint.activate([
            middleLabel.widthAnchor.constraint(equalTo: goChatView.widthAnchor),
            middleLabel.heightAnchor.constraint(equalTo: goChatView.heightAnchor),
            middleLabel.topAnchor.constraint(equalTo: goChatView.topAnchor, constant: 0),
            middleLabel.leadingAnchor.constraint(equalTo: goChatView.leadingAnchor, constant: 0)
        ])
        
        
        
//
        print(self.tabBar.frame.size.width)
        print(self.tabBar.frame.size.height)
        self.backgroundImg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        backgroundImg.image = UIImage(named: "Home_BottomNav")
        backgroundImg.contentMode = UIView.ContentMode.scaleAspectFill
        backgroundImg.alpha = 0.7
        backgroundImg.layer.cornerRadius = 15
        backgroundImg.clipsToBounds = true
        self.tabBar.addSubview(backgroundImg)
        
        self.homeButton = UIButton(frame: CGRect(x: (self.view.bounds.width / 2) - 30, y: -30, width: 60, height: 60))
        self.homeButton.layer.cornerRadius = self.homeButton.frame.size.height / 2
        homeButton.backgroundColor = .clear
        homeButton.imageView?.contentMode = .scaleAspectFill
        //homeButton.setImage(UIImage(named: "button_background"), for: .normal)
        
        if selectedIndex == 2 {
            homeButton.setBackgroundImage(UIImage(named: "home_tab_selected"), for: .normal)
        } else {
            homeButton.setBackgroundImage(UIImage(named: "home_tab_default"), for: .normal)
        }
        self.tabBar.addSubview(homeButton)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        panGesture.delegate = self
        self.panGesture(panGesture)
        homeButton.addGestureRecognizer(panGesture)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longGesture))
        homeButton.addGestureRecognizer(longPressGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        homeButton.addGestureRecognizer(tapGesture)
        
        
        //homeButton.addTarget(self, action: #selector(homeButtonAction), for: .touchUpInside)
        
        self.tabBar.sendSubviewToBack(self.backgroundImg)
        self.tabBar.backgroundColor = .clear
        
        self.view.bringSubviewToFront(self.homeButton)
    }
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        let position = recognizer.translation(in: self.view)
        let view = recognizer.view
        switch recognizer.state {
        case .changed:
            let maxValue: CGFloat = 50
            var now = position.y.magnitude
            
            if now > maxValue {
                now = maxValue
            }
            
            //홈화면 버튼 크기 변경 코드
            var newScale: CGFloat = 1 //- ((now / maxValue) * 0.2)
            
            if let previousScale = view?.transform.d {
                newScale = CGFloat.minimum(newScale, previousScale)
            }
            let transform = CGAffineTransform(translationX: position.x, y: position.y).scaledBy(x: newScale, y: newScale)
            view?.transform = transform
            
            
            
            let aaa = recognizer.location(in: self.goChatView)
            
            let isOnX = 0...self.goChatView.frame.width ~= aaa.x
            let isOnY = 0...self.goChatView.frame.height ~= aaa.y
            
            let isOn = isOnY && isOnX
            
            //뷰가 안에 들어가게 되었을 때 원으로 변경
            let color: UIColor = (isOn) ? UIColor.FailyColor.secondaryPinkColor : UIColor.FailyColor.gradient4
            let radius: CGFloat = isOn ? self.goChatView.frame.height / 2 : 20
            UIView.animate(withDuration: 0.5) {
                //self.middleLabel.textColor = .white
                self.goChatView.backgroundColor = color
                self.goChatView.layer.cornerRadius = radius
            }
            
        case .ended:
            
            self.isLongPressed = false
            
            if goChatView.backgroundColor == UIColor.FailyColor.secondaryPinkColor {
                DispatchQueue.main.async {
                    
                    
                    let storyBoard = UIStoryboard(name: "Home", bundle: nil)
                    let chatVC = storyBoard.instantiateViewController(withIdentifier: "ChatViewController")
                    self.present(chatVC, animated: true, completion: nil)
                }
            }
            
            //뷰 원래 자리로 이동
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                view?.transform = .identity
                //self.goChatView.backgroundColor = UIColor.FailyColor.secondaryPinkColor
                self.goChatView.backgroundColor = UIColor.FailyColor.gradient4
                self.goChatView.layer.cornerRadius = 20
            }, completion: nil)
            print("End")
            
            
        default:
            break
            
        }
    }
    
    @objc
    func longGesture(_ recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            goChatView.isHidden = false
            HapticsManager.shared.impact()
            print("Long pressed - Start")
            guard let view = recognizer.view else { return }
            
            self.isLongPressed = true
            
            view.layer.zPosition = -(view.layer.zPosition)
            UIView.animate(withDuration: 0.4) {
                recognizer.view?.alpha = 1
            }
            
        case .changed:
            shouldAllowPan = true
            
            
        case .ended:
            goChatView.isHidden = true
            print("Long pressed - End")
            shouldAllowPan = false
            guard let view = recognizer.view else { return }
            self.isLongPressed = false
            
            UIView.animate(withDuration: 0.4, animations: {
                recognizer.view?.alpha = 1
            }) { _ in
                view.layer.zPosition = -(view.layer.zPosition)
            }
            
            
            
        default:
            break
        }
    }
    
    @objc func tapGesture(_ recognizer: UITapGestureRecognizer) {
        self.selectedIndex = 2
        homeButton.setBackgroundImage(UIImage(named: "home_tab_selected"), for: .normal)
    }
    
    @objc func homeButtonAction() {
        print(1)
    }
}

extension MainTabBarController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if((gestureRecognizer is UIPanGestureRecognizer) && (shouldAllowPan == false)) {
            return false
        }
        return true
    }
    
}

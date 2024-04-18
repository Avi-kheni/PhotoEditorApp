//
//  ViewController.swift
//  PhotoEditorApp
//
//  Created by Avi Kheni on 17/04/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initConfig()
    }
    //MARK: Initial Setup
    func initConfig() {
        CameraPhotoControllerVC.shared.currentVC = self
        CameraPhotoControllerVC.shared.imagePickedBlock = { img in
            DispatchQueue.main.async {
                
                let vc = StoryBoardEnum.getMainStoryBoard().instantiateViewController(identifier: IdentifierName.editVC.rawValue) as? EditVC
                vc?.image = img
                vc?.modalPresentationStyle = .currentContext
                self.navigationController?.present(vc!, animated: false)
            }
            
        }
    }
//MARK: Take Photo Btn Action
    @IBAction func takePohotBtnAction( _ sender : UIButton) {
        CameraPhotoControllerVC.shared.askForCameraPermission()
    }
}


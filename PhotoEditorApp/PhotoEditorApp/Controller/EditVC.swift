//
//  EditVC.swift
//  PhotoEditorApp
//
//  Created by Avi Kheni Mac on 18/04/24.
//

import UIKit

class EditVC: UIViewController {

    @IBOutlet weak var viewOutlet: UIView!
    @IBOutlet weak var imageViewOutlet: JLStickerImageView!
    @IBOutlet weak var addTxtBtnOutlet: UIButton!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        iniConfig()
    }
    //MARK: Initial Setup
    func iniConfig() {
        self.collectionViewOutlet.dataSource = self
        self.collectionViewOutlet.delegate = self
        self.collectionViewOutlet.registerUINib(identifier: .filterXibCell)
        self.collectionViewOutlet.isHidden = false
        self.addTxtBtnOutlet.isHidden = true
        self.imageViewOutlet.image = image
    }

    //MARK: Segment Btn Action
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        handleSegment(currentIndex: sender.selectedSegmentIndex)
    }
    
    //MARK: Close Btn Action
    @IBAction func closeBtnAction(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
    
    //MARK: Share Btn Action
    @IBAction func shareBtnAction(_ sender: UIButton) {
        var image = makeImageFrom(self.viewOutlet)
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
           activityVC.popoverPresentationController?.sourceView = self.view
           self.present(activityVC, animated: true, completion: nil)

    }
    
    //MARK: Add Text Btn Action
    @IBAction func addTextBtnAction(_ sender: UIButton) {
        self.imageViewOutlet.addLabel()
        self.imageViewOutlet.textColor = UIColor.black
        self.imageViewOutlet.textAlpha = 1
        self.imageViewOutlet.currentlyEditingLabel.closeView!.image = UIImage(systemName: "xmark.circle.fill")
        self.imageViewOutlet.currentlyEditingLabel.rotateView?.image = UIImage(systemName: "arrow.circlepath")
        self.imageViewOutlet.currentlyEditingLabel.border?.strokeColor = UIColor.gray.cgColor
        self.imageViewOutlet.currentlyEditingLabel.labelTextView?.font =  UIFont.italicSystemFont(ofSize: 25.0)
        self.imageViewOutlet.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
        
    }
   
    //MARK: Handling Segment Control
    func handleSegment(currentIndex : Int) {
        self.collectionViewOutlet.isHidden = currentIndex != 0
        self.addTxtBtnOutlet.isHidden = currentIndex == 0
    }
}


// MARK: Collection of filter
extension EditVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FilterType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdentifierName.filterXibCell.rawValue, for: indexPath) as? FilterCollectionCell else {
            return UICollectionViewCell() }
 
            var filterType = FilterType.allCases[indexPath.row]
            cell.filterImgViewOutlet.image = self.image?.addFilter(filter: filterType)
            cell.filterNameLblOutlet.text = filterType.caseName()
        
        return cell
    }
    
    
}

//MARK: Collection view Delegate and FlowLayout
extension EditVC : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var filterType = FilterType.allCases[indexPath.row]
        self.imageViewOutlet.image =  self.image?.addFilter(filter: filterType)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 200)
    }
    
}

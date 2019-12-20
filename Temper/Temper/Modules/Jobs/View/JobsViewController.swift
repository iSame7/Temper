//
//  JobsViewController.swift
//  Temper
//
//  Created by Sameh Mabrouk on 15/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit

class JobsViewController: StatusBarAnimatableViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var floatingView: FloatingView! {
        didSet {
            floatingView.isHidden = true
        }
    }
    @IBOutlet weak var signupOrLoginView: SignupOrLoginView! {
        didSet {
            signupOrLoginView.isHidden = true
            signupOrLoginView.delegate = self
        }
    }
    
    // MARK: - Properties
    
    var presenter: JobsPresentable!
    
    private var transition: CardTransition?

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        presenter.getJobs()
    }
    
    override var statusBarAnimatableConfig: StatusBarAnimatableConfig {
        return StatusBarAnimatableConfig(prefersHidden: false,
                                         animation: .slide)
    }
    
    // MARK: - Helpers
    
    private func setupCollectionView() {
        // Make it responds to highlight state faster
        collectionView.delaysContentTouches = false

        addRefreshControl()
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = .init(top: 20, left: 0, bottom: 64, right: 0)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.clipsToBounds = false
        collectionView.register(UINib(nibName: "\(CardCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "card")
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: "sectionHeader")
    }
}

// MARK: - StoryboardInstantiatable

extension JobsViewController: StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType {
        return .initial
    }
    
    static var storyboardName: String {
        return StoryboardName.jobs.rawValue
    }
}

// MARK: - PullToRefreshActionHandling

extension JobsViewController: PullToRefreshActionHandling {
    var pullTpRefreshControl: UIRefreshControl? {
        get {
            return collectionView.refreshControl
        }
        set {
            collectionView.refreshControl = newValue
        }
    }
    
    func refreshControlValueChanged() {
        presenter.refreshJobs()
    }
}

// MARK: - JobsViewable

extension JobsViewController: JobsViewable {
    func update() {
        endRefreshingIfNeeded()
        collectionView.reloadData()
        
        floatingView.isHidden = false
        signupOrLoginView.isHidden = false 
    }
    
    func showError(error: TemperError) {
        if let errorDescription = error.errorDescription, let errorTitle = error.errorUserInfo[NSLocalizedDescriptionKey] as? String {
            InAppNotifications.showNotification(type: InAppNotifications.error, title: errorTitle, message: errorDescription, dismissDelay: 3)
        }
        
        endRefreshingIfNeeded()
    }
}

// MARAK: - SignupOrLoginViewDelegate

extension JobsViewController: SignupOrLoginViewDelegate {
    func didTapSignupButton() {
        presenter.didTapSignupButton()
    }
    
    func didTapLoginButton() {
        presenter.didTapLoginButton()
    }
}

extension JobsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection(index: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "card", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! CardCollectionViewCell
        cell.cardContentView.viewModel = presenter.itemAtIndex(index: indexPath.item, in: indexPath.section)
        
        // Pagination e.g. load more jobs when scrolling at the bottom of the collection view
        if let itemsAtSection = presenter.itemsAt(section: indexPath.section), indexPath.row == itemsAtSection.count - 1, indexPath.section == presenter.numberOfSections() - 1 {
            presenter.getMoreJobs()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as! SectionHeader
            
            sectionHeader.label.text = presenter.sectionHeaderAt(index: indexPath.section)
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
}

extension JobsViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cardHorizontalOffset: CGFloat = 20
        let cardHeightByWidthRatio: CGFloat = 1.2
        let width = collectionView.bounds.size.width - 2 * cardHorizontalOffset
        let height: CGFloat = width * cardHeightByWidthRatio
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Get tapped cell location
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell else {
            return
        }
        
        // Freeze highlighted state (or else it will bounce back)
        cell.freezeAnimations()
        
        // Get current frame on screen
        let currentCellFrame = cell.layer.presentation()!.frame
        
        // Convert current frame to screen's coordinates
        let cardPresentationFrameOnScreen = cell.superview!.convert(currentCellFrame, to: nil)
        
        // Get card frame without transform in screen's coordinates  (for the dismissing back later to original location)
        let cardFrameWithoutTransform = { () -> CGRect in
            let center = cell.center
            let size = cell.bounds.size
            let r = CGRect(
                x: center.x - size.width / 2,
                y: center.y - size.height / 2,
                width: size.width,
                height: size.height
            )
            return cell.superview!.convert(r, to: nil)
        }()
        
        guard let cardModel = presenter.itemAtIndex(index: indexPath.item, in: indexPath.section) else {
            return
        }
        
        // Set up card detail view controller
        let vc = storyboard!.instantiateViewController(withIdentifier: "cardDetailVc") as! CardDetailViewController
        vc.cardViewModel = cardModel.highlightedImage()
        vc.unhighlightedCardViewModel = cardModel // Keep the original one to restore when dismiss
        let params = CardTransition.Params(fromCardFrame: cardPresentationFrameOnScreen,
                                           fromCardFrameWithoutTransform: cardFrameWithoutTransform,
                                           fromCell: cell)
        transition = CardTransition(params: params)
        vc.transitioningDelegate = transition
        
        // If `modalPresentationStyle` is not `.fullScreen`, this should be set to true to make status bar depends on presented vc.
        vc.modalPresentationCapturesStatusBarAppearance = true
        vc.modalPresentationStyle = .custom
        
        present(vc, animated: true, completion: { [unowned cell] in
            // Unfreeze
            cell.unfreezeAnimations()
        })
    }
}

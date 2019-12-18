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
    
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Properties
    
    var presenter: JobsPresentable!
    
    private var transition: CardTransition?
    
    private lazy var cardModels: [CardContentViewModel] = [
        CardContentViewModel(primary: "GAME OF THE DAY",
                             secondary: "Minecraft makes a splash",
                             description: "The ocean is a big place. Tap to read how Minecraft's just got even bigger.",
                             image: #imageLiteral(resourceName: "drowning").resize(toWidth: UIScreen.main.bounds.size.width * (1/Constants.CardAnimation.cardHighlightedFactor))),
        CardContentViewModel(primary: "You won't believe this guy",
                             secondary: "Something we want",
                             description: "They have something we want which is not something we need.",
                             image: #imageLiteral(resourceName: "img2.jpg").resize(toWidth: UIScreen.main.bounds.size.width * (1/Constants.CardAnimation.cardHighlightedFactor))),
        CardContentViewModel(primary: "LET'S PLAY",
                             secondary: "Cats, cats, cats!",
                             description: "Play these games right meow.",
                             image: #imageLiteral(resourceName: "img1.png").resize(toWidth: UIScreen.main.bounds.size.width * (1/Constants.CardAnimation.cardHighlightedFactor)))
    ]
    
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

// MARK: - JobsViewable

extension JobsViewController: JobsViewable {
    func update(_ jobs: [String : [Job]]) {
        collectionView.reloadData()
    }
    
    func showError(error: Error) {
    }
}

extension JobsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.jobs?.keys.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection(index: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "card", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! CardCollectionViewCell
        cell.cardContentView?.viewModel = presenter.buildCardContentViewModels()[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as! SectionHeader
            sectionHeader.label.text = "TRENDING"
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
        
        let cardModel = cardModels[indexPath.row]
        
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

extension JobsViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // UITableView only moves in one direction, y axis
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 10.0 {
            presenter.getJobs()
        }
    }
}

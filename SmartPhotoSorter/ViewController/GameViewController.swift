//
//  GameViewController.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 05.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit
import SKPhotoBrowser
import Rswift

private enum Constants {
	static let photoCollectionViewCell = "photoCollectionViewCell"
}

class GameViewController: BaseViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	fileprivate var longPressGesture: UILongPressGestureRecognizer!

	var viewModel: GameViewModel? = nil

	override func viewDidLoad() {
		super.viewDidLoad()

		// Static setup
		SKPhotoBrowserOptions.displayAction = true
		SKPhotoBrowserOptions.displayStatusbar = true
		SKPhotoBrowserOptions.displayCounterLabel = true
		SKPhotoBrowserOptions.displayBackAndForwardButton = true

		self.setupCollectionView()

		self.title = viewModel?.pageTitle
	}

	override var prefersStatusBarHidden: Bool {
		return false
	}

	@IBAction func finishBarButtonItemTap(sender: UIBarButtonItem) {

		let alert = UIAlertController(title: R.string.localizable.gameFinishTitle(), message: R.string.localizable.gameFinishDescription(), preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: R.string.localizable.gameFinishDone(), style: .default, handler: { action in

			print("Save")
			// self.viewModel.
			// inform user about result

			// goto score list
		}))
		alert.addAction(UIAlertAction(title: R.string.localizable.gameFinishCancel(), style: .cancel, handler: nil))
		self.present(alert, animated: true)
	}

	override func handleThemeChanged() {
		super.handleThemeChanged()

		let theme = ThemeManager.currentTheme()
		self.collectionView.backgroundColor = theme.backgroundColor
	}
}

// MARK: - UICollectionViewDataSource
extension GameViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.viewModel?.amountOfImages() ?? 0
	}

	@objc(collectionView: cellForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.photoCollectionViewCell, for: indexPath) as? PhotoCollectionViewCell else {
			return UICollectionViewCell()
		}

		cell.photoImageView.image = self.viewModel?.image(at: indexPath.row)
		cell.photoImageView.contentMode = .scaleAspectFill

		return cell
	}
}

// MARK: - UICollectionViewDelegate
extension GameViewController: UICollectionViewDelegate {

	@objc(collectionView: didSelectItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		let browser = SKPhotoBrowser(photos: self.viewModel?.allPhotos ?? [], initialPageIndex: indexPath.row)

		browser.delegate = self

		present(browser, animated: true, completion: { })
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {

		if UIDevice.current.userInterfaceIdiom == .pad {
			return CGSize(width: UIScreen.main.bounds.size.width / 2 - 5, height: 300)
		} else {
			return CGSize(width: UIScreen.main.bounds.size.width / 2 - 5, height: 200)
		}
	}

	// enable drag'n'drop
	func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
		return true
	}

	func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

		// current game swap images
		let fromIndex = sourceIndexPath.row
		let toIndex = destinationIndexPath.row

		if fromIndex < toIndex {
			for index in fromIndex..<toIndex {
				self.viewModel?.swap(source: index, destination: index + 1)
			}
		} else {
			for index in (toIndex..<fromIndex).reversed() {
				self.viewModel?.swap(source: index, destination: index + 1)
			}
		}

		if let score = self.viewModel?.score() {
			print("score: \(score)")
		}

		self.collectionView.reloadData()
	}
}

// MARK: - SKPhotoBrowserDelegate
extension GameViewController: SKPhotoBrowserDelegate {

	func didShowPhotoAtIndex(_ index: Int) {
		self.collectionView.visibleCells.forEach({ $0.isHidden = false })
		self.collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = true
	}

	func willDismissAtPageIndex(_ index: Int) {
		self.collectionView.visibleCells.forEach({ $0.isHidden = false })
		self.collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = true
	}

	func willShowActionSheet(_ photoIndex: Int) {
		// do some handle if you need
	}

	func didDismissAtPageIndex(_ index: Int) {
		self.collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = false
	}

	func didDismissActionSheetWithButtonIndex(_ buttonIndex: Int, photoIndex: Int) {
		// handle dismissing custom actions
	}

	func removePhoto(_ browser: SKPhotoBrowser, index: Int, reload: @escaping (() -> Void)) {
		reload()
	}

	func viewForPhoto(_ browser: SKPhotoBrowser, index: Int) -> UIView? {
		return self.collectionView.cellForItem(at: IndexPath(item: index, section: 0))
	}

	func captionViewForPhotoAtIndex(index: Int) -> SKCaptionView? {
		return nil
	}
}

// MARK: - private
private extension GameViewController {

	func setupCollectionView() {
		self.collectionView.delegate = self
		self.collectionView.dataSource = self

		self.longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
		self.collectionView.addGestureRecognizer(longPressGesture)
	}

	@objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
		switch(gesture.state) {

		case .began:
			guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
				break
			}
			self.collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
		case .changed:
			self.collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
		case .ended:
			self.collectionView.endInteractiveMovement()
		default:
			self.collectionView.cancelInteractiveMovement()
		}
	}
}

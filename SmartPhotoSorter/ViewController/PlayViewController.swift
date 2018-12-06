//
//  PlayViewController.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 05.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class PlayViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	fileprivate var longPressGesture: UILongPressGestureRecognizer!

	var game: Game? = nil

	var images = [SKPhotoProtocol]()

	override func viewDidLoad() {
		super.viewDidLoad()

		// Static setup
		SKPhotoBrowserOptions.displayAction = true
		SKPhotoBrowserOptions.displayStatusbar = true
		SKPhotoBrowserOptions.displayCounterLabel = true
		SKPhotoBrowserOptions.displayBackAndForwardButton = true

		self.setupPhotoData()
		self.setupCollectionView()

		self.title = game?.name ?? "No Game"
	}

	override var prefersStatusBarHidden: Bool {
		return false
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
}

// MARK: - UICollectionViewDataSource
extension PlayViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return images.count
	}

	@objc(collectionView:cellForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
			return UICollectionViewCell()
		}

		// cell.backgroundColor = .white

		cell.photoImageView.image = self.images[(indexPath as NSIndexPath).row].underlyingImage
		cell.photoImageView.contentMode = .scaleAspectFit
		
		return cell
	}
}

// MARK: - UICollectionViewDelegate
extension PlayViewController: UICollectionViewDelegate {

	@objc(collectionView:didSelectItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let browser = SKPhotoBrowser(photos: images, initialPageIndex: indexPath.row)

		browser.delegate = self

		present(browser, animated: true, completion: {})
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
		print("Starting Index: \(sourceIndexPath.item)")
		print("Ending Index: \(destinationIndexPath.item)")

		// FIXME
		// currentgame swap images
		let img = images[sourceIndexPath.item]
		images[sourceIndexPath.item] = images[destinationIndexPath.item]
		images[destinationIndexPath.item] = img

		self.collectionView.reloadData()
	}
}

// MARK: - SKPhotoBrowserDelegate
extension PlayViewController: SKPhotoBrowserDelegate {

	func didShowPhotoAtIndex(_ index: Int) {
		collectionView.visibleCells.forEach({$0.isHidden = false})
		collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = true
	}

	func willDismissAtPageIndex(_ index: Int) {
		collectionView.visibleCells.forEach({$0.isHidden = false})
		collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = true
	}

	func willShowActionSheet(_ photoIndex: Int) {
		// do some handle if you need
	}

	func didDismissAtPageIndex(_ index: Int) {
		collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = false
	}

	func didDismissActionSheetWithButtonIndex(_ buttonIndex: Int, photoIndex: Int) {
		// handle dismissing custom actions
	}

	func removePhoto(_ browser: SKPhotoBrowser, index: Int, reload: @escaping (() -> Void)) {
		reload()
	}

	func viewForPhoto(_ browser: SKPhotoBrowser, index: Int) -> UIView? {
		return collectionView.cellForItem(at: IndexPath(item: index, section: 0))
	}

	func captionViewForPhotoAtIndex(index: Int) -> SKCaptionView? {
		return nil
	}
}

// MARK: - private
private extension PlayViewController {

	func setupPhotoData() {
		images = createLocalPhotos()
	}

	func setupCollectionView() {
		collectionView.delegate = self
		collectionView.dataSource = self

		self.longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
		collectionView.addGestureRecognizer(longPressGesture)
	}

	func createLocalPhotos() -> [SKPhotoProtocol] {
		return (0..<10).map { (i: Int) -> SKPhotoProtocol in
			let photo = SKPhoto.photoWithImage(UIImage(named: "image\(i%10)")!)
			photo.caption = caption[i%10]
			return photo
		}
	}

	@objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
		switch(gesture.state) {

		case .began:
			guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
				break
			}
			collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
		case .changed:
			collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
		case .ended:
			collectionView.endInteractiveMovement()
		default:
			collectionView.cancelInteractiveMovement()
		}
	}
}

class PhotoCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var photoImageView: UIImageView!

	override func awakeFromNib() {
		super.awakeFromNib()

		self.photoImageView.image = nil
		layer.cornerRadius = 25.0
		layer.masksToBounds = true
	}

	override func prepareForReuse() {
		self.photoImageView.image = nil
	}
}

var caption = ["Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
			   "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
			   "It has survived not only five centuries, but also the leap into electronic typesetting",
			   "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
			   "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
			   "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
			   "It has survived not only five centuries, but also the leap into electronic typesetting",
			   "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
			   "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
			   "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
			   "It has survived not only five centuries, but also the leap into electronic typesetting",
			   "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
]

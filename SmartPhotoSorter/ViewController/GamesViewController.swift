//
//  GamesViewController.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 05.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit
import Rswift

private enum Constants {
	static let startGame = "startGame"
	static let contentViewController = "contentViewController"
	static let textCell = "TextCell"
}

class GamesViewController: BaseTableViewController {

	var viewModel: GamesViewModel? = nil

	override func viewDidLoad() {
		super.viewDidLoad()

		self.viewModel = GamesViewModel()

		self.title = self.viewModel?.pageTitle()
	}
}

// MARK: UITableViewDataSource

extension GamesViewController {

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel?.gamesCount ?? 0
	}
}

// MARK: UITableViewDelegate

extension GamesViewController {

	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

		let headerImage: UIImage = R.image.rocket()!
		let headerView = UIImageView(image: headerImage)
		headerView.contentMode = .scaleAspectFit
		return headerView
	}

	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 180
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.textCell, for: indexPath)
		let gamesItem = self.viewModel?.item(at: indexPath.row)

		cell.imageView?.image = R.image.rocket()
		cell.textLabel?.text = gamesItem?.title ?? R.string.localizable.gamesErrorNoGame()

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		// store selected game in view model
		self.viewModel?.selectGameItem(at: indexPath.row)
		self.viewModel?.selectPlayerItem(at: 0) // init with first player, if user does not change

		let vc = UIViewController()
		vc.preferredContentSize = CGSize(width: 250, height: 300)
		let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
		pickerView.delegate = self
		pickerView.dataSource = self.viewModel!
		vc.view.addSubview(pickerView)

		let alert = UIAlertController(title: R.string.localizable.gamesPlayerTitle(), message: R.string.localizable.gamesPlayerDescription(), preferredStyle: .alert)
		alert.setValue(vc, forKey: Constants.contentViewController)
		alert.addAction(UIAlertAction(title: R.string.localizable.gamesPlayerDone(), style: .default, handler: { action in

			// start game
			// a new game is prepared in 'prepare for segue'
			self.performSegue(withIdentifier: Constants.startGame, sender: self)
		}))
		alert.addAction(UIAlertAction(title: R.string.localizable.gamesPlayerCancel(), style: .cancel, handler: nil))
		self.present(alert, animated: true)

		self.tableView.deselectRow(at: indexPath, animated: true)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

		if segue.identifier == Constants.startGame {

			let destination = segue.destination as? GameViewController
			destination?.viewModel = self.viewModel?.createGameViewModel()
		}
	}
}

extension GamesViewController: UIPickerViewDelegate {

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		self.viewModel?.selectPlayerItem(at: row)
	}
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let view = UserPickerView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 160, height: 42)))
        view.username = self.viewModel?.playerName(at: row)

        return view
    }
}

//
//  ScoreCalculator.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 07.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

class ScoreCalculator {

	/// calculates the score of the given order based on bubble sort distance
	///
	/// https://stackoverflow.com/questions/33899599/bubble-sorting-max-number-of-times
	/// - Parameter arrayOfRanks: input array
	/// - Returns: score
	func calculateScore(of arrayOfRanks: [Int]) -> Int {
		let n = arrayOfRanks.count
		let maximumNumberOfSwapsPossible = n * (n + 1) / 2
		//return (maximumNumberOfSwapsPossible - arrayOfRanks.bubbleSortCount()) * 5
		return Int(Double(arrayOfRanks.bubbleSortCount()) / Double(maximumNumberOfSwapsPossible)) // in percent
	}
}

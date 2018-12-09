//
//  Array+Sorting.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 07.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

extension Array where Element: Comparable {

	func bubbleSortCount(by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> Int {

		var data = self
		var numberOfSwaps = 0

		for i in 0..<(data.count - 1) { // 1
			for j in 0..<(data.count - i - 1) where areInIncreasingOrder(data[j + 1], data[j]) { // 2
				data.swapAt(j, j + 1)
				numberOfSwaps = numberOfSwaps + 1
			}
		}

		return numberOfSwaps
	}
}

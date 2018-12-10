//
//  Array+Sorting.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 07.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

extension Array where Element: Comparable {

	func bubbleSortCount(by orderingFunc: ((Element, Element) -> Bool) = (<)) -> Int {

		var data = self
		var numberOfSwaps = 0

		for i in 0..<(data.count - 1) {
			for j in 0..<(data.count - i - 1) where orderingFunc(data[j + 1], data[j]) {
				data.swapAt(j, j + 1)
				numberOfSwaps = numberOfSwaps + 1
			}
		}

		return numberOfSwaps
	}
}

extension Array where Element: Equatable {

	public mutating func remove(_ item: Element) {
		var index = 0
		while index < self.count {
			if self[index] == item {
				self.remove(at: index)
			} else {
				index += 1
			}
		}
	}

	public func array(removing item: Element) -> [Element] {
		var result = self
		result.remove(item)
		return result
	}

	public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
		guard index >= 0, index < endIndex else {
			return defaultValue()
		}

		return self[index]
	}
}

extension Array {

	mutating func shuffle() {
		if count < 2 { return }
		for index in 0..<count - 1 {
			let newIndex = Int(arc4random_uniform(UInt32(count - index))) + index
			guard index != newIndex else { continue }
			self.swapAt(index, newIndex)
		}
	}

	func shuffled() -> [Element] {
		var list = self
		for index in 0..<list.count {
			let newIndex = Int(arc4random_uniform(UInt32(list.count - index))) + index
			if index != newIndex {
				list.swapAt(index, newIndex)
			}
		}
		return list
	}
}

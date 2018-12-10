//
//  AppCore.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 10.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation
import Swinject

class AppCore {

	private var container = Container()

	public private(set) static var shared = AppCore()

	public static func reset() {
		shared = AppCore()
	}

	public func setup() {
		// register data provider
		self.container.register(DataControllerProtocol.self) { _ in
			return DataController(nil)
		}.inObjectScope(.container)

		self.container.register(DataProvider.self) { resolver in
			let dataController = self.container.resolve(DataControllerProtocol.self)!
			return DataProvider(dataController: dataController)
		}.inObjectScope(.container)

		self.container.register(GameUseCaseProtocol.self) { resolver in
			let dataProvider = self.container.resolve(DataProvider.self)!
			return GameUserCase(dataProvider: dataProvider)
		}.inObjectScope(.container)
	}

	public var gameUseCase: GameUseCaseProtocol {
		return self.container.resolve(GameUseCaseProtocol.self)!
	}
}


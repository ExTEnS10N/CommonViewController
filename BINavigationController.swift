//
//  TENavigationController.swift
//
//  Created by macsjh on 16/3/6.
//  Copyright © 2016年 TurboExtension. All rights reserved.
//

import UIKit

class TENavigationController: UINavigationController, UIGestureRecognizerDelegate {
	
	private var _popGestureIsEnabled = false
	override func viewDidLoad() {
		super.viewDidLoad()
		enablePopGesture(true)
	}
	
	func enablePopGesture(enable:Bool)
	{
		_popGestureIsEnabled = enable
		self.interactivePopGestureRecognizer?.delegate = self
	}
	
	func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
		guard gestureRecognizer == self.interactivePopGestureRecognizer else {return true}
		if self.viewControllers.count > 1{
			return _popGestureIsEnabled
		}
		return false
	}
}

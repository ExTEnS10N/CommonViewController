//
//  TEMessageBox.swift
//
//  Created by macsjh on 16/3/7.
//  Copyright © 2016年 TurboExtension. All rights reserved.
//

import UIKit

class TEMessageBox{
	
	private static var isPresenting = false
		{
		didSet{
			if !isPresenting && MSGBoxQueue.count > 0{
				let MSGTuple = MSGBoxQueue.removeFirst()
				presentMessageBox(MSGTuple.0, parentVC: MSGTuple.1)
			}
		}
	}
	
	private static var MSGBoxQueue:[(UIAlertController, UIViewController)] = []
	
	private static func presentMessageBox(MSGBox:UIAlertController, parentVC: UIViewController){
		isPresenting = true
		if(parentVC.tabBarController != nil){
			parentVC.tabBarController!.presentViewController(MSGBox, animated: true, completion: nil)
		}
		else if(parentVC.navigationController != nil){
			parentVC.navigationController!.presentViewController(MSGBox, animated: true, completion: nil)
		}
		else{
			parentVC.presentViewController(MSGBox, animated: true, completion: nil)
		}
	}
	
	///弹出OK消息对话框
	static func OKBox(title: String, message: String, parentViewController: UIViewController, handler:(()->Void)? = nil)
	{
		NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
			let _MessageBox = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
			
			// Action
			let okAction = UIAlertAction(title: "好吧", style: UIAlertActionStyle.Default)
				{(action: UIAlertAction!) -> Void in
					isPresenting = false
					if(handler != nil){handler!()}
			}
			_MessageBox.addAction(okAction)
			
			//present
			if isPresenting {MSGBoxQueue.append((_MessageBox, parentViewController))}
			else {presentMessageBox(_MessageBox, parentVC: parentViewController)}
		})
	}
	
	///	弹出输入框
	static func InputBox(title: String, placeHolders:[String], textFieldContent:[String]? = nil, parentVC: UIViewController, confirmHandler:([UITextField]) -> Void)
	{
		if textFieldContent != nil {
			guard placeHolders.count == textFieldContent!.count
				else {fatalError("Error: placeHolders.count != textFieldContent.count")}
		}
		NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
			let _MessageBox = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
			
			// Action
			let confirmAction = UIAlertAction(title: "确认", style: .Default, handler: { (_:UIAlertAction)	-> Void in
				isPresenting = false
				confirmHandler(_MessageBox.textFields!)
			})
			let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler:{(_:UIAlertAction) -> Void in isPresenting = false
			})
			_MessageBox.addAction(confirmAction)
			_MessageBox.addAction(cancelAction)
			
			// textField
			for var i = 0; i < placeHolders.count; ++i{
				_MessageBox.addTextFieldWithConfigurationHandler({ (textField:UITextField) -> Void in
					textField.placeholder = placeHolders[i]
					if textFieldContent != nil {textField.text = textFieldContent![i]}
				})
			}
			
			// present
			if isPresenting {MSGBoxQueue.append((_MessageBox, parentVC))}
			else {presentMessageBox(_MessageBox, parentVC: parentVC)}
		})
	}
}


//
//  TESettings.swift
//
//  Created by macsjh on 16/3/7.
//  Copyright © 2016年 TurboExtension. All rights reserved.
//

import UIKit
class TESettings{
	
	/// 默认值表，在此存放默认设置项
	private static let defaultSettings:[String:AnyObject] = [
		:
	]
	
	///保存指定的属性
	///
	///- Parameter propertyName:属性名
	///- Parameter value:属性的值
	internal static func Save(propertyName: String, value: AnyObject?){
		guard let shareSettings:NSUserDefaults = NSUserDefaults()
			else {fatalError("can't load user defualts, please check your entitlements")}
		shareSettings.setObject(value, forKey: propertyName)
		shareSettings.synchronize()
	}
	
	///读取指定的属性，如果属性未存储，查找默认值表
	///
	///- Parameter propertyName:属性名
	///- Returns: 属性值
	internal static func Load(propertyName: String) -> AnyObject?
	{
		guard let shareSettings:NSUserDefaults = NSUserDefaults()
			else {fatalError("can't load user defualts, please check your entitlements")}
		if let configuration = shareSettings.valueForKey(propertyName){
			return configuration
		}
		else if let configuration = defaultSettings[propertyName]{
			return configuration
		}
		return nil
	}
}
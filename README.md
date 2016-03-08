# CommonViewController
个人编写的常用IOS Navigation Controller、Table View Controller子类等，比通常网上搜索到的更稳定、更简单易用，代码更简洁

- TENavigationController 自定义导航栏返回按钮时，完美支持滑动返回手势
- TEViewController 若存在导航栏，且leftBarButtonItem为自定义返回键，则给返回键添加返回事件
- TETableViewController 具有TEViewController的功能，且对于选中的Cell，如果该cell不是会促发页面跳转的，给该cell?.setSelected(false, animated: true)
- MessageBox iOS 8以上弹出消息对话框的优雅解决方案，能确保不会因同时弹出多个对话框引发冲突，能自动选择最合适的ViewController来present对话框
- Settings 使用NSUserDefault保存设置项的简洁可靠方案，支持设置默认值。
- ClassExtension 常用类扩展

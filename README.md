# lighthouse_admin

Flutter版后台管理系统

## 实现内容

* 全平台适配，Web、Android、iOS、Windows、macos
* 基于`getX` 的路由管理
* 基于`getX` 的mvvm模式 状态管理
* 基于`dio` 的请求封装
* 完整的登录逻辑
* 数据展示、增删改查
* 多语言

## 在线demo
[http://www.jerryplay.top/lhadmin](http://www.jerryplay.top/lhadmin)

## 使用的三方库

| 库                         | 功能             |
| -------------------------- | --------------- |
| [date_format](https://github.com/tejainece/date_format)                            | **日期格式化**       |
| [package_info](https://github.com/flutter/plugins/tree/master/packages/package_info)     | **package信息**       |
| [encrypt](https://github.com/leocavalcante/encrypt)                            | **加密库**       |
| [flutter_spinkit](https://github.com/jogboms/flutter_spinkit)                            | **loading动画**       |
| [decimal](https://github.com/a14n/dart-decimal)                            | **小数计算**       |
| [dio](https://github.com/flutterchina/dio)                            | **网络库**       |
| [get_storage](https://github.com/rrousselGit/provider)                   | **本地存储**     |
| [getx](https://github.com/jonataslaw/getx)                            | **路由管理、状态管理**     |
| [bot_toast](https://github.com/MMMzq/bot_toast)     | **Toast**        |
| [keyboard_actions](https://github.com/diegoveloper/flutter_keyboard_actions)                  | **处理键盘事件**       |

## 项目运行环境

    1. Flutter version 2.0.0
     
    2. Dart version 2.12.0

## 运行

    flutter run -d chrome

## 打包

    flutter build web

加载canvaskit.wasm过慢可使用国内镜像

    --dart-define=FLUTTER_WEB_CANVASKIT_URL=https://cdn.jsdelivr.net/npm/canvaskit-wasm@0.24.0/bin/
    --dart-define=FLUTTER_WEB_CANVASKIT_URL=https://unpkg.zhimg.com/canvaskit-wasm@0.24.0/bin/ 
    --dart-define=FLUTTER_WEB_CANVASKIT_URL=https://npm.elemecdn.com/canvaskit-wasm@0.24.0/bin/

## 桌面平台支持

    flutter config --enable-windows-desktop
    flutter config --enable-macos-desktop 
    flutter config --enable-linux-desktop

    flutter create .

    flutter run -d windows
    flutter run -d macos 
    flutter run -d linux
    
    flutter build windows
    flutter build macos 
    flutter build linux

备注：macos下添加以下配置到 `macos/Runner/DebugProfile.entitlements` 文件，解决http请求失败问题

    <key>com.apple.security.network.client</key>
    <true/>

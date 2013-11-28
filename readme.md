# iOS程序偏好设置

## 最佳实践
### 1. 设置默认值

```
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 设置一个默认值，每次应用启动时，都需要配置。
    // 优先级最低
    [defaults registerDefaults:@{
            USERINFO_NAME : @"sliuqin"
    }];
```
默认值设置，不写入存储，所以需要在应用每次启动时都要设置，一般在`application:didFinishLaunchingWithOptions` 中设置。

### 2. 系统设置中的 App 偏好设置
> Xcode 文档中搜索 `Implementing an iOS Settings Bundle` 可以找到对象的文档

一般设置一些不常用的选项。注意这里面设置的`defaultValue`并不全部能直接在应用中读取，所以其中的 `defaultValue` 最好能配置在第一步的默认设置中。

另外，输入框输入完毕后，无法触发`endEditing`，导致一单进入输入框，键盘就无法消失。


### 3. App级别的偏好设置
```
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:textField.text forKey:USERINFO_NAME];
    [defaults synchronize];
```
设置偏好后，需要即使的进行`synchronize` ，以免在应用异常等情况下，造成设置丢失。

----
以上几步的设置，`3`会覆盖`2`中的设置，`2`会覆盖`1`中的设置，因为配置项设置的方式不同，尽量避免`3`和`2`中有相同的配置项，因为用户并不关心设置优先级的问题，他只知道有一个配置可能没有生效。

但是默认值，都可以使用`1`中一起设置。
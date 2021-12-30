# NoSignal
SYSU MOSAD 2021 Final Project

小组：No Signal

成员：冼子婷、胡文浩、廖雨轩



技术选型：Swift、SwiftUI、RealityKit、Combine、Core Data、CryptoSwiftUI、Kingfisher

配置环境：Xcode13.0+、IOS14.0+

## 架构设计

在 SwiftUI 中，由于引入了 Binding 绑定、Observable 观察者模式，并且得益于 Swift 引入命令式编程，以及闭包、Lambda函数等语言特性，SwiftUI 简化了传统的事件驱动 (Event Driven)，并且由传统的 MVC (Model - View - Controller) 转向了 MVVM (Model-View-ViewModel) 模式。

### MVVM

- **Model**：MVVM 是 Domain Model 模式的实现，Model 将包括我们的数据结构以及业务逻辑和验证逻辑，即数据来源，服务器上业务逻辑操作，从后端得到传递数据。
- **View**：视图将负责定义用户在屏幕上看到的内容的结构，布局和外观。
- **ViewModel**：ViewModel 将成为视图和模型之间的桥梁，它负责视图逻辑的管理。 通常，视图模型通过调用模型类中的方法与模型交互，然后，视图模型将以一种视图可以轻松使用的方式提供模型数据。

### Core Data

![img](https://gitee.com/AdBean/img/raw/master/images/202112301251749.png)

### Redux

基于 MVVM 以及观察者模式，我想到了前端中常用的 Redux 架构，也即自定义一个统一的方式管理数据状态，便于组件之间进行数据流动、并且实现 UI 视图与数据逻辑之间的分离。

#### 响应式编程

在具体实现 Redux 架构之前，还需要了解 SwiftUI 中提供的 Combine 架构，为给定的事件源创建单个处理链，链的每个部分都是一个合并运算符，对从上一步接收到的元素执行不同的操作。在官方文档，Combine的定义为：“通过组合事件处理运算符**自定义异步事件**的处理。”

Combine 框架提供了一个**声明性**的 Swift API，用于随着时间的推移处理值。这些值可以表示多种异步事件。 Combine 声明发布者公开可随时间变化的值，订阅者从发布者接收这些值。

由 Publisher（发布者）、Subscriber（订阅者）和 Operator（操作符）组成。

结合在 MVVM 中提到的搜索实例，不难理解 Combine 在 Redux 中扮演的重要角色。



详情参考架构设计文档（飞书）：

https://sysumatrix.feishu.cn/docs/doccnB0Y3h9hNYjUQVNWjlXi7Xc

## 成果展示

<img src=".\Images\SearchView.PNG" alt="SearchView" style="zoom:33%;" />

<img src=".\Images\PlayListView.png" style="zoom:33%;" />

<img src=".\Images\LibraryView.png" style="zoom:33%;" />

<img src=".\Images\IMG_5457.png" style="zoom:33%;" />

<img src=".\Images\IMG_5459.png" style="zoom:33%;" />

<img src=".\Images\IMG_5461.PNG" style="zoom:33%;" />

<img src=".\Images\IMG_5462.PNG" style="zoom:33%;" />

<img src=".\Images\IMG_5465.PNG" style="zoom:33%;" />

<img src=".\Images\IMG_5466.PNG" style="zoom:33%;" />

<img src=".\Images\IMG_5471.PNG" style="zoom:33%;" />

<img src=".\Images\IMG_5473.PNG" style="zoom:33%;" />

<img src=".\Images\IMG_5474.PNG" style="zoom:33%;" />

<img src=".\Images\IMG_5477.PNG" style="zoom:33%;" />

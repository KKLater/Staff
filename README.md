# Staff 布局新玩具

说说最近做的东西，Staff，就是下面这个东西。

![image.png](https://upload-images.jianshu.io/upload_images/312211-27d7c1ad75d663d1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/310)

功能很简单。在项目运行期间，点击选择不同的视图，并标注出视图之间的布局关系。

####版本更新
**0.0.1 版本：**
1、基础功能实现
**0.0.2 版本：**
1、修复 staff 关闭后，window 没有置空的bug
 **0.0.3 版本：**
![image.png](https://upload-images.jianshu.io/upload_images/312211-402504eb1bdb0d74.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/310)

#### 应用场景
这个主要应用场景，我大概想到两点：
1、自己开发UI时，代码运行发现有问题，但是又不能够直接知道具体布局偏差多少。此时使用 Staff 框架，直接知道UI布局关系，偏差具体多少像素。找到相关代码后，按照已知偏差像素修改。
2、UI 核对你的UI布局开发时，除了截图发到电脑，与自己的原设计稿比对外，又多了一种方式，直接使用Staff 框架，选中视图，查看布局数据与自己的设计稿数据对比，知道是否UI布局开发正确。

#### 使用
支持 pod 倒入到项目中，只需在项目 podfile 中增加 `pod 'Staff'`。

>建议仅在Debug 环境中倒入该库，避免线上用户当游戏玩耍，点击看你们的布局玩

Staff 具体使用很简单。

代码层面，需要启动 Staff 时，直接设置`Staff.sharedInstance.enable = YES;`，如果不再使用Staff 功能，则将其 `enable` 设置为 `NO` 即可。

操作方面，Staff 使用了单击、双击、三击操作。具体功能如下：

**单击**：单击选中、取消、切换关联视图。

在没有选中视图时，单击屏幕内的视图，则选中视图为主视图，此时显示如下：

![仅选中主视图](https://upload-images.jianshu.io/upload_images/312211-7c8b23ee1e98f27e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

仅选中主视图，显示主视图的宽、高。

已经选中主视图的情况下，单击任一其他视图，则选中为辅助视图，此时显示如下：

![主辅视图显示](https://upload-images.jianshu.io/upload_images/312211-f54269d66f21ec12.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

主辅视图显示，并显示二者布局关系。（此时若再单击另一视图，则切换辅助视图，并重新标注主辅视图关系）

单击已经选择的主视图或辅视图，则取消选择。即剩余的一个视图变为主视图。

**双击**：双击切换主辅视图关系。即已经选择有主辅视图的情况下，二者调换主辅视图关系。原主视图变为辅助视图，原辅助视图变为主视图，并从新标注二者关系。

![双击主辅视图切换](https://upload-images.jianshu.io/upload_images/312211-11b0011bb87e3303.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**三击**：三击屏幕，会显示一个详细视图。在布局紧凑，数据不易显示清楚时最实用。例如下面的主辅视图布局：

![布局紧凑](https://upload-images.jianshu.io/upload_images/312211-947f0914a8a245b9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/620)

三击后显示详细布局：

![三击布局显示](https://upload-images.jianshu.io/upload_images/312211-cbcf499b27a9283a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/620)

当然，再次三击，详细布局会消失掉，不会影响到重新选择主辅视图。

如有其他疑问或使用问题、bug，可以直接在项目主页提交 issue 或 request。当然如果有其他优化想法或建议，也欢迎邮件联系我。

邮箱：lshxin89@126.com

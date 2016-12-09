
//----------------------- 笔 记 -----------------------


/**
 *      block 的定义：
 
    1. 在参数中： (void (^)())completionBlock
    2. @propery (nonatomic, copy) void (^completionBlock)();
 */


/**
 *      pop 与 core animation 的区别 (poping是 pop 的示例程序)
 
    1. core animation 的动画只能添加到 layer 上
    2. pop 的动画能添加到任何对象上
    3. pop 的底层不是基于 core animation, 而是基于 CADisplayLink 的
    4. pop 对 frame 的修改是真正的改变了 view 的 frame， 即使 view 没有设置 frame，在做动画时设置了 frame 也是有效的 （实时修改对象的属性，真正修改）
    5. core animation 虽然通过动画修改 frame， 但是最终的 frame 是没有改变的 （仅仅是表象，不会真正修改 frame，size 等等）
 */



/**
 *      运行时(Runtime)
 
    1. 是苹果官方的一套C语言库
    2. 可以做很多底层操作 (比如: 访问隐藏的一些成员变量/成员方法....)
    3. 指针 指向 返回的成员变量数组的指针
    4. Ivar *ivars指针 指向成员变量数组中的第一个元素 , 且该数组中的元素类型都是Ivar类型
    
    5. 获取属性
 
 */




/**
 *      当加载过多图片时, 系统会出现内存警告
 
    1. 当出现内存警告时要做: 清理内存, 停止所有的网络请求
 
    2. 在使用SDWebImage时, 可以不需要考虑图片内存警告的问题:
       因为SDWebImage会在收到内存警告通知(UIApplicationDidReceiveMemoryWarningNotification)时,调用自身的clearMenory方法
 
 */




/**
 *      禁止别人修改自定义控件的frame
 
    1. 在自定义控件中重写 -(void)setFrame 方法, 外部任何一次修改自定义控件frame时 都会调用该方法
    2. 以后不想让别人修改 frame, 就重写 该方法在里面设置固定值
 */




/**
 *      颜色:
 
    1. 24bit 颜色: RGB
    2. 32bit 颜色: A RGB A代表透明度
    3. RGB 值一样的是 灰色
 */



/**
 *      单独创建xib: 
 
    1. 要在.xib中的File`s Owner的class设置为当前控制器.
    2. 然后 右键File`s Owner : 设置 view 为 xib.view
 */



/**
 *      xib中label换行:
    
    1. 使用 option + return 键,
    2. 使用\n是不好用的,
    3. 当vabel的行数为0时, 不需要设置label的高度, 会自动识别高度
 */




/**
 *      导航栏按钮自定义view
 
    1. 使用 initWithCustomView 设置导航栏左按钮为自定义视图
 */




/**
 *      appearance 统一设置属性
 
    1. api中 后面带有 UI_APPEARANCE_SELECTOR 的方法, 都可以通过 appearance 来统一设置属性
 */



/**     自定义tabbar
 
    1. 由于 tabBar 的属性是不可以修改的, 所以使用kvc对tabBar这个成员变量进行赋值
    2. 当属性为 readonly 时 , 可以使用kvc来进行修改赋值
 */



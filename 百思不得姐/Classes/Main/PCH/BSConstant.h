

/**
 *      常量的创建
    
    UIKIT_EXTERN：就是将函数修饰为兼容以往C编译方式的、具有extern属性(文件外可见性)、public修饰的方法或变量库外仍可见的属性
 */
 

#import <UIKit/UIKit.h>

/** 帖子的类型 */
typedef enum {
    BSPostsTypeAll = 1,
    BSPostsTypePicture = 10,
    BSPostsTypeWord = 29,
    BSPostsTypeVoice = 31,
    BSPostsTypeVideo = 41
} BSPostsType;


/** 精华-标签栏的高度 */
UIKIT_EXTERN CGFloat const BSTitlesViewH;
/** 精华-标签栏的Y值 */
UIKIT_EXTERN CGFloat const BSTitlesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const BSPostsCellMargin;
/** 精华-cell-文字内容的 Y */
UIKIT_EXTERN CGFloat const BSPostsCellContentTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const BSPostsCellBottomBarH;
/** 精华-cell-图片帖子内容的最大高度 */
UIKIT_EXTERN CGFloat const BSPostsCellContentPictureMaxH;
/** 精华-cell-图片帖子内容一旦超过最大高度，就是使用该高度 */
UIKIT_EXTERN CGFloat const BSPostsCellContentPictureBreakH;

/** BSUser模型 性别属性值 - 男 */
UIKIT_EXTERN NSString * const BSUserMale;
/** BSUser模型 性别属性值 - 女 */
UIKIT_EXTERN NSString * const BSUserFemale;


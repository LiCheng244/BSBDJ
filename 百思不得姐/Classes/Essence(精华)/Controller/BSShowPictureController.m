//
//  BSShowPictureController.m
//  百思不得姐
//
//  Created by LiCheng on 2016/12/6.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSShowPictureController.h"

@interface BSShowPictureController ()

@end

@implementation BSShowPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)backClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.view.contentMode = UIViewContentModeScaleToFill;
}


@end

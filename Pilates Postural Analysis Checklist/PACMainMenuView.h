//
//  PACMainMenuView.h
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/8/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PACMainMenuView;

@protocol PACMainMenuDelegate <NSObject>
@optional
-(void)mainMenuDismiss:(PACMainMenuView*)menu;
-(void)mainMenuEmailAnalysis:(PACMainMenuView*)menu;
@end

@interface PACMainMenuView : UIView <UITableViewDelegate
	                           , UITableViewDataSource
	                           >
{
@private
        __weak id<PACMainMenuDelegate> _menu_delegate;
        NSMutableArray* _analysis;
}
@property (nonatomic, weak) id<PACMainMenuDelegate> menu_delegate;

@end

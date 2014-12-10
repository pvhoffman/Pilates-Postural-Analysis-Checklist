//
//  MasterViewController.h
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 10/21/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PACMainMenuView.h"

@interface MasterViewController : UITableViewController <PACMainMenuDelegate
                                                        , MFMailComposeViewControllerDelegate
                                                        > 
{
@private    
    MFMailComposeViewController* _mailer;
}

@end


//
//  MasterViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 10/21/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//
#import <MessageUI/MessageUI.h>

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "PACPlumbLineViewController.h"
#import "PACSideViewTableViewController.h"
#import "PACFrontViewTableViewController.h"
#import "PACBackViewTableViewController.h"
#import "PACViewAnalysisViewController.h"
#import "PACTypesetter.h"
#import "PACGlobal.h"

enum {
        tagMenuView = 101
            , tagOverlayView
};

enum {
	tableViewItemPlumbLine   = 0
	, tableViewItemSideView  = 1
	, tableViewItemFrontView = 2
	, tableViewItemBackView  = 3
        , tableViewItemViewAnalysis = 4
	, tableViewItemCount     = 5
};
//static UIPopoverController* _popover_controller = nil;

static NSString* cell_identifier = @"master-view-cell";
static void _message_box(UIViewController* view_controller, NSString* caption, NSString* message);

@interface MasterViewController ()
-(void) mainCheckListDidChange:(NSNotification*)notification;
-(void) menuButtonClicked:(id)sender;
@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib
{
	[super awakeFromNib];
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
	[self.tableView registerClass:[UITableViewCell class ] forCellReuseIdentifier:cell_identifier];

        self.tableView.scrollEnabled = NO;

	self.navigationItem.title = @"Main";

	UIBarButtonItem* barItem1 = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Menu", @"")
	                             style:UIBarButtonItemStylePlain
	                             target:self
	                             action:@selector(menuButtonClicked:)];
	[self.navigationController.navigationBar.topItem setRightBarButtonItem:barItem1 animated:NO];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainCheckListDidChange:) name:[NSString stringWithUTF8String:PACCheckListMainDidChange] object:nil];

        _mailer = nil;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
	if (!self.objects) {
		self.objects = [[NSMutableArray alloc] init];
	}
	[self.objects insertObject:[NSDate date] atIndex:0];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
/*
    if((PACChecklistMain & mainChecklistPlumbline) == mainChecklistPlumbline
        && (PACChecklistMain & mainChecklistSideView) == mainChecklistSideView
        && (PACChecklistMain & mainChecklistFrontView) == mainChecklistFrontView
        && (PACChecklistMain & mainChecklistBackView) == mainChecklistBackView){
        return tableViewItemCount + 1;
    }
*/
    return tableViewItemCount;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identifier];
	}
	cell.accessoryType   = UITableViewCellAccessoryDisclosureIndicator;

	switch(indexPath.row) {
	case tableViewItemPlumbLine:
		cell.textLabel.text  = @"Plumb Line";
		cell.imageView.image = pac_plumbline_indicator();
		if((PACChecklistMain & mainChecklistPlumbline) == mainChecklistPlumbline) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewItemSideView:
		cell.textLabel.text = @"Side View";
		cell.imageView.image = pac_sideview_indicator();
		if((PACChecklistMain & mainChecklistSideView) == mainChecklistSideView) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewItemFrontView:
		cell.textLabel.text = @"Front View";
		cell.imageView.image = pac_frontview_indicator();
		if((PACChecklistMain & mainChecklistFrontView) == mainChecklistFrontView) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewItemBackView:
		cell.textLabel.text = @"Back View";
		cell.imageView.image = pac_backview_indicator();
		if((PACChecklistMain & mainChecklistBackView) == mainChecklistBackView) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
        case tableViewItemViewAnalysis:
                if((PACChecklistMain & mainChecklistPlumbline) == mainChecklistPlumbline
                        && (PACChecklistMain & mainChecklistSideView) == mainChecklistSideView
                        && (PACChecklistMain & mainChecklistFrontView) == mainChecklistFrontView
                        && (PACChecklistMain & mainChecklistBackView) == mainChecklistBackView){
                    cell.textLabel.textColor = [UIColor blackColor];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.imageView.image = pac_analysisview_complete_indicator();
                } else {
                    cell.textLabel.textColor = [UIColor lightGrayColor];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.imageView.image = pac_analysisview_incomplete_indicator();
                }
                cell.textLabel.text = @"View Analysis";
                break;
	default:
                cell.textLabel.text = [NSString stringWithFormat:@"cell %d", (int)indexPath.row];
		break;
	}
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch(indexPath.row) {
	case tableViewItemPlumbLine: {
		PACPlumbLineViewController* view_controller =  [[PACPlumbLineViewController alloc] init];
		[self.navigationController pushViewController:view_controller animated:YES];
		break;
	}
	case tableViewItemSideView: {
		PACSideViewTableViewController* view_controller = [[PACSideViewTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
		[self.navigationController pushViewController:view_controller animated:YES];
		break;
	}
	case tableViewItemFrontView: {
		PACFrontViewTableViewController* view_controller = [[PACFrontViewTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
		[self.navigationController pushViewController:view_controller animated:YES];
		break;
	}
	case tableViewItemBackView:
		[self.navigationController pushViewController:[[PACBackViewTableViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
		break;
        case tableViewItemViewAnalysis:
                if((PACChecklistMain & mainChecklistPlumbline) != mainChecklistPlumbline){
                    _message_box(self, @"Information", @"Plumbline section must be completed before viewing analysis.");
                    break;
                }

                if((PACChecklistMain & mainChecklistSideView) != mainChecklistSideView){
                    _message_box(self, @"Information", @"Side view section must be completed before viewing analysis.");
                    break;
                }

                if((PACChecklistMain & mainChecklistFrontView) != mainChecklistFrontView){
                    _message_box(self, @"Information", @"Front view section must be complted before viewing analysis.");
                    break;
                }
                if((PACChecklistMain & mainChecklistBackView) != mainChecklistBackView){
                    _message_box(self, @"Information", @"Back view section must be complted before viewing analysis.");
                    break;
                }
		[self.navigationController pushViewController:[[PACViewAnalysisViewController alloc] init] animated:YES];
                break;
	default:
		break;
	}
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Return NO if you do not want the specified item to be editable.
	return NO;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	CGRect frame = tableView.frame;

	UIView* res = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, 215.0f)];

        res.backgroundColor = [UIColor clearColor];

	UIImage* image = [UIImage imageNamed:@"main-view.png"];

	UIImageView* image_view = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, image.size.height)];
	image_view.contentMode = UIViewContentModeScaleAspectFit;
	image_view.image = image;

	[res addSubview:image_view];

	return res;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 282.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 0.0f;
}
#pragma mark -
#pragma mark Private
-(void) mainCheckListDidChange:(NSNotification*)notification;
{
	[self.tableView reloadData];
}
-(void) menuButtonClicked:(id)sender
{

    UIView* v1 = [self.view viewWithTag:tagMenuView];
    if(!v1){
        CGRect frame1 = self.tableView.frame;

        const float height = 365.0f;
        const float overlay = frame1.size.height - height;

        CGRect frame2 = CGRectMake(0.0f, frame1.size.height, frame1.size.width, height); //frame1.size.height);
        CGRect frame3 = CGRectMake(0.0f, -overlay, frame1.size.width, overlay);

        PACMainMenuView* menu = [[PACMainMenuView alloc] initWithFrame:frame2];
        menu.tag = tagMenuView;
        menu.menu_delegate = self;

        UIView* overlayView = [[UIView alloc] initWithFrame:frame3];
        overlayView.backgroundColor  = [UIColor blackColor];
        overlayView.alpha            = 0.42f;
        overlayView.tag              = tagOverlayView;

        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.5f];

        [self.view addSubview:menu];
        [self.view addSubview:overlayView];

        menu.frame  = CGRectMake(0.0f, frame1.size.height - height, frame1.size.width, height);
        overlayView.frame = CGRectMake(0.0f, 0.0f, frame1.size.width, overlay);

        [UIView commitAnimations];
    }

}
#pragma mark -
#pragma mark PACMainMenuDelegate
-(void)mainMenuDismiss:(PACMainMenuView*)menu
{
    UIView* v1 = [self.view viewWithTag:tagMenuView];
    UIView* v2 = [self.view viewWithTag:tagOverlayView];

    if(v1){
        [v1 removeFromSuperview];
    }
    if(v2){
        // using transitions adds the layover view many times possibly
        while(v2){
            [v2 removeFromSuperview];
            v2 = [self.view viewWithTag:tagOverlayView];
        }
    } 
}
-(void)mainMenuEmailAnalysis:(PACMainMenuView*)menu
{
    NSString* failmsg = nil;

    NSString* filename = pac_typeset_current_analysis(&failmsg);

    if(filename && [filename length] && [[NSFileManager defaultManager] fileExistsAtPath:filename] == YES){

        if ([MFMailComposeViewController canSendMail]){

            _mailer = nil;

            _mailer = [[MFMailComposeViewController alloc] init];
            _mailer.mailComposeDelegate = self; 

            NSData* pdf_data = [NSData dataWithContentsOfFile:filename];

            [_mailer setSubject:@"Posture Analysis Checklist"];
            [_mailer setMessageBody:@"Attached to this message is your completed posture analysis checklist." isHTML:NO];
            [_mailer addAttachmentData:pdf_data mimeType:@"application/pdf" fileName:@"posture-analysis-checklist.pdf"];

            [self presentViewController:_mailer animated:YES completion:NULL];
        } else {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                           message:@"Device not configured for email."
                                                                    preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:NULL];
            [alert addAction:defaultAction];

            [self presentViewController:alert animated:YES completion:nil];
        }

    } else {
        // log an error
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Could not create analysis sheet."
                                                                preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:NULL];
        [alert addAction:defaultAction];

        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    NSString* alertCaption = nil;
    NSString* alertMessage = nil;

    [controller dismissViewControllerAnimated:YES completion:NULL];

    switch(result) {
        case MFMailComposeResultCancelled:
                alertCaption = [NSString stringWithString:NSLocalizedString(@"Email Cancelled", "")];
                alertMessage = [NSString stringWithString:NSLocalizedString(@"No email message was queued.", @"")];
                break;
        case MFMailComposeResultSaved:
                alertCaption = [NSString stringWithString:NSLocalizedString(@"Email Draft Saved", @"")];
                alertMessage = [NSString stringWithString:NSLocalizedString(@"Email successfully saved in Drafts folder.", @"")];
                break;
        case MFMailComposeResultSent:
                alertCaption = [NSString stringWithString : NSLocalizedString (@"Email Message Queued to Outbox", @"")];
                alertMessage = [NSString stringWithString:NSLocalizedString(@"Email will be sent the next time email is connected.", @"")];
                break;
        case MFMailComposeResultFailed: {
                NSString* formatstring = NSLocalizedString(@"Error message is: %@", @"");
                NSString* errmsg = [error localizedDescription];
                alertCaption = [NSString stringWithString:NSLocalizedString(@"Email Message Failed", @"")];
                alertMessage = [NSString stringWithFormat:formatstring, errmsg];
                }
                break;
        default:
                alertCaption = [NSString stringWithString:NSLocalizedString(@"Email Message Status Unknown", @"")];
                alertMessage = [NSString stringWithString:NSLocalizedString(@"Unknown result.", @"")];
                break;
    }



    UIAlertController* alert = [UIAlertController alertControllerWithTitle:alertCaption
                message:alertMessage
                preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:NULL];

    [alert addAction:defaultAction];

    [self presentViewController:alert animated:YES completion:nil];
}
@end

static void _message_box(UIViewController* view_controller, NSString* caption, NSString* message)
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:caption
                message:message
                preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:NULL];

    [alert addAction:defaultAction];

    [view_controller presentViewController:alert animated:YES completion:nil];

}

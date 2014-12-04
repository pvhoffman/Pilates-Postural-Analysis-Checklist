//
//  PACRelativeAlignmentViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 10/23/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACRelativeAlignmentViewController.h"
#import "PACGlobal.h"

enum {
	tagContentView = 100
};

@interface PACRelativeAlignmentViewController ()
-(void) switchValueDidChange:(id)sender;
@end

@implementation PACRelativeAlignmentViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void) loadView
{
	[super loadView];

	self.navigationItem.title = @"Relative Alignment";

	CGRect frame = self.view.frame;
	UIScrollView* content_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
	content_view.tag = tagContentView;
	content_view.backgroundColor = [UIColor whiteColor];

	UIImage* image = [UIImage imageNamed:@"alignment_detail.jpg"];

	UIImageView* image_view = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width / 2.0f) - (image.size.width / 2.0f), 5, image.size.width, image.size.height)];
	image_view.image = image;
	[content_view addSubview:image_view];

	UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(3.0f, image.size.height + 15.0f, frame.size.width - 3.0f, 42.0f)];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor blackColor];
	label.font = [UIFont boldSystemFontOfSize:16.0];
	label.text = NSLocalizedString(@"Are the head, thorax, and pelvis aligned in relation to each other?", @"");
	label.numberOfLines = 0;
	label.lineBreakMode = NSLineBreakByWordWrapping;
	label.textAlignment = NSTextAlignmentCenter;
	[content_view addSubview:label];

	UISwitch* switsh = [[UISwitch alloc] initWithFrame:CGRectMake((frame.size.width / 2.0f) - 12.0f, image.size.height + 15.0f + 42.0f, 24.0f, 24.0f)];
	[switsh addTarget:self action: @selector(switchValueDidChange:) forControlEvents: UIControlEventValueChanged];
	//switsh.tag = tagBillingDetailsTaxContract;
	[content_view addSubview:switsh];

	switsh.on = ((PACChecklistMain & mainChecklistAlignedInRelation) == mainChecklistAlignedInRelation);


	[self.view addSubview:content_view];
}

-(void) switchValueDidChange:(id)sender
{
	UISwitch* switsh = (UISwitch*)sender;
	if(switsh.on) {
		PACChecklistMain |= mainChecklistAlignedInRelation;
	} else {
		PACChecklistMain &= ~mainChecklistAlignedInRelation;
	}
	[[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListMainDidChange] object:nil];
}
/*
   #pragma mark - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   }
 */

@end

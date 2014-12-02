//
//  PACHumeriBackViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/2/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACHumeriBackViewController.h"
#import "PACGlobal.h"

enum {
        tagContentView = 100
            , tagTableView
};


enum {
    tableViewSectionCount = 1
};

enum {
    tableViewRowHumeriLeft        = 0
        , tableViewRowHumeriRight = 1
        , tableViewRowCount       = 2
};

static NSString* cell_identifier = @"humeri-back-cell";

@interface PACHumeriBackViewController ()
-(void) segmentvaluechanged:(id)sender;
@end

@implementation PACHumeriBackViewController

- (void)viewDidLoad 
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}
-(void) loadView
{
    [super loadView];

    self.navigationItem.title = @"Humeri - Back";

    CGRect frame = self.view.frame;
    float fy = 5.0f;
    float fgutter = 5.0f;


    UIScrollView* content_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
    content_view.tag = tagContentView;
    content_view.backgroundColor = [UIColor whiteColor];

    UIImage* image = [UIImage imageNamed:@"humeri_back_detail.jpg"];

    UIImageView* image_view = [[UIImageView alloc] initWithFrame:CGRectMake( (frame.size.width / 2.0f) - (image.size.width / 2.0f), fy, image.size.width, image.size.height)];
    image_view.image = image;
    [content_view addSubview:image_view];

    fy = fy + image.size.height + fgutter;

    UIImage* look = [UIImage imageNamed:@"look.jpg"];
    UIImageView* look_view = [[UIImageView alloc] initWithFrame:CGRectMake( 5.0f, fy, look.size.width, look.size.height )];
    look_view.image = look;
    [content_view addSubview:look_view];

    UIImage* touch = [UIImage imageNamed:@"touch.jpg"];
    UIImageView* touch_view = [[UIImageView alloc] initWithFrame:CGRectMake( 7.0f + look.size.width, fy, touch.size.width, touch.size.height )];
    touch_view.image = touch;
    [content_view addSubview:touch_view];

    fy = fy + look.size.height + fgutter;

    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(3.0f, fy + 30.0f, frame.size.width - 3.0f, 300.0f) style:UITableViewStyleGrouped];
    tableView.tag = tagTableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.scrollEnabled = NO;
    [content_view addSubview:tableView];

    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_identifier];

    fy = fy + 220.0f + 30.0f + fgutter;

    [self.view addSubview:content_view];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

    cell.accessoryType = UITableViewCellAccessoryNone;

    if(!cell.accessoryView){
            UISegmentedControl *segment = [[UISegmentedControl alloc] init];
            segment.frame = CGRectMake(0,0,230,30);
            segment.tag   = indexPath.row;
            [segment insertSegmentWithTitle:@"Neutral" atIndex:0 animated:NO];
            [segment insertSegmentWithTitle:@"Rotated" atIndex:1 animated:NO];
            [segment addTarget:self action:@selector(segmentvaluechanged:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = segment;
   }

    switch(indexPath.row){
        case tableViewRowHumeriLeft:
            cell.textLabel.text = @"Left";
            ((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = PACHumeriBackAlignmentLeft;
            break;
        case tableViewRowHumeriRight:
            cell.textLabel.text = @"Right";
            ((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = PACHumeriBackAlignmentRight;
            break;
 
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return tableViewSectionCount;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableViewRowCount;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0f, tableView.frame.size.width, 30.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.text = NSLocalizedString(@"● Palpate the olecranon process.", @"");
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    return label;
}
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
	return 32.0f;
}
#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
#pragma mark -
#pragma mark private
-(void) segmentvaluechanged:(id)sender
{
    UISegmentedControl* segment = (UISegmentedControl*)sender;

    switch(segment.tag){
        case tableViewRowHumeriLeft:
            PACHumeriBackAlignmentLeft = (int)segment.selectedSegmentIndex;
            break;
        case tableViewRowHumeriRight:
            PACHumeriBackAlignmentRight = (int)segment.selectedSegmentIndex;
            break;
    }

    if(PACHumeriBackAlignmentLeft > -1 && PACHumeriBackAlignmentRight > -1){
        if(!((PACChecklistBackView & backViewCheckListHumeri) == backViewCheckListHumeri)){
            PACChecklistBackView |= backViewCheckListHumeri;
            [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListBackViewDidChange] object:nil];
        }
    }
}

@end

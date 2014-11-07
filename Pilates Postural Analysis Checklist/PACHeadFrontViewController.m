//
//  PACHeadFrontViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 11/6/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACHeadFrontViewController.h"

#import "PACShouldersFrontViewController.h"
#import "PACGlobal.h"

enum {
        tagContentView = 100
            , tagTableView
};

enum {
    tableViewRowHeadNeutral = 0
        , tableViewRowHeadRotatedClockwise
        , tableViewRowHeadRotatedCounterClockwise
        , tableViewRowHeadTilted
        , tableViewRowHeadShifted
        , tableViewRowCount
};
 
static NSString* cell_identifier = @"head-front-cell";

@interface PACHeadFrontViewController ()
-(void) segmentvaluechanged:(id)sender;
@end

@implementation PACHeadFrontViewController

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

    self.navigationItem.title = @"Head - Front";

    CGRect frame = self.view.frame;
    float fy = 5.0f;
    float fgutter = 5.0f;


    UIScrollView* content_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
    content_view.tag = tagContentView;
    content_view.backgroundColor = [UIColor whiteColor];

    UIImage* image = [UIImage imageNamed:@"head_front_detail.jpg"];

    UIImageView* image_view = [[UIImageView alloc] initWithFrame:CGRectMake( (frame.size.width / 2.0f) - (image.size.width / 2.0f), fy, image.size.width, image.size.height)];
    image_view.image = image;
    [content_view addSubview:image_view];

    fy = fy + image.size.height + fgutter;

    UIImage* look = [UIImage imageNamed:@"look.jpg"];
    UIImageView* look_view = [[UIImageView alloc] initWithFrame:CGRectMake( 5.0f, fy, look.size.width, look.size.height )];
    look_view.image = look;
    [content_view addSubview:look_view];
/*
    UIImage* touch = [UIImage imageNamed:@"touch.jpg"];
    UIImageView* touch_view = [[UIImageView alloc] initWithFrame:CGRectMake( 7.0f + look.size.width, fy, touch.size.width, touch.size.height )];
    touch_view.image = touch;
    [content_view addSubview:touch_view];
*/
    fy = fy + look.size.height + fgutter;

    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(3.0f, fy + 30.0f, frame.size.width - 3.0f, 350.0f) style:UITableViewStyleGrouped];
    tableView.tag = tagTableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.scrollEnabled = NO;
    [content_view addSubview:tableView];

    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_identifier];

    fy = fy + 220.0f + 30.0f + fgutter;

    [self.view addSubview:content_view];
}
#pragma mark -
#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

    return cell;
}



@end

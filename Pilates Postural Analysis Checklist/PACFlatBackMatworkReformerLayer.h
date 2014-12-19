//
//  PACFlatBackMatworkReformer.h
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/15/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    flatBackMatworkReformerLayer1 = 0
        , flatBackMatworkReformerLayer2 
        , flatBackMatworkReformerLayer3 
        , flatBackMatworkReformerLayerCount
} PACFlatBackMatworkReformerLayer_t;

@interface PACFlatBackMatworkReformerLayer : UITableViewController
{
}
-(void) setLayer:(PACFlatBackMatworkReformerLayer_t)layer;
@end

//
//  PACSwayBackMatworkReformer.h
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/15/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    swayBackMatworkReformerLayer1 = 0
        , swayBackMatworkReformerLayer2 
        , swayBackMatworkReformerLayer3 
        , swayBackMatworkReformerLayerCount
} PACSwayBackMatworkReformerLayer_t;

@interface PACSwayBackMatworkReformerLayer : UITableViewController
{
}
-(void) setLayer:(PACSwayBackMatworkReformerLayer_t)layer;
@end

//
//  PACSwayBackEssentailReformer.h
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/15/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    swayBackEssentialReformerLayer1 = 0
        , swayBackEssentialReformerLayer2 
        , swayBackEssentialReformerLayer3 
        , swayBackEssentialReformerLayerCount
} PACSwayBackEssentialReformerLayer_t;

@interface PACSwayBackEssentialReformerLayer : UITableViewController
{
@private
        NSArray* _warmup;
        NSArray* _exercises;

        NSArray* _warmup_details;
        NSArray* _exercises_details;

        NSArray* _warmup_bold;
        NSArray* _exercises_bold;
}
-(void) setLayer:(PACSwayBackEssentialReformerLayer_t)layer;
@end

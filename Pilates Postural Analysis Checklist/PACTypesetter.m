//
//  PACTypesetter.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/9/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "PACTypesetter.h"
#import "PACGlobal.h"

static NSString* pac_document_filename()
{
    NSString* res = [[NSBundle mainBundle] pathForResource:@"Postural-Analysis-Guide" ofType:@"pdf"];
    return res;
}
static NSString* pac_temporary_filename()
{
    NSString* filename = [[[NSUUID UUID] UUIDString] stringByAppendingString:@".pdf"];
    NSString* res = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];
    return res;
}
static CGPDFDocumentRef pac_source_document()
{
    NSURL* url = [NSURL fileURLWithPath:pac_document_filename()];
    CGPDFDocumentRef res = CGPDFDocumentCreateWithURL((__bridge CFURLRef)url);
    return res;
}
static CGContextRef pac_analysis_document(NSString* filename)
{
    NSURL* url = [NSURL fileURLWithPath:filename];
    CGContextRef res  = CGPDFContextCreateWithURL((__bridge CFURLRef)url, NULL, NULL);
    return res;
}
static BOOL pac_copy_page(CGPDFDocumentRef src, CGContextRef pdf_ctx, int number)
{
        BOOL res = NO;

        do {

            CGPDFPageRef page = CGPDFDocumentGetPage(src, number);

            CGRect bbox = CGPDFPageGetBoxRect(page, kCGPDFMediaBox);

            CGContextBeginPage(pdf_ctx, &bbox);

            CGContextDrawPDFPage(pdf_ctx, page);

            res = YES;
        } while(0);

        return res;
}

void pac_typeset_plumbline_analysis(CGContextRef pdf_ctx)
{
    NSMutableArray* fs = [[NSMutableArray alloc] init];
    NSMutableArray* bs = [[NSMutableArray alloc] init];


    if((PACPlumbLineAlignment & plumbHeadForward) == plumbHeadForward){
        [fs addObject:@"Head"];
    } else if((PACPlumbLineAlignment & plumbHeadBehind) == plumbHeadBehind){
        [bs addObject:@"Head"];
    }

    if((PACPlumbLineAlignment & plumbShouldersForward) == plumbShouldersForward){
        [fs addObject:@"Shoulders"];
    } else if ((PACPlumbLineAlignment & plumbShouldersBehind) == plumbShouldersBehind){
        [bs addObject:@"Shoulders"];
    }

    if((PACPlumbLineAlignment & plumbUpperBodyForward) == plumbUpperBodyForward){
        [fs addObject:@"Upper Body"];
    } else if((PACPlumbLineAlignment & plumbUpperBodyBehind) == plumbUpperBodyBehind){
        [bs addObject:@"Upper Body"];
    }

    if((PACPlumbLineAlignment & plumbPelvisForward) == plumbPelvisForward){
        [fs addObject:@"Pelvis"];
    } else if((PACPlumbLineAlignment & plumbPelvisBehind) == plumbPelvisBehind){
        [bs addObject:@"Pelvis"];
    }

    if((PACPlumbLineAlignment & plumbKneesForward) == plumbKneesForward){
        [fs addObject:@"Knees"];
    } else if((PACPlumbLineAlignment & plumbKneesBehind) == plumbKneesBehind){
        [bs addObject:@"Knees"];
    }

    if([fs count] > 0 || [bs count] > 0){
        NSDictionary *attribs = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:13.0]};
        NSAttributedString *fontStr = [[NSAttributedString alloc] initWithString:@"\u2713" attributes:attribs];

        CTLineRef displayLine = CTLineCreateWithAttributedString( (__bridge CFAttributedStringRef)fontStr );
        CGContextSetTextPosition( pdf_ctx, 97.5f, 670.0f );
        CTLineDraw( displayLine, pdf_ctx );
        CFRelease( displayLine );


        float sx = 110.0f;
        float sy = 645.0f;

        if([bs count] > 0){
            attribs = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:9.0]};

            NSString* line = [NSString stringWithFormat:@"Behind: %@", [bs componentsJoinedByString:@", "]];
            fontStr = [[NSAttributedString alloc] initWithString:line attributes:attribs];

            displayLine = CTLineCreateWithAttributedString( (__bridge CFAttributedStringRef)fontStr );
            CGContextSetTextPosition( pdf_ctx, sx, sy);
            CTLineDraw( displayLine, pdf_ctx );
            CFRelease( displayLine );

            sy = sy - 14.0f;
        }

        if([fs count] > 0){
            attribs = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:9.0]};

            NSString* line = [NSString stringWithFormat:@"Forward: %@", [fs componentsJoinedByString:@", "]];
            fontStr = [[NSAttributedString alloc] initWithString:line attributes:attribs];

            displayLine = CTLineCreateWithAttributedString( (__bridge CFAttributedStringRef)fontStr );
            CGContextSetTextPosition( pdf_ctx, sx, sy);
            CTLineDraw( displayLine, pdf_ctx );
            CFRelease( displayLine );

        }
    }

    if((PACPlumbLineAlignment & plumbRelativeAlign) == plumbRelativeAlign){
        NSDictionary* attribs = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:13.0]};
        NSAttributedString* fontStr = [[NSAttributedString alloc] initWithString:@"\u2713" attributes:attribs];

        CTLineRef displayLine = CTLineCreateWithAttributedString( (__bridge CFAttributedStringRef)fontStr );
        CGContextSetTextPosition( pdf_ctx, 336.0f, 670.0f );
        CTLineDraw( displayLine, pdf_ctx );
        CFRelease( displayLine );
    }  
}
static void pac_typeset_draw_checkmark(CGContextRef pdf_ctx, const float x, const float y)
{
    NSDictionary* attribs = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:13.0]};
    NSAttributedString* fontStr = [[NSAttributedString alloc] initWithString:@"\u2713" attributes:attribs];

    CTLineRef displayLine = CTLineCreateWithAttributedString( (__bridge CFAttributedStringRef)fontStr );
    CGContextSetTextPosition( pdf_ctx, x, y );
    CTLineDraw( displayLine, pdf_ctx );
    CFRelease( displayLine );
}
static void pac_typeset_draw_circle(CGContextRef pdf_ctx, const float x, const float y, const float w, const float h)
{
    CGContextSetLineWidth(pdf_ctx, 1.5);
    CGContextSetRGBStrokeColor(pdf_ctx, 0.0, 0.0, 0.0, 1.0);
    CGContextStrokeEllipseInRect(pdf_ctx, CGRectMake(x, y, w, h));
}
static void pac_typeset_sideview_ankles(CGContextRef pdf_ctx)
{
    const float cbx = 97.5f;
    const float cby_neutral = 590.0f;
    const float cby_plantar = 578.0f;
    const float cby_dorsi   = 566.0f;

    const float cirrx = 187.0f;
    const float cirlx = 203.0f;

    const float ciry_neutral = 588.0;
    const float ciry_plantar = 576.0;
    const float ciry_dorsi   = 563.0;

    const float cirw = 10.0f;
    const float cirh = 10.0f;

    switch(PACAnkleAlignmentLeft){
        case ankleAlignmentNeutral:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_neutral, cirw, cirh);
            break;
        case ankleAlignmentPlantarflex:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_plantar);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_plantar, cirw, cirh);
            break;
        case ankleAlignmentDorsiflex:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_dorsi);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_dorsi, cirw, cirh);
            break;
    }

    switch(PACAnkleAlignmentRight){
        case ankleAlignmentNeutral:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_neutral, cirw, cirh);
            break;
        case ankleAlignmentPlantarflex:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_plantar);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_plantar, cirw, cirh);
            break;
        case ankleAlignmentDorsiflex:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_dorsi);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_dorsi, cirw, cirh);
            break;
    }
}
static void pac_typeset_sideview_knees(CGContextRef pdf_ctx)
{
    const float cbx = 97.5f;
    const float cby_neutral  = 536.0f;
    const float cby_extended = 524.0f;
    const float cby_flexed   = 512.0f;

    const float cirrx = 187.0f;
    const float cirlx = 203.0f;

    const float ciry_neutral  = 534.0;
    const float ciry_extended = 522.0;
    const float ciry_flexed   = 510.0;

    const float cirw = 10.0f;
    const float cirh = 10.0f;

    switch(PACKneeAlignmentSideLeft){
        case kneeSideAlignmentNeutral:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_neutral, cirw, cirh);
            break;
        case kneeSideAlignmentHyperextended:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_extended);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_extended, cirw, cirh);
            break;
        case kneeSideAlignmentFlexed:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_flexed);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_flexed, cirw, cirh);
            break;
    }

    switch(PACKneeAlignmentSideRight){
        case kneeSideAlignmentNeutral:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_neutral, cirw, cirh);
            break;
        case kneeSideAlignmentHyperextended:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_extended);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_extended, cirw, cirh);
            break;
        case kneeSideAlignmentFlexed:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_flexed);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_flexed, cirw, cirh);
            break;
    }

}
static void pac_typeset_sideview_hipjoints(CGContextRef pdf_ctx)
{
    const float cbx = 97.5f;
    const float cby_neutral  = 482.0f;
    const float cby_flexed   = 470.0f;
    const float cby_extended = 458.0f;

    const float cirrx = 187.0f;
    const float cirlx = 203.0f;

    const float ciry_neutral  = 480.0;
    const float ciry_flexed   = 468.0;
    const float ciry_extended = 456.0;

    const float cirw = 10.0f;
    const float cirh = 10.0f;


    switch(PACHipAlignmentLeft){
        case hipAlignmentNeutral:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_neutral, cirw, cirh);
            break;
        case hipAlignmentExtended:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_extended);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_extended, cirw, cirh);
            break;
        case hipAlignmentFlexed:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_flexed);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_flexed, cirw, cirh);
            break;
    }

    switch(PACHipAlignmentRight){
        case hipAlignmentNeutral:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_neutral, cirw, cirh);
            break;
        case hipAlignmentExtended:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_extended);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_extended, cirw, cirh);
            break;
        case hipAlignmentFlexed:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_flexed);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_flexed, cirw, cirh);
            break;
    }
}
static void pac_typeset_sideview_pelvis(CGContextRef pdf_ctx)
{
    const float cbx = 97.5f;
    const float cby_neutral   = 428.0f;
    const float cby_anterior  = 416.0f;
    const float cby_posterior = 404.0f;

    const float cirrx = 187.0f;
    const float cirlx = 203.0f;

    const float ciry_neutral   = 426.0;
    const float ciry_anterior  = 414.0;
    const float ciry_posterior = 402.0;

    const float cirw = 10.0f;
    const float cirh = 10.0f;


    switch(PACPelvisSideAlignmentLeft){
        case pelvisSideAlignmentNeutral:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_neutral, cirw, cirh);
            break;
        case pelvisSideAlignmentAnteriorTilt:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_anterior);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_anterior, cirw, cirh);
            break;
        case pelvisSideAlignmentPosteriorTilt:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_posterior);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_posterior, cirw, cirh);
            break;
    }
    switch(PACPelvisSideAlignmentRight){
        case pelvisSideAlignmentNeutral:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_neutral, cirw, cirh);
            break;
        case pelvisSideAlignmentAnteriorTilt:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_anterior, cirw, cirh);
            break;
        case pelvisSideAlignmentPosteriorTilt:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_posterior, cirw, cirh);
            break;
    }
}
static void pac_typeset_sideview_lumbar(CGContextRef pdf_ctx)
{
    const float cbx = 97.5f;
    const float cby_neutral = 374.0f;
    const float cby_flat    = 362.0f;
    const float cby_flexed  = 350.0f;


    switch(PACLumbarAlignment){
        case lumbarAlignmentNeutral:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
            break;
        case lumbarAlignmentFlat:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_flat);
            break;
        case lumbarAlignmentFlexed:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_flexed);
            break;
    }
}

static void pac_typeset_sideview_lowerthoracic(CGContextRef pdf_ctx)
{
    const float cbx = 97.5f;
    const float cby_neutral = 320.0f;
    const float cby_flat    = 308.0f;
    const float cby_flexed  = 296.0f;

    switch(PACLowerThoracicAlignment){
        case lowerThoracicAlignmentNeutral:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
            break;
        case lowerThoracicAlignmentFlat:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_flat);
            break;
        case lowerThoracicAlignmentFlexed:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_flexed);
            break;
    }
}
static void pac_typeset_sideview_upperthoracic(CGContextRef pdf_ctx)
{
    const float cbx = 97.5f;
    const float cby_neutral = 266.0f;
    const float cby_flat    = 255.0f;
    const float cby_flexed  = 242.0f;

    switch(PACUpperThoracicAlignment){
        case upperThoracicAlignmentNeutral:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
            break;
        case upperThoracicAlignmentFlat:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_flat);
            break;
        case upperThoracicAlignmentFlexed:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_flexed);
            break;
    }
}
static void pac_typeset_sideview_cervicalspine(CGContextRef pdf_ctx)
{
    const float cbx = 97.5f;
    const float cby_neutral = 212.0f;
    const float cby_flat    = 200.0f;
    const float cby_flexed  = 188.0f;

    switch(PACCervicalSpineAlignment){
        case cervicalSpineAlignmentNeutral:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
            break;
        case cervicalSpineAlignmentFlat:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_flat);
            break;
        case cervicalSpineAlignmentFlexed:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_flexed);
            break;
    }
}
static void pac_typeset_sideview_head(CGContextRef pdf_ctx)
{

    const float cbx = 97.5f;
    const float cby_neutral   = 158.0f;
    const float cby_forward   = 146.0f;
    const float cby_retracted = 134.0f;

    switch(PACHeadSideAlignment){
        case headSideAlignmentNeutral:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
            break;
        case headSideAlignmentForward:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_forward);
            break;
        case headSideAlignmentRetracted:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_retracted);
            break;
    }
}
static void pac_typeset_sideview_analysis(CGContextRef pdf_ctx)
{
    pac_typeset_sideview_ankles(pdf_ctx);
    pac_typeset_sideview_knees(pdf_ctx);
    pac_typeset_sideview_hipjoints(pdf_ctx);
    pac_typeset_sideview_pelvis(pdf_ctx);
    pac_typeset_sideview_lumbar(pdf_ctx);
    pac_typeset_sideview_lowerthoracic(pdf_ctx);
    pac_typeset_sideview_upperthoracic(pdf_ctx);
    pac_typeset_sideview_cervicalspine(pdf_ctx);
    pac_typeset_sideview_head(pdf_ctx);
}
static void pac_typeset_frontview_feet(CGContextRef pdf_ctx)
{
    const float cbx = 287.0f;
    const float cby_neutral  = 590.0f;
    const float cby_inverted = 578.0f;
    const float cby_everted  = 566.0f;

    const float cirrx = 376.0f;
    const float cirlx = 394.0f;

    const float ciry_neutral  = 588.0;
    const float ciry_inverted = 576.0;
    const float ciry_everted  = 564.0;

    const float cirw = 10.0f;
    const float cirh = 10.0f;


    switch(PACFeetFrontAlignmentLeft){
        case feetFrontAlignmentNeutral:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_neutral, cirw, cirh);
            break;
        case feetFrontAlignmentInverted:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_inverted);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_inverted, cirw, cirh);
            break;
        case feetFrontAlignmentEverted:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_everted);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_everted, cirw, cirh);
            break;
    }

    switch(PACFeetFrontAlignmentRight){
        case feetFrontAlignmentNeutral:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_neutral, cirw, cirh);
            break;
        case feetFrontAlignmentInverted:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_inverted);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_inverted, cirw, cirh);
            break;
        case feetFrontAlignmentEverted:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_everted);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_everted, cirw, cirh);
            break;
    }

}
static void pac_typeset_frontview_knees(CGContextRef pdf_ctx)
{
    const float cbx = 287.0f;
    const float cby_neutral = 536.0f;
    const float cby_knock   = 524.0f;
    const float cby_bow     = 512.0f;

    switch(PACKneeFrontAlignmentLeft){
        case kneeFrontAlignmentNeutral:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
            break;
        case kneeFrontAlignmentKnocked:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_knock);
            break;
        case kneeFrontAlignmentBow:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_bow);
            break;
    }


}
static void pac_typeset_frontview_pelvis(CGContextRef pdf_ctx)
{

    const float cbx = 287.0f;
    const float cby_level      = 482.0f;
    const float cby_elevated   = 470.0f;
    const float cby_rotated_c  = 458.0f;
    const float cby_rotated_cw = 446.0f;

    const float cirrx = 376.0f;
    const float cirlx = 394.0f;

    const float cirw = 10.0f;
    const float cirh = 10.0f;

    const float ciry_elevated = 468.0f;

    switch(PACPelvisFrontAlignment){
        case pelvisFrontAlignmentLevel:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_level);
            break;
        case pelvisFrontAlignmentElevatedLeft:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_elevated);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_elevated, cirw, cirh);
            break;
        case pelvisFrontAlignmentElevatedRight:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_elevated);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_elevated, cirw, cirh);
            break;
        case pelvisFrontAlignmentRotatedClockwise:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_rotated_c);
            break;
        case pelvisFrontAlignmentRotatedCounterClockwise:
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_rotated_cw);
            break;
    }
}
static void pac_typeset_frontview_ribcage(CGContextRef pdf_ctx)
{    
    const float cbx = 287.0f;
    const float cby_neutral    = 416.0f;
    const float cby_elevated   = 404.0f;
    const float cby_shifted    = 392.0f;
    const float cby_rotated_c  = 380.0f;
    const float cby_rotated_cw = 368.0f;

    const float cirrx = 376.0f;
    const float cirlx = 394.0f;

    const float cirw = 10.0f;
    const float cirh = 10.0f;

    const float ciry_elevated = 402.0f;
    const float ciry_shifted  = 390.0f;

    if(PACRibCageFrontAlignment == ribCageAlignmentNeutral){
        pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
    } else {
        if((PACRibCageFrontAlignment & ribCageAlignmentElevatedLeft) == ribCageAlignmentElevatedLeft){
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_elevated);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_elevated, cirw, cirh);
        }
        if((PACRibCageFrontAlignment & ribCageAlignmentElevatedRight) == ribCageAlignmentElevatedRight){
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_elevated);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_elevated, cirw, cirh);
        }
        if((PACRibCageFrontAlignment & ribCageAlignmentShiftedLeft) == ribCageAlignmentShiftedLeft){
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_elevated);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_shifted, cirw, cirh);
        }
        if((PACRibCageFrontAlignment & ribCageAlignmentShiftedRight) == ribCageAlignmentShiftedRight){
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_elevated);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_shifted, cirw, cirh);
        }
        if((PACRibCageFrontAlignment & ribCageAlignmentRotatedClockwise) == ribCageAlignmentRotatedClockwise){
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_rotated_c);
        }
        if((PACRibCageFrontAlignment & ribCageAlignmentRotatedCounterClockwise) == ribCageAlignmentRotatedCounterClockwise){
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_rotated_cw);
        }
    }
}
static void pac_typeset_frontview_shoulders(CGContextRef pdf_ctx)
{
    const float cbx = 287.0f;
    const float cby_level     = 338.0f;
    const float cby_elevated  = 326.0f;
    const float cby_depressed = 314.0f;

    const float cirrx = 376.0f;
    const float cirlx = 394.0f;

    const float cirw = 10.0f;
    const float cirh = 10.0f;

    const float ciry_elevated  = 324.0f;
    const float ciry_depressed = 312.0f;

    if((PACShouldersFrontAlignment & shouldersFrontAlignmentLevel) == shouldersFrontAlignmentLevel){
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_level);
    }
    if((PACShouldersFrontAlignment & shouldersFrontAlignmentElevatedLeft) == shouldersFrontAlignmentElevatedLeft){
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_elevated);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_elevated, cirw, cirh);
    }
    if((PACShouldersFrontAlignment & shouldersFrontAlignmentElevatedRight) == shouldersFrontAlignmentElevatedRight){
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_elevated);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_elevated, cirw, cirh);
    }
    if((PACShouldersFrontAlignment & shouldersFrontAlignmentDepressedLeft) == shouldersFrontAlignmentDepressedLeft){
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_depressed);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_depressed, cirw, cirh);
    }
    if((PACShouldersFrontAlignment & shouldersFrontAlignmentDepressedRight) == shouldersFrontAlignmentDepressedRight){
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_depressed);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_depressed, cirw, cirh);
    }
}
static void pac_typeset_frontview_head(CGContextRef pdf_ctx)
{
    const float cbx = 287.0f;
    const float cby_rotated_c  = 284.0f;
    const float cby_rotated_cw = 272.0f;
    const float cby_neutral    = 260.0f;
    const float cby_tilted     = 248.0f;
    const float cby_shifted    = 236.0f;

    const float cirrx = 376.0f;
    const float cirlx = 394.0f;

    const float cirw = 10.0f;
    const float cirh = 10.0f;

    const float ciry_tilted  = 246.0f;
    const float ciry_shifted = 234.0f;

    if((PACHeadFrontAlignment & headFrontAlignmentNeutral) == headFrontAlignmentNeutral){
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_neutral);
    }
    if((PACHeadFrontAlignment & headFrontAlignmentRotatedClockwise) == headFrontAlignmentRotatedClockwise){
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_rotated_c);
    }
    if((PACHeadFrontAlignment & headFrontAlignmentRotatedCounterClockwise) == headFrontAlignmentRotatedCounterClockwise){
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_rotated_cw);
    }
    if((PACHeadFrontAlignment & headFrontAlignmentTiltedLeft) == headFrontAlignmentTiltedLeft){
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_tilted);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_tilted, cirw, cirh);
    }
    if((PACHeadFrontAlignment & headFrontAlignmentTiltedRight) == headFrontAlignmentTiltedRight){
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_tilted);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_tilted, cirw, cirh);
    }
    if((PACHeadFrontAlignment & headFrontAlignmentShiftedLeft) == headFrontAlignmentShiftedLeft){
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_shifted);
            pac_typeset_draw_circle(pdf_ctx, cirlx, ciry_shifted, cirw, cirh);
    }
    if((PACHeadFrontAlignment & headFrontAlignmentShiftedRight) == headFrontAlignmentShiftedRight){
            pac_typeset_draw_checkmark(pdf_ctx, cbx, cby_shifted);
            pac_typeset_draw_circle(pdf_ctx, cirrx, ciry_shifted, cirw, cirh);
    }
}
static void pac_typeset_frontview_analysis(CGContextRef pdf_ctx)
{
    pac_typeset_frontview_feet(pdf_ctx);
    pac_typeset_frontview_knees(pdf_ctx);
    pac_typeset_frontview_pelvis(pdf_ctx);
    pac_typeset_frontview_ribcage(pdf_ctx);
    pac_typeset_frontview_shoulders(pdf_ctx);
    pac_typeset_frontview_head(pdf_ctx);
}
NSString* pac_typeset_current_analysis(NSString** failmsg)
{
        NSString* res = nil;

        do {
            NSString* filename = pac_temporary_filename();
            if(!filename || [filename length] == 0){
                if(failmsg) *failmsg = @"Cannot obtain temporary file name.";
                break;
            }

            CGPDFDocumentRef doc_src = pac_source_document();
            if(!doc_src){
                if(failmsg) *failmsg = @"Cannot open source pdf document.";
                break;
            }

            CGContextRef pdf_ctx = pac_analysis_document(filename);
            if(!pdf_ctx){
                if(failmsg) *failmsg = @"Cannot create new pdf context.";
                break;
            }

            if(!pac_copy_page(doc_src, pdf_ctx, 1)){
                if(failmsg) *failmsg = @"Cannot copy page to destination PDF context.";
                break;
            }

            CGPDFDocumentRelease(doc_src);

            // typeset the fields
            pac_typeset_plumbline_analysis(pdf_ctx);
            pac_typeset_sideview_analysis(pdf_ctx);
            pac_typeset_frontview_analysis(pdf_ctx);

            CGContextEndPage(pdf_ctx);
            CGContextRelease(pdf_ctx);

            res = filename;
        } while(0);

        return res;
}



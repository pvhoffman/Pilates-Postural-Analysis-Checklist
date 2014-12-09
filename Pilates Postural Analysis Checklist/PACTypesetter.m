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

    if((PACPlumbLineAlignment & plumbKneesForward)     == plumbKneesForward){
        [fs addObject:@"Knees"];
    } else if((PACPlumbLineAlignment & plumbKneesBehind)      == plumbKneesBehind){
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

    if((PACChecklistMain & mainChecklistAlignedInRelation) == mainChecklistAlignedInRelation){
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
static void pac_typeset_sideview_analysis(CGContextRef pdf_ctx)
{
    pac_typeset_sideview_ankles(pdf_ctx);
    pac_typeset_sideview_knees(pdf_ctx);
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

            CGContextEndPage(pdf_ctx);
            CGContextRelease(pdf_ctx);

            res = filename;
        } while(0);

        return res;
}



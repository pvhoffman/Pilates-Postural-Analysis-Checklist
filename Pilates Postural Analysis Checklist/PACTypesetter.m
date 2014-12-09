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

            CGContextEndPage(pdf_ctx);
            CGContextRelease(pdf_ctx);

            res = filename;
        } while(0);

        return res;
}



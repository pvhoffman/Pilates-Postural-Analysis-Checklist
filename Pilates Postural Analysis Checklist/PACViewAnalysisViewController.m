//
//  PACViewAnalysisViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/11/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//
#import <stdlib.h>
#import <stdio.h>

#import "PACViewAnalysisViewController.h"
#import "PACKyphosisLordosisMainTableViewController.h"
#import "PACSwayBackMainTableViewController.h"
#import "PACGlobal.h"


static NSString* create_analysis_html_file();
@interface PACViewAnalysisViewController ()

@end

@implementation PACViewAnalysisViewController

- (void)viewDidLoad 
{
    [super viewDidLoad];

    CGRect frame = self.view.frame;
    
    self.navigationItem.title = @"Analysis";

    UIWebView* webview = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
    webview.backgroundColor = [UIColor whiteColor];
    webview.delegate = self;

    [self.view addSubview:webview];

    NSString* fileName = create_analysis_html_file();//pac_create_html_analysis();

    if(fileName && [fileName length]){
        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:fileName]]];
    }
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}
#pragma mark -
#pragma mark UIWebViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // log an error
    NSLog(@"Webview error in %s: %s", __PRETTY_FUNCTION__, [[error localizedDescription] UTF8String]);
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSURL* url = [request URL];
        NSString* urlString = [url absoluteString];
        NSRange r = [urlString rangeOfString:@"#" options:NSBackwardsSearch];
        if (r.location != NSNotFound) {
            NSString* req = [urlString substringFromIndex:r.location];
            if(req) {
                const char* cptr = [req UTF8String];

                if(cptr && *cptr && *cptr == '#') {
                        switch( *(cptr + 1) ) {
                            case '0':  // postureTypeIdeal
                                return YES;
                            case '1':  // postureTypeKyphosisLordosis
                                [self.navigationController pushViewController:[[PACKyphosisLordosisMainTableViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
                                return NO;
                            case '2':  // postureTypeSwayBack
                                [self.navigationController pushViewController:[[PACSwayBackMainTableViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
                                return NO;
                            case '3':  // postureTypeMilitary
                                return YES;
                            case '4':  // postureTypeFlatBack
                                return YES;
                        }
                }
            }
        }
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}
@end


static NSString* create_analysis_html_file()
{
        NSString* res = nil;
        FILE* fpout = 0;

        NSMutableArray* explain = [[NSMutableArray alloc] init];

        [explain addObject:[[NSMutableArray alloc] init]];;
        [explain addObject:[[NSMutableArray alloc] init]];;
        [explain addObject:[[NSMutableArray alloc] init]];;
        [explain addObject:[[NSMutableArray alloc] init]];;
        [explain addObject:[[NSMutableArray alloc] init]];;


        do {
            const float cp_ideal            = 9.0f;
            const float cp_kyphosislordosis = 9.0f;
            const float cp_swayback         = 8.0f;
            const float cp_military         = 7.0f;
            const float cp_flatback         = 8.0f;

            float ideal_count            = 0.0f;
            float kyphosislordosis_count = 0.0f;
            float swayback_count         = 0.0f;
            float military_count         = 0.0f;
            float flatback_count         = 0.0f;

            // check the head
            if((PACPlumbLineAlignment & plumbHeadAligned) == plumbHeadAligned || PACHeadSideAlignment == headSideAlignmentNeutral){
                ideal_count += 1.0f;
                military_count += 1.0f;
                [[explain objectAtIndex:postureTypeIdeal] addObject:@"head neutral"];
                [[explain objectAtIndex:postureTypeMilitary] addObject:@"head neutral"];
            }
            if((PACPlumbLineAlignment & plumbHeadForward) == plumbHeadForward || PACHeadSideAlignment == headSideAlignmentForward){
                kyphosislordosis_count += 1.0f;
                swayback_count += 1.0f;
                flatback_count += 1.0f;
                [[explain objectAtIndex:postureTypeKyphosisLordosis] addObject:@"head forward"];
                [[explain objectAtIndex:postureTypeSwayBack] addObject:@"head forward"];
                [[explain objectAtIndex:postureTypeFlatBack] addObject:@"head forward"];
            }

            // check the cervical spine
            if(PACCervicalSpineAlignment == cervicalSpineAlignmentNeutral){
                ideal_count += 1.0f;
                military_count += 1.0f;
                [[explain objectAtIndex:postureTypeIdeal] addObject:@"cervical spine neutral"];
                [[explain objectAtIndex:postureTypeMilitary] addObject:@"cervical spine neutral"];
            } else if(PACCervicalSpineAlignment == cervicalSpineAlignmentFlexed){
                kyphosislordosis_count += 1.0f;
                swayback_count += 1.0f;
                flatback_count += 1.0f;
                [[explain objectAtIndex:postureTypeKyphosisLordosis] addObject:@"cervical spine extended"];
                [[explain objectAtIndex:postureTypeSwayBack] addObject:@"cervical spine extended"];
                [[explain objectAtIndex:postureTypeFlatBack] addObject:@"cervical spine extended"];
            }

            // check the scapulae
            if(PACScapulaeBackAlignmentLeft == scapulaeBackAlignmentNeutral && PACScapulaeBackAlignmentRight == scapulaeBackAlignmentNeutral){
                ideal_count += 1.0f;
                [[explain objectAtIndex:postureTypeIdeal] addObject:@"scapulae flat agains upper back"];
            } else if(PACScapulaeBackAlignmentLeft == scapulaeBackAlignmentProtracted  && PACScapulaeBackAlignmentRight == scapulaeBackAlignmentProtracted){
                kyphosislordosis_count += 1.0f;
                [[explain objectAtIndex:postureTypeKyphosisLordosis] addObject:@"scapulae protracted"];
            }


            // check the thoracic spine
            if(PACUpperThoracicAlignment == upperThoracicAlignmentNeutral){
                ideal_count += 1.0f;
                military_count += 1.0f;
                [[explain objectAtIndex:postureTypeIdeal] addObject:@"thoracic spine normal curve"];
                [[explain objectAtIndex:postureTypeMilitary] addObject:@"thoracic spine normal curve"];
            } else if(PACUpperThoracicAlignment == upperThoracicAlignmentFlexed){
                kyphosislordosis_count += 1.0f;
                swayback_count += 1.0f;
                [[explain objectAtIndex:postureTypeKyphosisLordosis] addObject:@"thoracic spine increased flexion"];
                [[explain objectAtIndex:postureTypeSwayBack] addObject:@"thoracic spine increased flexion"];
                if(PACLowerThoracicAlignment == lowerThoracicAlignmentFlat){
                    flatback_count += 1.0f;
                    [[explain objectAtIndex:postureTypeFlatBack] addObject:@"thoracic spine increased flexion"];
                    [[explain objectAtIndex:postureTypeFlatBack] addObject:@"lower thoracic straight"];
                }
            }

            // check the lumbar spine
            if(PACLumbarAlignment == lumbarAlignmentNeutral){
                ideal_count += 1.0f;
                [[explain objectAtIndex:postureTypeIdeal] addObject:@"lumbar spine normal curve"];
            } else if(PACLumbarAlignment == lumbarAlignmentFlexed){
                kyphosislordosis_count += 1.0f;
                military_count += 1.0f;
                [[explain objectAtIndex:postureTypeKyphosisLordosis] addObject:@"lumbar spine hyperextended"];
                [[explain objectAtIndex:postureTypeMilitary] addObject:@"lumbar spine hyperextended"];
            } else if(PACLumbarAlignment == lumbarAlignmentFlat){
                swayback_count += 1.0f;
                flatback_count += 1.0f;
                [[explain objectAtIndex:postureTypeSwayBack] addObject:@"lumbar spine flat"];
                [[explain objectAtIndex:postureTypeFlatBack] addObject:@"lumbar spine flat"];
            }


            // check the pelvis
            if(PACPelvisSideAlignmentLeft == pelvisSideAlignmentNeutral && PACPelvisSideAlignmentRight == pelvisSideAlignmentNeutral){
                ideal_count += 1.0f;
                [[explain objectAtIndex:postureTypeIdeal] addObject:@"pelvis neutral position"];
            } else if(PACPelvisSideAlignmentLeft == pelvisSideAlignmentAnteriorTilt && PACPelvisSideAlignmentRight == pelvisSideAlignmentAnteriorTilt){
                kyphosislordosis_count += 1.0f;
                military_count += 1.0f;
                [[explain objectAtIndex:postureTypeKyphosisLordosis] addObject:@"pelvis anterior tilt"];
                [[explain objectAtIndex:postureTypeMilitary] addObject:@"pelvis anterior tilt"];
            } else if(PACPelvisSideAlignmentLeft == pelvisSideAlignmentPosteriorTilt && PACPelvisSideAlignmentRight == pelvisSideAlignmentPosteriorTilt){
                swayback_count += 1.0f;
                flatback_count += 1.0f;
                [[explain objectAtIndex:postureTypeSwayBack] addObject:@"pelvis posterior tilt"];
                [[explain objectAtIndex:postureTypeFlatBack] addObject:@"pelvis posterior tilt"];
            } 
            
            // check the hip joints
            if(PACHipAlignmentLeft == hipAlignmentNeutral && PACHipAlignmentRight == hipAlignmentNeutral){
                ideal_count += 1.0f;
                [[explain objectAtIndex:postureTypeIdeal] addObject:@"hips neutral"];
            } else if (PACHipAlignmentLeft == hipAlignmentFlexed && PACHipAlignmentRight == hipAlignmentFlexed){
                kyphosislordosis_count += 1.0f;
                [[explain objectAtIndex:postureTypeKyphosisLordosis] addObject:@"hips flexed"];
            } else if (PACHipAlignmentLeft == hipAlignmentExtended && PACHipAlignmentRight == hipAlignmentExtended){
                swayback_count += 1.0f;
                flatback_count += 1.0f;
                [[explain objectAtIndex:postureTypeSwayBack] addObject:@"hips extended"];
                [[explain objectAtIndex:postureTypeFlatBack] addObject:@"hips extended"];
            }

            // check the knees
            if(PACKneeAlignmentSideLeft == kneeSideAlignmentNeutral && PACKneeAlignmentSideRight == kneeSideAlignmentNeutral){
                ideal_count += 1.0f;
                [[explain objectAtIndex:postureTypeIdeal] addObject:@"knees neutral"];
            } else if(PACKneeAlignmentSideLeft == kneeSideAlignmentHyperextended && PACKneeAlignmentSideRight == kneeSideAlignmentHyperextended){
                kyphosislordosis_count += 1.0f;
                swayback_count += 1.0f;
                military_count += 1.0f;
                flatback_count += 1.0f;
                [[explain objectAtIndex:postureTypeKyphosisLordosis] addObject:@"knees hyperextended"];
                [[explain objectAtIndex:postureTypeSwayBack] addObject:@"knees hyperextended"];
                [[explain objectAtIndex:postureTypeMilitary] addObject:@"knees hyperextended"];
                [[explain objectAtIndex:postureTypeFlatBack] addObject:@"knees hyperextended"];
            }

            // check the anklss
            if(PACAnkleAlignmentLeft == ankleAlignmentNeutral && PACAnkleAlignmentRight == ankleAlignmentNeutral ){
                ideal_count += 1.0f;
                swayback_count += 1.0f;
                [[explain objectAtIndex:postureTypeIdeal] addObject:@"ankles neutral"];
                [[explain objectAtIndex:postureTypeSwayBack] addObject:@"ankles neutral"];
            } else if(PACAnkleAlignmentLeft == ankleAlignmentPlantarflex && PACAnkleAlignmentRight == ankleAlignmentPlantarflex ){
                kyphosislordosis_count += 1.0f;
                military_count += 1.0f;
                flatback_count += 1.0f;
                [[explain objectAtIndex:postureTypeKyphosisLordosis] addObject:@"ankles platar flexion"];
                [[explain objectAtIndex:postureTypeMilitary] addObject:@"ankles platar flexion"];
                [[explain objectAtIndex:postureTypeFlatBack] addObject:@"ankles platar flexion"];
            }
            NSString* filename = [NSTemporaryDirectory() stringByAppendingPathComponent:[[[NSUUID UUID] UUIDString] stringByAppendingString:@".html"]];

            fpout = fopen([filename UTF8String], "wt");
            if(!fpout) {
                NSLog(@"Cannot create file %@", filename);
                break;
            }

            fputs("<html><head></head><body>\n", fpout);

            for(int i = 0, j = (int)[explain count]; i < j; i++){
                fputs("<hr />\n", fpout);
                switch(i){
                    case postureTypeIdeal:
                        fprintf(fpout, "<h3>Ideal Posture: %2.1f%%</h3>", ((ideal_count / cp_ideal) * 100.0f));
                        break;
                    case postureTypeKyphosisLordosis:
                        fprintf(fpout, "<h3><a href='#1'>Kyphosis-Lordosis:</a> %2.1f%%</h3>", ((kyphosislordosis_count / cp_kyphosislordosis) * 100.0f));
                        break;
                    case postureTypeSwayBack:
                        fprintf(fpout, "<h3><a href='#2'>Sway-Back:</a> %2.1f%%</h3>", ((swayback_count / cp_swayback) * 100.0f));
                        break;
                    case postureTypeMilitary:
                        fprintf(fpout, "<h3><a href='#3'>Military:</a> %2.1f%%</h3>", ((military_count / cp_military) * 100.0f));
                        break;
                    case postureTypeFlatBack:
                        fprintf(fpout, "<h3><a href='#4'>Flat-Back:</a> %2.1f%%</h3>", ((flatback_count / cp_flatback) * 100.0f));
                        break;
                }
                fputs("<ul>\n", fpout);
                for(NSString* exps in [explain objectAtIndex:i]){
                    fprintf(fpout, "<li>%s</li>\n", [exps UTF8String]);
                }
                fputs("</ul>\n", fpout);
            }

            fputs("</body></html>", fpout);

            fclose(fpout);
            fpout = 0;

            res = filename;

        } while(0);

        if(fpout) fclose(fpout);

        return res;
}

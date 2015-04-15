//
//  ViewUIPrefix.h
//  MSCDemo_UI
//
//  Created by 张剑 on 15/1/15.
//
//

#ifndef MSCDemo_UI_ViewUIPrefix_h
#define MSCDemo_UI_ViewUIPrefix_h


#define _DEMO_UI_MARGIN            5
#define _DEMO_UI_PADDING          10


#define _DEMO_UI_BUTTON_HEIGHT           44
#define _DEMO_UI_NAVIGATIONBAR_HEIGHT    44
#define _DEMO_UI_TOOLBAR_HEIGHT          44
#define _DEMO_UI_STATUSBAR_HEIGHT        20
#define _DEMO_UI_TOP_MARGIN_IOS7         (_DEMO_UI_NAVIGATIONBAR_HEIGHT+_DEMO_UI_STATUSBAR_HEIGHT)  


#ifdef __IPHONE_6_0
    # define IFLY_ALIGN_CENTER  NSTextAlignmentCenter
    # define IFLY_ALIGN_LEFT    NSTextAlignmentLeft
#else
    # define IFLY_ALIGN_CENTER  UITextAlignmentCenter
    # define IFLY_ALIGN_LEFT    UITextAlignmentLeft
#endif


#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )


#define APPID_VALUE           @"5525d5bd"
#define URL_VALUE             @""                 // url
#define TIMEOUT_VALUE         @"20000"            // timeout      连接超时的时间，以ms为单位
#define BEST_URL_VALUE        @"1"                // best_search_url 最优搜索路径


#define SEARCH_AREA_VALUE     @"安徽省合肥市"
#define ASR_PTT_VALUE         @"1"
#define VAD_BOS_VALUE         @"5000"
#define VAD_EOS_VALUE         @"1800"
#define PLAIN_RESULT_VALUE    @"1"
#define ASR_SCH_VALUE         @"1"





#endif

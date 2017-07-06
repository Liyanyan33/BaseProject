//
//  RegularExDefine.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/4.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  常见的正则表达式

#ifndef RegularExDefine_h
#define RegularExDefine_h

/** emotion表情规则 */
#define emotionRegularEx @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]"
/** @规则 */
#define atRegularEx           @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+"
/** 话题规则 */
#define topicRegularEx      @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#"
/** url链接规则 */
#define urlRegularEx          @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))"


#endif /* RegularExDefine_h */


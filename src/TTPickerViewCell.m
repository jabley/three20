/**
 * Copyright 2009 Facebook
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "Three20/TTPickerViewCell.h"
#import "Three20/TTDefaultStyleSheet.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

static CGFloat kPaddingX = 8;
static CGFloat kPaddingY = 3;
static CGFloat kMaxWidth = 250;

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation TTPickerViewCell

@synthesize object = _object, selected = _selected;

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
    _object = nil;
    _selected = NO;
    
    _labelView = [[UILabel alloc] init];
    _labelView.backgroundColor = [UIColor clearColor];
    _labelView.textColor = TTSTYLEVAR(textColor);
    _labelView.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
    _labelView.lineBreakMode = UILineBreakModeTailTruncation;
    [self addSubview:_labelView];

    self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_object);
  TT_RELEASE_SAFELY(_labelView);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIView

- (void)layoutSubviews {
  _labelView.frame = CGRectMake(kPaddingX, kPaddingY,
    self.frame.size.width-kPaddingX*2, self.frame.size.height-kPaddingY*2);
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGSize labelSize = [_labelView.text sizeWithFont:_labelView.font];
  CGFloat width = labelSize.width + kPaddingX*2;
  return CGSizeMake(width > kMaxWidth ? kMaxWidth : width, labelSize.height + kPaddingY*2);
}

- (TTStyle*)style {
  if (self.selected) {
    return TTSTYLESTATE(pickerCell:, UIControlStateSelected);
  } else {
    return TTSTYLESTATE(pickerCell:, UIControlStateNormal);
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString*)label {
  return _labelView.text;
}

- (void)setLabel:(NSString*)label {
  _labelView.text = label;
}

- (UIFont*)font {
  return _labelView.font;
}

- (void)setFont:(UIFont*)font {
  _labelView.font = font;
}

- (void)setSelected:(BOOL)selected {
  _selected = selected;
  
  _labelView.highlighted = selected;
  [self setNeedsDisplay];
}

@end

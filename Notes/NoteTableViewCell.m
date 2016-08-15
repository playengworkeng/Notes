//
//  NoteTableViewCell.m
//  Notes
//
//  Created by J on 8/14/16.
//  Copyright © 2016 Thinkful. All rights reserved.
//

#import "NoteTableViewCell.h"

@implementation NoteTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    
    return self;
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

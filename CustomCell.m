//
//  CustomCell.m
//  CelulasCustomizadas
//
//  Created by Dário on 13/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomCell.h"




@implementation CustomCell

@synthesize titulo;
@synthesize subtitulo;
@synthesize conteudo;
@synthesize viewCell;
@synthesize imagem;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[titulo release];
	[subtitulo release];
	[conteudo release];
    [super dealloc];
}


@end

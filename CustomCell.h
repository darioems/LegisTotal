//
//  CustomCell.h
//  CelulasCustomizadas
//
//  Created by Dário on 13/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomCell : UITableViewCell {

IBOutlet UILabel *titulo;
IBOutlet UILabel *subtitulo;
IBOutlet UILabel *conteudo;
IBOutlet UIView *viewCell;
IBOutlet UIImageView *imagem;
}

@property (nonatomic,retain) IBOutlet UILabel *titulo;
@property (nonatomic,retain) IBOutlet UILabel *subtitulo;
@property (nonatomic,retain) IBOutlet UILabel *conteudo;
@property (nonatomic,retain) IBOutlet UIView *viewCell;
@property (nonatomic,retain) IBOutlet UIImageView *imagem;

@end

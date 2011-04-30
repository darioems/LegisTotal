//
//  ViewWithWebViewController.h
//  Legislacao
//
//  Created by Dário on 23/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LegisTotal;

@interface ViewWithWebViewController : UIViewController {
    
    LegisTotal *artigo;
    
    IBOutlet UIWebView *artigoWeb;
}

-(id)initWithArtigoId:(int*)artigoIdAux;

@property (nonatomic, retain) UIWebView *artigoWeb;

@end

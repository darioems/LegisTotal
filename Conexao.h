//
//  Conexao.h
//  Legislacao
//
//  Created by Dário on 23/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>


@interface Conexao : NSObject {

}

-(sqlite3 *) getDatabase;

@end

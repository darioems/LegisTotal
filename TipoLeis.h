//
//  TipoLegislacao.h
//  Legislacao
//
//  Created by Dário on 23/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TipoLeis : NSObject {
	
	int *idTipo;
	NSString *tipo;
	NSString *descricao;

}

@property (nonatomic, assign) int *idTipo;
@property (nonatomic, retain) NSString *tipo, *descricao;

// Busca todos os Tipos de Legislação
+(NSMutableArray*)getAllTipo;

// Busca o Tipo de Legislação pelo seu id
+(TipoLeis *)getTiposWithIdTipo:(int*)idTipoAux;

@end

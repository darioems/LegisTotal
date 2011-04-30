//
//  Legislacao.h
//  Legislacao
//
//  Created by Dário on 23/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LegisTotal : NSObject {
    
    int *idLegis;
    int *idTipo;
    int *idPai;
	NSString *descricao;
	NSString *texto;
    
}

@property (nonatomic, assign) int *idLegis, *idTipo,*idPai;

@property (nonatomic, retain) NSString *descricao, *texto;

// Busca todas Leis
+(NSMutableArray*)getAllLeis;

// Busca a Legis pelo seu id
+(LegisTotal *)getLegisWithIdLegis:(int*)idLegisAux;

// Busca todos Filhos
+(NSMutableArray*)getAllFilhosWithIdLegis:(int *)idLegisAux;

// Busca pelo Tipo
+(NSMutableArray*)getAllWithIdTipo:(int *)idTipoAux;

// Monta o índice da Lei
+(NSMutableArray*)getIndiceWithIdLegis:(int *)idLegisAux;


@end

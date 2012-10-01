package test;
import haxe.macro.Expr;
import haxe.macro.Context;
using Arrays;
class Builder {
    @:macro public static function build() : Array<Field> {
        var pos = haxe.macro.Context.currentPos();
        var fields = haxe.macro.Context.getBuildFields();
        
        //$type(fields);
        
        var tstring=TPath({ pack : [], name : "Dynamic", params : [], sub : null });
        var tint = TPath({ pack : [], name : "Array", params : [TPType(tstring)], sub : null });
        
        var meta=[];
        for (field in fields){
        	
        	if (field.name!=null && field.access.exists(APublic)){
				
				var mtName=if (field.meta!=null && field.meta.length>0) 
					field.meta[0].name;	
				else
					"";
        		switch (field.kind){
        			case FVar( t , e):
        				var f={};
        				Reflect.setField(f,field.name,mtName);
						meta.push(f);	
					case FProp( get , set , t, e):
						var f={};
						Reflect.setField(f,field.name,mtName);
						meta.push(f);	
        			default:
        		}

        	}
        		
        		
        }


        fields.push({ 
        	name : "fields",
         	doc : null, 
         	meta : [], 
         	access : [AStatic , APublic], 
         	kind : FVar(tint,Context.makeExpr(meta,Context.currentPos())), 
         	pos : pos
        });
        return fields;
    }
}
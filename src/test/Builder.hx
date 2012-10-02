package test;
import haxe.macro.Expr;
import haxe.macro.Context;
import thx.validation.StringLengthValidator;
using Arrays;
class Builder {
    @:macro public static function build() : Array<Field> {
        var pos = haxe.macro.Context.currentPos();
        var fields = haxe.macro.Context.getBuildFields();
        
        //$type(fields);
        
        var tstring=TPath({ pack : [], name : "Dynamic", params : [], sub : null });
        var tint = TPath({ pack : [], name : "Array", params : [TPType(tstring)], sub : null });
        
        var validation="new thx.validation.StringLengthValidator(1, 100)";
        var mtName=validation ;//Context.makeExpr(validation, Context.currentPos());
        
        var meta="[";
        for (field in fields){
        	
        	if (field.name!=null && field.access.exists(APublic)){
				
				
    //             if (field.meta!=null && field.meta.length>0) 
				// 	field.meta[0].name;	
				// else
				// 	"";
        		switch (field.kind){
        			case FVar( t , e):
        				
        				meta+="{name:'"+field.name+"',validation:"+mtName+"},";
						
					case FProp( get , set , t, e):
						meta+="{name:'"+field.name+"',validation:"+mtName+"},";
        			default:
        		}

        	}
        		
        		
        }
        meta+="]";

        trace(meta);

        fields.push({ 
        	name : "fields",
         	doc : null, 
         	meta : [], 
         	access : [AStatic , APublic], 
         	kind : FVar(tint,Context.parse(meta,Context.currentPos())), 
         	pos : pos
        });
        return fields;
    }
}
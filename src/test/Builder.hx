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
        
       
        var tUser=TPath({ pack : ["test"], name : "User", params : [], sub : null });
        var tString=TPath({ pack : [], name : "String", params : [], sub : null });
        // var tClassIntrospector=TPath({ pack : ["introspector"], name : "ClassIntrospector", params : [TPType(tUser)], sub : null });
        var introspectorFields=new Array<Field>();
        
        for (field in fields){
            if (field.name!=null && field.access.exists(APublic)){
                var addIt=false;
                var type;
                switch (field.kind){
                    case FVar( t , e):
                        addIt=true;
                        type=t;
                    case FProp( get , set , t, e):
                        addIt=true;
                        type=t;
                    default:
                }
                type=tString;   
                if (addIt)
                    introspectorFields.push({
                        name : field.name,
                        access : [Access.APublic],
                        kind : FieldType.FVar(TPath({ pack : ["introspector"], name : "FieldIntrospector", params : [TPType(tUser),TPType(type)], sub : null })),
                        pos : pos
                        
                    });
            }
        }
        




        Context.defineType({
            pack : ["test"],
            name : "UserIntrospector",
            pos : pos,
            meta : [],
            params : [],
            isExtern : false,
            kind : TDClass({
                 pack : ["introspector"],
                 name : "ClassIntrospector",
                 params : [TPType(tUser)]
            }),
            fields : introspectorFields
        });

        var tUserIntrospector=TPath({ pack : ["test"], name : "UserIntrospector", params : [], sub : null });

        var tstring=TPath({ pack : [], name : "Dynamic", params : [], sub : null });
        var tint = TPath({ pack : [], name : "Array", params : [TPType(tstring)], sub : null });
        
        var validation="new thx.validation.StringLengthValidator(1, 100)";
        var mtName=validation ;//Context.makeExpr(validation, Context.currentPos());
        



        var meta="null";
     //    for (field in fields){
        	
     //    	if (field.name!=null && field.access.exists(APublic)){
				
				

     //    		switch (field.kind){
     //    			case FVar( t , e):
        				
     //    				meta+="{name:'"+field.name+"',validation:"+mtName+"},";
						
					// case FProp( get , set , t, e):
					// 	meta+="{name:'"+field.name+"',validation:"+mtName+"},";
     //    			default:
     //    		}

     //    	}
        		
        		
     //    }
     //    meta+="]";

        //trace(meta);

        fields.push({ 
        	name : "introspector",
         	doc : null, 
         	meta : [], 
         	access : [AStatic , APublic], 
         	kind : FVar(tUserIntrospector,Context.parse(meta,Context.currentPos())), 
         	pos : pos
        });
        return fields;
    }
}
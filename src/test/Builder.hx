package test;
import haxe.macro.Expr;
import haxe.macro.Context;
import thx.validation.StringLengthValidator;
using Arrays;
class Builder {
    @:macro public static function build() : Array<Field> {
        var pos = haxe.macro.Context.currentPos();
        var fields = haxe.macro.Context.getBuildFields();
        
        //add fields to class
       
        var tUser=TPath({ pack : ["test"], name : "User", params : [], sub : null });
        var tString=TPath({ pack : [], name : "String", params : [], sub : null });
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
                //type=tString;   
                if (addIt)
                    introspectorFields.push({
                        name : field.name,
                        access : [Access.APublic],
                        kind : FieldType.FVar(TPath({ pack : ["introspector"], name : "FieldIntrospector", params : [TPType(tUser),TPType(type)], sub : null })),
                        pos : pos
                        
                    });
            }
        }
        

        //build class constructor body, constructor create all fields
       
        var body:String=Std.format('{super("User",null,"","");');
        for (field in fields){
            
            if (field.name!=null && field.access.exists(APublic)){
                var addIt=false;
                var type="";
                switch (field.kind){
                    case FVar( t , e):
                        addIt=true;
                        switch (t){
                            case TPath(t2) :
                                type=t2.pack.join(".");
                                if (type!=null && type!="")
                                    type+=".";
                                type+= t2.name;
                                if (t2.params.length>0){
                                    type+= "<";
                                    for (param in t2.params)    
                                        switch (param){
                                            case TPExpr(expr):
                                                switch(expr.expr){
                                                    case EConst(c):    
                                                        switch(c){
                                                            case CInt(v):
                                                                type+=Std.string(v);
                                                            default:    
                                                        }
                                                        
                                                    default:
                                                }
                                                
                                            default:    
                                        }
                                        type+=">";
                                }
                            default:   
                        }

                    case FProp( get , set , t, e):
                        addIt=true;
                        switch (t){
                            case TPath(t2) :
                                type=t2.pack.join(".");
                                if (type!=null && type!="")
                                    type+=".";
                                type+= t2.name;
                                if (t2.params.length>0){
                                    type+= "<";
                                    for (param in t2.params)    
                                        switch (param){
                                            case TPExpr(expr):
                                                switch(expr.expr){
                                                    case EConst(c):    
                                                        switch(c){
                                                            case CInt(v):
                                                                type+=Std.string(v);    
                                                            default:
                                                        }
                                                        
                                                    default:
                                                }
                                                
                                            default:    
                                        }
                                        type+=">";
                                }
                            default:   
                        }
                    default:
                }
                Sys.println(type);  
                if (addIt){
                    body+=Std.format('\nthis.${field.name} = new introspector.FieldIntrospector<User,$type>(
                            "${field.name}",
                            null,
                            true,
                            "",
                            "",
                            function(instance:User,value:$type){
                                instance.${field.name} = value;
                            },
                            function(instance:User):$type{
                                return instance.${field.name};
                            }
                        );
                    ');
                }
            }
        }
        body+="}";
        
        //add constructors

        var tVoid=TPath({ pack : [], name : "Void", params : [], sub : null });
        

        introspectorFields.push({
            name : "new",
            access : [Access.APublic],
            kind : FieldType.FFun( {
                args : [],
                ret : tVoid,
                expr : Context.parse(body,pos),
                params : []
            } ),
            pos : pos
            
        });


        //define new types

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

        //add static field to class with introspector instance
   
        fields.push({ 
        	name : "introspector",
         	doc : null, 
         	meta : [], 
         	access : [AStatic , APublic], 
         	kind : FVar(
                    tUserIntrospector,
                    Context.parse("new test.UserIntrospector()",Context.currentPos())
                ), 
         	pos : pos
        });
        return fields;
    }
}
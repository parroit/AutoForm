package autoform;
import thx.util.Result;
import thx.validation.StringLengthValidator;
using Reflect;
using Arrays;
using StringTools;

class Reflection 
{

	private static function typeMetaDefaults(){
		return {
			String:{
				widget:"text",
				validation: [],
				name:String,
				required:false,
				description:"",
				help:"",
				placeholder:"",
				title:"",
				display:"",
				displayOptions:{},
			},
			"sys.db.SString":{
				widget:"text",
				validation: [],
				name:String,
				required:false,
				description:"",
				help:"",
				placeholder:"",
				title:"",
				display:"",
				displayOptions:{},
			},
			"sys.db.SBool":{
				widget:"checkbox",
				validation: [],
				name:String,
				required:false,
				description:"",
				help:"",
				placeholder:"",
				title:"",
				display:"",
				displayOptions:{},
			}
		};
	}

	// @:macro public static function buildValidator(validator:String) : Expr {
 //        return macro $validator;
 //    }

	public static function of(form:AutoForm,clazz:Dynamic,?fields:Array<String>=null) {
		
		var defaults =typeMetaDefaults();
		

		//var clazzName=Type.getClassName(clazz).replace(".","_");
		
		var rttiString  = untyped clazz.__rtti;
		
        var rtti = Xml.parse(rttiString);
		
		var metaClazz = haxe.rtti.Meta.getFields(clazz);
		
		

        var fieldsXml = rtti;
		
        form.meta={
			name:Type.getClassName(clazz),
			caption:Type.getClassName(clazz),
			validation:[],
			tooltip:"",
			fields:{}
		
		};
		
		
        for (field in rtti.firstElement().elements())
        {
        	
    		var typeNode=field.firstElement();
        	
			if ((fields==null || Reflect.hasField(fields,field.nodeName)) && typeNode!=null && Strings.trim(Std.string(typeNode)," \n\t")!="") {
				
				
				if (typeNode.nodeName=="c" || typeNode.nodeName=="t") {
					var fieldTypeName= typeNode.get("path");
					
					var typeMetaDefault= Reflect.getProperty(defaults,fieldTypeName);
					var meta:autoform.FieldMetadata= Reflect.copy(typeMetaDefault);
					
					meta.name=field.nodeName;

					var fieldMeta = Reflect.field(metaClazz,meta.name);
						
					if (meta.name!="manager" && fieldMeta != null)
			    	{
			    		
			    		if (Reflect.field(fieldMeta,"autoform") != null)
			    		{
			    			// Get the autoform object from meta
			    			var autoform:Dynamic = cast fieldMeta.autoform[0];

							meta.widget= autoform.field("widget");

			    			// Extract the human readable name
			    			meta.title= autoform.field("title");
			    			
			    			// Extract whether this is required
			    			meta.required = autoform.field("required");
			    			
			    			// Extract the description
			    			meta.description = autoform.field("description");
			    			
			    			// Extract the help
			    			meta.help = autoform.field("help");
			    			
			    			// Extract the placeholder
			    			meta.placeholder = autoform.field("placeholder");
			    			
			    			// Extract the display type
			    			meta.display = autoform.field("display");
			    			
			    			// Extract the display options
			    			meta.displayOptions = autoform.field("displayOptions");


			    			// if (autoform.field("validation")!=null)
			    			// 	meta.validation=[]	

			    		} 
			    	}

					Reflect.setField(
						form.meta.fields,
						field.nodeName,
						meta
					);

				}	
			
			}		
        }


        return form;	
				
	}

	

	public static function fill(form:AutoForm,model:Dynamic){
		for(fld in Reflect.fields(form.meta.fields)){
			if (fld!="manager"){
				var fieldMeta:FieldMetadata=Reflect.getProperty(form.meta.fields,fld);

				var fieldValue={
					error:Result.Ok,
					value:Reflect.getProperty(model,fieldMeta.name),
					meta:fieldMeta
				};
				
				Reflect.setField(
					form.data.fields,
					fieldMeta.name,
					fieldValue
					);
					
			}		
			
			
		}
		return form;
	}


	public static function toModel(form:AutoForm,model:Dynamic){
		Sys.println(model);
		for(fld in Reflect.fields(form.meta.fields)){
			if (fld!="manager"){
				Sys.println(fld);
				var fieldMeta:FieldMetadata=Reflect.getProperty(form.meta.fields,fld);
				var fieldValue:FieldData=Reflect.getProperty(form.data.fields,fieldMeta.name);
				
				
				
				Reflect.setField(
					model,
					fieldMeta.name,
					fieldValue.value
					);
					
			}		
			
			
		}
		return form;
	}



}
package autoform;
import thx.util.Result;
import thx.validation.StringLengthValidator;
using Reflect;
using Arrays;

class Reflection 
{

	private static function typeMetaDefaults(){
		return {
			String:{
				widget:"text",
				validation: [new StringLengthValidator(0,100) ],
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
				validation: [new StringLengthValidator(0,100) ],
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

	public static function of<T>(form:AutoForm,clazz:Class<T>,?fields:Array<String>=null) {
		
		var defaults =typeMetaDefaults();
		

		
		var rttiString  = untyped __php__("model_User::$__rtti");

		
        var rtti = Xml.parse(rttiString);
		//trace( rtti);
		var metaClazz = haxe.rtti.Meta.getFields(clazz);
		
		

        var fieldsXml = rtti;//.elements();
		
        form.meta={
			name:Type.getClassName(clazz),
			caption:Type.getClassName(clazz),
			validation:[],
			tooltip:"",
			fields:{}
		
		};
		
		//trace( fieldsXml);
        for (field in rtti.firstElement().elements())
        {
        	//var field=Reflect.field(fieldsXml,fieldN);
    		//trace("<br/><br/><br/>"+"|"+Std.string(field)+"|<br/><br/><br/>");
    		var typeNode=field.firstElement();
        	
			if ((fields==null || fields.exists(field.nodeName)) && typeNode!=null && Strings.trim(Std.string(typeNode)," \n\t")!="") {
				
				
				if (typeNode.nodeName=="c" || typeNode.nodeName=="t") {
					var fieldTypeName= typeNode.get("path");
					
					var typeMetaDefault= Reflect.getProperty(defaults,fieldTypeName);
					
//					trace(fieldTypeName+" "+Std.string(typeMetaDefault));

					var meta:autoform.FieldMetadata= Reflect.copy(typeMetaDefault);
					
					
					meta.name=field.nodeName;



					var fieldMeta = Reflect.field(metaClazz,meta.name);
						
					if (meta.name!="manager" && fieldMeta != null)
			    	{
			    		
			    		if (Reflect.field(fieldMeta,"autoform") != null)
			    		{
							//trace(meta);

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
			    			//trace(meta);
			    		} 
			    			//trace("not found");
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
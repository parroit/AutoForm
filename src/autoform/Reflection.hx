package autoform;
import thx.util.Result;
import thx.validation.StringLengthValidator;
class Reflection 
{

	private static function typeMetaDefaults(){
		return {
			String:{
				widget:"text",
				validation: [new StringLengthValidator(0,100) ],
			}
		};
	}

	public static function of<T>(form:AutoForm,clazz:Class<T>) {
		var defaults =typeMetaDefaults();
		

		
		var rttiString : String = untyped clazz.__rtti;
        var rtti = Xml.parse(rttiString).firstElement();
		var meta = haxe.rtti.Meta.getFields(clazz);

        var fieldsXml = rtti.elements();

        for (field in fieldsXml)
        {
    		var typeNode=field.firstChild();
        	
			if ( typeNode!=null && Strings.trim(Std.string(typeNode)," \n\t")!="") {
				
				trace( typeNode.nodeName);
				if (typeNode.nodeName=="c") {
					var fieldTypeName= typeNode.get("path");
					var typeMetaDefault= Reflect.getProperty(defaults,fieldTypeName);
					var meta= Reflect.copy(typeMetaDefault);
					meta.name=field.nodeName;
					

					var fieldMeta = Reflect.field(meta,meta.name);
					if (fieldMeta != null)
			    	{
			    		if (Reflect.field(fieldMeta,"autoform") != null)
			    		{
			    			// Get the autoform object from meta
			    			var autoform:Dynamic = cast fieldMeta.autoform[0];

			    			// Extract the human readable name
			    			meta.title = autoform.field("title");
			    			
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
			
			var fieldMeta:FieldMetadata=Reflect.getProperty(form.meta.fields,fld);
			
			//trace(fieldMeta);

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
		return form;
	}


}
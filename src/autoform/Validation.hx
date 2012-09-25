package autoform;
import thx.validation.IValidator;
import thx.util.Result;
import autoform.FieldMetadata;


class Validation{
	public static function addFormRule(form:AutoForm,rule:IValidator<Dynamic>){
		form.meta.validation.push (rule);  
	}
	public static function addRule(field:FieldMetadata,rule:IValidator<Dynamic>){
		field.validation.push (rule);  
	}



	public static function validate(form:AutoForm){
		
		var errors=false; 
		for(fieldN in Reflect.fields(form.data.fields)){
			var field=Reflect.field(form.data.fields,fieldN);
			for (rule in cast(field.meta.validation,Array<Dynamic>)){
				
				field.error=rule.validate(field.value);
				//Sys.println(field.error);	
				switch (field.error) {
					case Result.Ok:
					case Result.Failure(msg):
						errors=true;
				}

				
			}
			
		}

		for (rule in cast(form.meta.validation,Array<Dynamic>)){
			
			form.data.error=rule.validate(form.data.fields);
			//Sys.println(form.data.error);
			switch (form.data.error) {
				case Result.Ok:
				case Result.Failure(msg):
					errors=true;
			}

			if (errors) break;
		}

		//Sys.println("validate!!"+errors);
		return !errors;
	}
}
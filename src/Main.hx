import thx.validation.IValidator;
import thx.validation.StringLengthValidator;
import thx.util.Result;


typedef FieldMetadata = {
	name:String,
	widget:String,
	caption:String,
	validation:Array<IValidator<Dynamic>>,
	tooltip:String
}

typedef ModelMetadata = {
	name:String,
	caption:String,
	validation:Array<IValidator<Dynamic>>,
	tooltip:String,
	fields:{}

}


typedef FieldData  = {
	error:Result,
	value:String,
	meta:FieldMetadata
}

typedef ModelData = {
	error:Result,
	fields:Dynamic

}


class AutoForm {
	public function new(){
		data={
			error:null,
			fields:{}
		};
	}
	public var meta:ModelMetadata;
	public var data:ModelData;

	public function toString(){
		return Std.string(data);
	}

}



interface FieldBinder
{
	public function modelToForm():Void;
	public function formToModel():Void;
}

interface ModelBinder
{
	public function modelToForm():Void;
	public function formToModel():Void;
	
}



interface FormRenderer
{
	public function render():Void;
	
	
			
}

interface FieldRenderer
{
	public function render(value:FieldData):Void;
	public var fieldName:String;
	
}

class RenderingEngine{
	public function with(form :AutoForm):FormRenderer{return null;}
}



class ConsoleFormRenderer implements FormRenderer
{
	private var autoForm:AutoForm;
	public function new(autoForm:AutoForm){
		this.autoForm=autoForm;
		this.fields=[];
		
	}
	public function render(){
		for (field in fields){
			field.render(Reflect.getProperty(autoForm.data.fields,field.fieldName));
		}
	}
	public var fields:Array<FieldRenderer>;
	
			
}

class ConsoleTextFieldRenderer implements FieldRenderer
{
	public var fieldName:String;
	public function new( fieldName:String){
		this.fieldName=fieldName;	
	}
	public function render(data:FieldData){
		Sys.println(data.meta.caption+": "+data.value);
	}
	
}
class ConsolePasswordFieldRenderer implements FieldRenderer
{
	public var fieldName:String;
	public function new( fieldName:String){
		this.fieldName=fieldName;	
	}
	public function render(value:FieldData){
		Sys.println(value.meta.caption+": *********");
	}
}

class ConsoleRenderingEngine{
	private var register:Hash<String->FieldRenderer>;
	public function new(){
		 register=new Hash<String->FieldRenderer>();
		 register.set("text",function (fieldName) {return new ConsoleTextFieldRenderer(fieldName);});
		 register.set("password",function (fieldName) {return new ConsolePasswordFieldRenderer(fieldName);});
	}
	public function with(form :AutoForm):FormRenderer{
		var renderer=new ConsoleFormRenderer(form);
		for (fieldName in Reflect.fields(form.meta.fields)){
			var field=Reflect.getProperty(form.meta.fields,fieldName);
			var buildWidget=register.get(field.widget);
			renderer.fields.push(buildWidget(field.name));
		}
		return renderer;
	}
}



class ReflectModelBinder implements ModelBinder
{


	public function modelToForm(){
		for(fld in fields){
			fld.modelToForm();		
		}
	}
	public function formToModel(){
		for(fld in fields){
			fld.formToModel();		
		}
	}

	public function new(model:Dynamic,form:AutoForm){
		this.model=model;
		this.form=form;
		fields=[];

		for(fld in Reflect.fields(form.meta.fields)){
			
			var fieldData:FieldMetadata=Reflect.getProperty(form.meta.fields,fld);
			
			var fieldValue={
				error:Result.Ok,
				value:"",
				meta:fieldData
			};
			var flds=form.data.fields;
			//trace("fieldValue="+fieldValue);
			
			Reflect.setField(flds,fieldData.name,fieldValue);
			
			//trace("binder");
			
			var binder=new ReflectFieldBinder(model,fieldValue);
			
			fields.push(binder);	
		}

		
	}

	private var fields:Array<FieldBinder>;
	
	private var model:Dynamic;

	private var form:AutoForm;


}

class ReflectFieldBinder implements FieldBinder
{


	public function modelToForm(){
		
		//trace (model);
		field.value=Reflect.getProperty(model,field.meta.name);
		//trace (field.meta.name+" to form "+field.value );
	}
	public function formToModel(){
		Reflect.setProperty(model,field.meta.name,field.value);
	}
	public function new(model:Dynamic,field:FieldData){
		//trace("start");
		this.model=model;
		this.field=field;
		//trace("start");
	}

	
	private var model:Dynamic;
	
	private var field:FieldData;



}



class Main{
	public static function controller():AutoForm{
		var form=new AutoForm();
		var nameAttr={
					name:"name",
					widget:"text",
					caption:"User Name",
					validation: [ new StringLengthValidator(0,10) ],
					tooltip:"",
				};
		var passwordAttr={
					name:"password",
					widget:"password",
					caption:"User Password",
					validation: [ new StringLengthValidator(0,10) ],
					tooltip:"",
				};
		
		form.meta={
			name:"user",
			caption:"Edit user",
			validation: [],
			tooltip:"",
			
			fields : {
				name:nameAttr,
				password:passwordAttr
			},
					
		};

		var newUser={
			name:"type your name",
			password:"type your password"
			
		}

		var binder=new ReflectModelBinder(newUser,form);	

		binder.modelToForm();	


		return form;
	} 
	
	public static function view(form:AutoForm){
		new ConsoleRenderingEngine().with(form).render();
	}

	public static function main() {
       view(controller());
      
    }

}

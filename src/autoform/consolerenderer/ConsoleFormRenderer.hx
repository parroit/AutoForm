package autoform.consolerenderer;

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


}




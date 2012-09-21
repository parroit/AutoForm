package autoform.consolerenderer;
class ConsoleTextFieldRenderer implements FieldRenderer
{
	public var fieldName:String;
	public function new( fieldName:String){
		this.fieldName=fieldName;	
	}
	public function render(data:FieldData){
		Sys.println(data.meta.caption+": "+data.value);
	}
	
package autoform.consolerenderer;
class ConsolePasswordFieldRenderer implements FieldRenderer
{
	public var fieldName:String;
	public function new( fieldName:String){
		this.fieldName=fieldName;	
	}
	public function render(value:FieldData){
		Sys.println(value.meta.display+": *********");
	}
}

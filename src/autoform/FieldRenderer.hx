package autoform;
interface FieldRenderer
{
	public function render(value:FieldData):Void;
	public var fieldName:String;
	
}
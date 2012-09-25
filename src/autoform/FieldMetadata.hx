package autoform;
import thx.validation.IValidator;
typedef  FieldMetadata  = {
	name:String,
	widget:String,
	validation:Array<IValidator<Dynamic>>,
	required:Bool,
	description:String,
	help:String,
	placeholder:String,
	title:String,
	display:String,
	displayOptions:Dynamic,
}
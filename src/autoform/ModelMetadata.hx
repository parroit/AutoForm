package autoform;
import thx.validation.IValidator;
typedef ModelMetadata = {
	name:String,
	caption:String,
	validation:Array<IValidator<Dynamic>>,
	tooltip:String,
	fields:Dynamic

}
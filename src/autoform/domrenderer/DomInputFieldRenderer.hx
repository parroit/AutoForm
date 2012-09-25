
package autoform.domrenderer;
import thx.util.Result;
import autoform.renderer.HtmlTag;
class DomInputFieldRenderer implements FieldRenderer
{
	public var fieldName:String;
	public var inputType:String;
	public var parent:HtmlTag;
	public function new( fieldName:String,inputType:String,parent:HtmlTag,renderInput:HtmlTag->FieldData->Void=null){
		this.inputType=inputType;
		this.parent=parent;
		this.fieldName=fieldName;	
		if (renderInput!=null)
			this.renderInput=renderInput;
		else
			this.renderInput=function (it:HtmlTag,data:FieldData){
				it.input({"type":inputType,"id":fieldName,"name":fieldName,"class":fieldName+"-input",value:data.value });
			};
	}

	public var renderInput:HtmlTag->FieldData->Void;

	public function render(data:FieldData){
		
		parent.div({"id":fieldName+"-form-container","class":"form-container"},function(it:HtmlTag){
			it.label({"for":fieldName,"id":fieldName+"-label","class":"form-label" })
				.text(data.meta.title);
			renderInput(it,data);
			
			switch (data.error){
				case Result.Ok():
					if (data.meta.help!=""){
						it.div({
							id:"help-"+fieldName,
							"class":"field-help"
						}).text(data.meta.help) ;
					}
				case Result.Failure(messages):
					it.div({
						id:"error-"+fieldName,
						"class":"validation-error"
					}).text(Std.string(messages) );
			}
		});
	}
	
}
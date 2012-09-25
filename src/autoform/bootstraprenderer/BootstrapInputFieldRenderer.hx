
package autoform.bootstraprenderer;
import thx.util.Result;
import autoform.renderer.HtmlTag;
using StringTools;
using Arrays;

class BootstrapInputFieldRenderer implements FieldRenderer
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
		


		parent.div({"id":fieldName+"-form-container","class":"control-group" + if (data.error!=Result.Ok) " error" else ""},function(it:HtmlTag){
			

			it.label({"for":fieldName,"id":fieldName+"-label","class":'control-label'})
				.text(data.meta.title);
			it.div({"id":fieldName+"-control","class":"controls"},function(it:HtmlTag){
				renderInput(it,data);
				
				switch (data.error){
					case Result.Ok():
						if (data.meta.description!=""){
							it.span({
								id:"help-"+fieldName,
								"class":"help-inline"
							}).text(data.meta.description) ;
						}
					case Result.Failure(messages):
						it.span({
							id:"error-"+fieldName,
							"class":"help-inline"
						}).text(messages.join("<br/>"));
				}
			});
		});
	}
	
}
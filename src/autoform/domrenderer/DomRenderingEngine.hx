package autoform.domrenderer;
import autoform.FieldRenderer;
import autoform.renderer.BaseRenderingEngine;
import autoform.renderer.HtmlTag;

class DomRenderingEngine extends BaseRenderingEngine{ 
		
	public function new(document:HtmlTag,action:String){
		 super(document);
		 this.renderer=function (form){return new DomFormRenderer(form,document,action);};
		 
		 register.set("text",function (fieldName) {return new DomInputFieldRenderer(fieldName,"text",document);});
		 register.set("password",function (fieldName) {return new DomInputFieldRenderer(fieldName,"passowrd",document);});
		 register.set("checkbox",function (fieldName) {return new DomInputFieldRenderer(fieldName,"checkbox",document,function (it,data) {

				if (data.value=="on")
					it.input({"type":"checkbox","id":fieldName,"name":fieldName,"class":fieldName+"-input",checked:"checked"});
				else
					it.input({"type":"checkbox","id":fieldName,"name":fieldName,"class":fieldName+"-input"});
			});
		 });
	}
	
}
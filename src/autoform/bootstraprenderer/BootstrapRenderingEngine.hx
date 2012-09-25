package autoform.bootstraprenderer;
import autoform.FieldRenderer;
import autoform.renderer.BaseRenderingEngine;
import autoform.renderer.HtmlTag;

class BootstrapRenderingEngine extends BaseRenderingEngine{ 
		
	public function new(document:HtmlTag,action:String,defaultSubmit:String){
		 super(document);
		 this.renderer=function (form){return new BootstrapFormRenderer(form,document,action,defaultSubmit);};
		 
		 register.set("text",function (fieldName) {return new BootstrapInputFieldRenderer(fieldName,"text",document);});
		 register.set("password",function (fieldName) {return new BootstrapInputFieldRenderer(fieldName,"password",document);});
		 register.set("checkbox",function (fieldName) {return new BootstrapInputFieldRenderer(fieldName,"checkbox",document,function (it,data) {

				if (data.value=="on")
					it.input({"type":"checkbox","id":fieldName,"name":fieldName,"class":fieldName+"-input",checked:"checked"});
				else
					it.input({"type":"checkbox","id":fieldName,"name":fieldName,"class":fieldName+"-input"});
			});
		 });
	}
	
}
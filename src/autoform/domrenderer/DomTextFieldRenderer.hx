package autoform.domrenderer;
import autoform.domrenderer.DomInputFieldRenderer;
import autoform.renderer.HtmlTag;

class DomTextFieldRenderer extends DomInputFieldRenderer
{
	public function new( fieldName:String,parent:HtmlTag){
		super(fieldName,"text",parent);
	}
	
	
}
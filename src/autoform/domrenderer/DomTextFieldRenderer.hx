
package autoform.domrenderer;
import autoform.domrenderer.DomInputFieldRenderer;
class DomTextFieldRenderer extends DomInputFieldRenderer
{
	public function new( fieldName:String,document:HtmlTag){
		super("text",fieldName,document)
	}
	
	
}
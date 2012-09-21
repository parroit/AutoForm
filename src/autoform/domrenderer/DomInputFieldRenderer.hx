
package autoform.domrenderer;

class DomInputFieldRenderer implements FieldRenderer
{
	public var fieldName:String;
	public var inputType:String;
	private var document:HtmlTag;
	public function new( fieldName:String,document:HtmlTag,inputType:String){
		this.document=document;
		this.inputType=inputType;
	
		this.fieldName=fieldName;	
	}
	public function render(data:FieldData){
		
		document.div({"id":fieldName+"-form-container","class":"form-container"},function(it:HtmlTag){
			it.label({"for":fieldName,text:data.meta.title,"id":fieldName+"-label","class":"form-label" });
			it.input({"type":inputType,"id":fieldName+"-input","class":"form-input" });
		});
	}
	
}
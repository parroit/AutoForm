package autoform.renderer;

class HtmlDocument{

	public static function html(document:Xml,attributes:Dynamic=null,children:Dynamic->Void=null):HtmlTag{
		var html =  new HtmlTag();
		html.init("div",attributes,children);
		html.parentNode=document;
		return html;
	}



	public static function create(){
		return Xml.createDocument();
	}
}

// class BodyTag extends Tag{
// 	public function new(){}
// 	public override function init(tagName:String,attributes:Dynamic,children:BodyTag->Void) {
// 		return super.init(tagName,attributes,children);
// 	}
// 	public function div(attributes:Dynamic,children:BodyTag->Void){
// 		return add(new BodyTag().init("div",attributes,children));
		
// 	}	
// }
// class HeadTag extends Tag{
// 	public function new(){}
// 	public override function init(tagName:String,attributes:Dynamic,children:HeadTag->Void) {
// 		return super.init(tagName,attributes,children);
// 	}
// 	public function title(attributes:Dynamic,children:HeadTag->Void){
// 		return add(new HeadTag().init("title",attributes,children));
		
// 	}	
// }


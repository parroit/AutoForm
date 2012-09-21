package autoform.domrenderer;

class HtmlTag extends Tag{
	public function new(){}
	public override function init(tagName:String,attributes:Dynamic,children:Dynamic->Void) {
		return super.init(tagName,attributes,children);
	}

	public function body(attributes:Dynamic=null,children:Dynamic->Void=null){
		return add(new HtmlTag().init("body",attributes,children));
		
	}

	public function head(attributes:Dynamic=null,children:Dynamic->Void=null){
		return add(new HtmlTag().init("head",attributes,children));
	}

	public function h1(attributes:Dynamic=null,children:Dynamic->Void=null){
		return add(new HtmlTag().init("h1",attributes,children));
	}
	public function div(attributes:Dynamic=null,children:Dynamic->Void=null){
		return add(new HtmlTag().init("div",attributes,children));
	}
	public function form(attributes:Dynamic=null,children:Dynamic->Void=null){
		return add(new HtmlTag().init("form",attributes,children));
	}
	public function input(attributes:Dynamic=null,children:Dynamic->Void=null){
		return add(new HtmlTag().init("input",attributes,children));
	}
	public function label(attributes:Dynamic=null,children:Dynamic->Void=null){
		return add(new HtmlTag().init("label",attributes,children));
	}
	public function h2(attributes:Dynamic=null,children:Dynamic->Void=null){
		return add(new HtmlTag().init("h2",attributes,children));
	}
	public function h3(attributes:Dynamic=null,children:Dynamic->Void=null){
		return add(new HtmlTag().init("h3",attributes,children));
	}

}
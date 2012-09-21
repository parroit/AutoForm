package autoform.domrenderer;


class Tag implements ITag{
	private var node:Xml;
	public var parentNode(default,setParentNode):Xml;

	public function setParentNode(value:Xml):Xml{
		parentNode=value;
		parentNode.addChild(node);
		return value;
	}

	// public function add(tagName:String,attributes:Dynamic,children:TagType->Array<Tag>){
	// 	var html =  new Tag(tagName,attributes,children);
	// 	html.parentNode=node;
	// 	return html;
	// }

	public function add<TTag:ITag>(html:TTag):TTag{
		html.parentNode=node;
		
		return html;
	}
	public function init (tagName:String,attributes:Dynamic, children:Dynamic->Void) {
		trace(children);
		node=Xml.createElement(tagName);	
		for (name in Reflect.fields(attributes)){
			node.set(name,Reflect.field(attributes, name));	
		}
		if (children!=null)
			children(this);
		return this;
       	
	}
	public function toString():String{
		
       	return node.toString();
	} 
}


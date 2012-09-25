package autoform.renderer;


class Tag implements ITag{
	public var node:Xml;
	public var parentNode(default,setParentNode):Xml;

	public function setParentNode(value:Xml):Xml{
		if (parentNode!=null)
			parentNode.removeChild(node);
		parentNode=value;
		parentNode.addChild(node);
		return value;
	}

	public function text(value:String){
		node.addChild(Xml.createPCData(value));
	}
	public function content(value:String){
		node.addChild(Xml.createPCData(value));
	}

	public function add<TTag:ITag>(html:TTag):TTag{
		html.parentNode=node;
		
		return html;
	}

	public function init (tagName:String,attributes:Dynamic, children:Dynamic->Void) {
//		////trace(children);
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


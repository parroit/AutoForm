package autoform.domrenderer;
interface ITag{
	public var parentNode(default,setParentNode):Xml;

	public function setParentNode(value:Xml):Xml;

}
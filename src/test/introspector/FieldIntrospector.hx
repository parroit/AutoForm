package introspector;

class FieldIntrospector<ObjectType,FieldType> = {
	public var name(default,null) : String;
	public var type(default,null) : Class<ObjectType>;
	public var isPublic(default,null) : Bool;
	public var meta(default,null) : Dynamic;
	public var doc(default,null) : Null<String>;

	public dynamic set(instance:Clazz,value:FieldType){}
	public dynamic get(instance:Clazz):FieldType{return null;}


	public function new(name,type,isPublic,meta,doc,set,get){
		this.name=name;
		this.type=type;
		this.isPublic=isPublic;
		this.meta=meta;
		this.doc=doc;
		this.set=set;
		this.get=get;
	}
}
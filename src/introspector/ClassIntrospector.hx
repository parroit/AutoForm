package introspector;

class ClassIntrospector<ObjectType>  {
	public var name(default,null) : String;
	public var clazz(default,null) : Class<ObjectType>;
	public var meta(default,null) : Dynamic;
	public var doc(default,null) : Null<String>;
	public var fields(default,null) : Hash<FieldIntrospector<ObjectType,Dynamic>>;

	public function new(name,clazz,meta,doc){
		this.name=name;
		this.clazz=clazz;
		this.meta=meta;
		this.doc=doc;
		this.fields=new Hash<FieldIntrospector<ObjectType,Dynamic>>(); 	
	}
}
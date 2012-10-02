package introspector;

class ClassIntrospector<ObjectType,FieldType> = {
	public var name(default,null) : String;
	public var clazz(default,null) : Class<ObjectType>;
	public var meta(default,null) : Dynamic;
	public var doc(default,null) : Null<String>;
	public var fields(default,null) : Hash<FieldIntrospector>;

	
}
package autoform.renderer;

class BaseRenderingEngine{
	
	private var register:Hash<String->FieldRenderer>;
	private var document:HtmlTag;
	private var renderer:AutoForm -> FormRenderer;
		
	public function new(document:HtmlTag){
		 this.document=document;
		 this.register=new Hash<String->FieldRenderer>();
		 

	}
	public function with(form :AutoForm):FormRenderer{
		var rndr=renderer(form);

		if (form.meta==null) 
			return rndr; 
		for (fieldName in Reflect.fields(form.meta.fields)){
			if (fieldName!="manager"){
				var field=Reflect.getProperty(form.meta.fields,fieldName);
				
				
				if (field.widget==null){
					var buildWidget=register.get("text");
					trace("widget not found for "+fieldName);
					rndr.addField(buildWidget(field.name));	
				} else {
					var buildWidget=register.get(field.widget);
					trace("buildWidget is "+Std.string(buildWidget));
					rndr.addField(buildWidget(field.name));	
				}
				
			}
		}
		return rndr; 
		
	}
}


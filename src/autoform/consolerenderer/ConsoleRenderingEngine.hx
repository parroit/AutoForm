package autoform.consolerenderer;
class ConsoleRenderingEngine{
	private var register:Hash<String->FieldRenderer>;
	public function new(){
		 register=new Hash<String->FieldRenderer>();
		 register.set("text",function (fieldName) {return new ConsoleTextFieldRenderer(fieldName);});
		 register.set("password",function (fieldName) {return new ConsolePasswordFieldRenderer(fieldName);});
	}
	public function with(form :AutoForm):FormRenderer{
		var renderer=new ConsoleFormRenderer(form);
		for (fieldName in Reflect.fields(form.meta.fields)){
			var field=Reflect.getProperty(form.meta.fields,fieldName);
			var buildWidget=register.get(field.widget);
			renderer.fields.push(buildWidget(field.name));
		}
		return renderer;
	}
}

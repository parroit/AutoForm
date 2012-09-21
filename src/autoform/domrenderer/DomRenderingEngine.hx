package autoform.domrenderer;
import autoform.FieldRenderer;

class DomRenderingEngine{
	private var register:Hash<String->FieldRenderer>;
	public function new(document:HtmlTag){
		 register=new Hash<String->FieldRenderer>();
		 register.set("text",function (fieldName) {return new DomTextFieldRenderer(fieldName,document);});
		 register.set("password",function (fieldName) {return new DomPasswordFieldRenderer(fieldName,document);});
	}
	public function with(form :AutoForm):FormRenderer{
		var renderer=new DomFormRenderer(form);
		for (fieldName in Reflect.fields(form.meta.fields)){
			var field=Reflect.getProperty(form.meta.fields,fieldName);
			var buildWidget=register.get(field.widget);
			renderer.fields.push(buildWidget(field.name));
		}
		return renderer;
	}
}
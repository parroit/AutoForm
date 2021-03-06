package autoform.domrenderer;
import thx.util.Result;
import autoform.renderer.HtmlTag;

class DomFormRenderer implements FormRenderer {
	private var autoForm:AutoForm;
	private var document:HtmlTag;
	private var action:String;
	
	public function new(autoForm:AutoForm,document:HtmlTag,action:String=null){
		this.document=document;
		this.action=action;
		this.autoForm=autoForm;
		this.fields=[];
		
	}
	public function render(){
		document.form({name:autoForm.meta.name,action:action,method:"POST"},function (it){
			trace("1"+Std.string(it));
			for (field in fields){
				untyped{field.parent=it;}
				field.render(Reflect.getProperty(autoForm.data.fields,field.fieldName));
			}
			trace("2");
			//it.input({type:"submit","class":"form-submit",value:"Save" });		
			trace("3");
			switch (autoForm.data.error) {
				case Result.Ok:
				case Result.Failure(error):	
					it.div({
						id:"error-"+autoForm.meta.name,
						"class":"validation-error"
					}).text(error) ;
			}	
			trace("4");
			
			
		});
	}
	public function addField(field:FieldRenderer){
		fields.push(field);
	}
	private var fields:Array<FieldRenderer>;
	
			
}
package autoform.bootstraprenderer;
import thx.util.Result;
import autoform.renderer.HtmlTag;

class BootstrapFormRenderer implements FormRenderer {
	private var autoForm:AutoForm;
	private var document:HtmlTag;
	private var action:String;
	private var defaultSubmit:String;
	public function new(autoForm:AutoForm,document:HtmlTag,action:String=null,defaultSubmit:String){
		this.document=document;
		this.autoForm=autoForm;
		this.fields=[];
		this.action=action;
		this.defaultSubmit=defaultSubmit;
		
	}
	public function render(){
		document.form({name:autoForm.meta.name,action:action,method:"POST","class":"form-horizontal"},function (it){
			it.fieldset({},function(it:HtmlTag) {
				for (field in fields){
					untyped{field.parent=it;}
					field.render(Reflect.getProperty(autoForm.data.fields,field.fieldName));
				}
				switch (autoForm.data.error) {
					case Result.Ok:
					case Result.Failure(error):	
						it.div({
							id:"error-"+autoForm.meta.name,
							"class":"alert alert-error"
						}).text(error.join("<br/>")) ;
				}
				if (defaultSubmit!=null){
					it.content(defaultSubmit);	
				}
					
			});
			
				

			
			
		});
	}
	public function addField(field:FieldRenderer){
		fields.push(field);
	}
	private var fields:Array<FieldRenderer>;
	
			
}
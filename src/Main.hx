import autoform.AutoForm;
import autoform.domrenderer.DomRenderingEngine;
import autoform.domrenderer.HtmlDocument;
using autoform.domrenderer.HtmlDocument;
using autoform.Reflection;
import thx.validation.StringLengthValidator;

class Main {
	public static function main() {
       Example.view(Example.controller());
       
   //     document.html({language:"it"},function (it:HtmlTag) { 
			// it.head({classe:"bootstrap"},null);			
   //     		it.body({classe:"bootstrap"},function (it:HtmlTag) { 
   //     			it.h1({},null);		
   //     		});			
   //     	});
       
       
    }

}

class User  implements haxe.rtti.Infos {
	
	public function new(){}
	@autoform({
		title: "User name",
		description: "We promise not to send you spam!  We use your email only to help you restore your password."
	})
	public var name="type your <name>";
	
	@autoform({
		widget:"passowrd",
		title: "Password",
		description: "We promise not to send you spam!  We use your email only to help you restore your password."
	})
	public var password="type your password";
}

class Example{
	public static function controller():AutoForm{
		var form=new AutoForm();
		var nameAttr={
					name:"name",
					widget:"text",
					caption:"User Name",
					validation: [ new StringLengthValidator(0,10) ],
					tooltip:"",
				};
		var passwordAttr={
					name:"password",
					widget:"password",
					caption:"User Password",
					validation: [ new StringLengthValidator(0,10) ],
					tooltip:"",
				};
		
		form.meta={
			name:"user",
			caption:"Edit user",
			validation: [],
			tooltip:"",
			
			fields : {
				name:nameAttr,
				password:passwordAttr
			},
					
		};

		var newUser=new User();
		var clazz=Type.getClass(newUser);
		
		form.of(clazz).fill(newUser);	

		


		return form;
	} 
	
	public static function view(form:AutoForm){
		var document=HtmlDocument.create();
		new DomRenderingEngine(document.html()).with(form).render();
		trace(document);
	}



}
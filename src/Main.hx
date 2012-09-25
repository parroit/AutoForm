import autoform.AutoForm;
import autoform.domrenderer.DomRenderingEngine;
import autoform.renderer.HtmlDocument;
using autoform.renderer.HtmlDocument;
using autoform.Reflection;
import thx.validation.StringLengthValidator;
import sys.db.Types.SString;

class Main {
	public static function main() {
   
       Example.view(Example.controller());
   
       
    }

}

@:id(name)
@:table("users")
class User extends sys.db.Object , implements haxe.rtti.Infos {
    public function new (){super();}

    @autoform({
		title: "User name",
		description: "We promise not to send you spam!  We use your email only to help you restore your password."
	})
    public var name:SString<50>;
    
    @autoform({
		widget:"password",
		title: "Password",
		description: "We promise not to send you spam!  We use your email only to help you restore your password."
	})
	public var password:SString<50>;

}


class Example{
	public static function controller():AutoForm{
		
		var newUser=new User();
		var clazz=Type.getClass(newUser);
		
		var form=new AutoForm();

		form.of(clazz).fill(newUser);	

		


		return form;
	} 
	
	public static function view(form:AutoForm){
		var document=HtmlDocument.create();
		new DomRenderingEngine(document.html(),"").with(form).render();
//		trace(document);
	}



}
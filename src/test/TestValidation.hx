package test;
import thx.validation.StringLengthValidator;
import test.User;
import autoform.AutoForm;
using autoform.Reflection;

import utest.Assert;
import utest.Runner;
import utest.ui.Report;




class TestValidation{
	 public static function main() {
        var runner = new Runner();
        runner.addCase(new TestValidation());
        Report.create(runner);
        runner.run();
    }
        
    public function new(){}

	public function testValidatorsCreation() {
		var user=new User();
		
		User.introspector.username.set(user,"Andrea Parodi");

		Assert.equals(user.username,"Andrea Parodi");

	}

	// public function testValidatorsCreation() {
	// 	var form:AutoForm=new AutoForm().of(Type.getClass(new User()));
	// 	// var editForm = form.of(Type.getClass(new User()));
	// 	// Sys.println(editForm.meta.fields.username);
		
	// 	Sys.println("valid--->"+User.fields[0].validation.validate("99"));

	// 	Assert.equals(form.meta.fields.password.validation,[new StringLengthValidator(1, 100)]);

	// }



}


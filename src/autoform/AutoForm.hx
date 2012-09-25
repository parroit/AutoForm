package autoform;
import autoform.FormRenderer;

import thx.validation.IValidator;
import thx.validation.StringLengthValidator;
import thx.util.Result;
import autoform.domrenderer.DomRenderingEngine;


class AutoForm {
	public function new(){
		data={
			error:Result.Ok,
			fields:{}
		};
	}
	public var meta:ModelMetadata;
	public var data:ModelData;

	public function toString(){
		return Std.string(data);
	}

}














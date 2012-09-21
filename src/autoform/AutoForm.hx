package autoform;
import autoform.domrenderer.FormRenderer;

import thx.validation.IValidator;
import thx.validation.StringLengthValidator;
import thx.util.Result;
import autoform.domrenderer.DomRenderingEngine;
import autoform.domrenderer.HtmlDocument;
import autoform.domrenderer.Tag;
using autoform.domrenderer.HtmlDocument;


class AutoForm {
	public function new(){
		data={
			error:null,
			fields:{}
		};
	}
	public var meta:ModelMetadata;
	public var data:ModelData;

	public function toString(){
		return Std.string(data);
	}

}














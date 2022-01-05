package com.wellness.intro;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IntroController {
	
	@RequestMapping(value = "intro_wellness")
	public String intro_wellness() {
		return "view/intro_wellness";
	}
	@RequestMapping(value = "intro_platform")
	public String intro_platform() {
		return "view/intro_platform";
	}
	
}

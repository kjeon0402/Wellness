package com.wellness.sms;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wellness.common.ScriptUtils;
import com.wellness.member.FindIdVO;
import com.wellness.member.FindPwVO;
import com.wellness.member.MemberService;
import com.wellness.member.MemberVO;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
public class SmsCtr {
	
	@Autowired MemberService ms;
	SmsVO sms = new SmsVO();
	
	@RequestMapping(value = "information_check_id_phone", method = RequestMethod.POST)
	public @ResponseBody String information_check_id_phone(HttpServletRequest request, ModelMap modelmap, FindIdVO vo) {
		
		MemberVO mvo = new MemberVO();
		mvo = ms.findIdByPhone(vo);
		
		int check = 1;
		
		if(mvo != null) {
			check = 0;
		}
		
		return String.valueOf(check);
	}
	
	@RequestMapping(value = "information_check_pw_phone", method = RequestMethod.POST)
	public @ResponseBody String information_check_pw_phone(HttpServletRequest request, ModelMap modelmap, FindPwVO vo) {
		
		System.out.println("member_userid : " + vo.getMember_userid());
		System.out.println("member_phone : " + vo.getMember_phone());

		MemberVO mvo = new MemberVO();
		mvo = ms.findPwByPhone(vo);
		System.out.println("mvo : " + mvo);
		
		int check = 1;
		if(mvo != null) {
			check = 0;
		} 
		return String.valueOf(check);
	}
	
	@RequestMapping(value = "sendSMS", method = RequestMethod.GET)
	public String getsms(HttpServletRequest request, ModelMap modelmap, HttpServletResponse response) throws IOException {
		
		String member_phone = request.getParameter("member_phone");
		System.out.println("member_phone : " + member_phone);
		if(member_phone == null) {
			ScriptUtils.alertAndMovePage(response, "잘못된 접근입니다.", "find_id");
		}
		
		Send_SMS(member_phone);
		modelmap.addAttribute("member_phone", member_phone);
		return "view/smsCheck";
	}
	
	@RequestMapping(value = "sendSMS", method = RequestMethod.POST)
	public @ResponseBody String sendsms(HttpServletRequest request, ModelMap modelmap) {
		int certification = Integer.parseInt(request.getParameter("certification"));
		int checking = sms.getRandom_Number();
		int check = 1;
		if(certification == checking) {
			check = 0;
		}
		modelmap.addAttribute("check", check);
		
		return String.valueOf(check);
	}
	
	private void Send_SMS(String member_phone) {
		String api_key = "NCS8LBNDMHL4MAUM";
		String api_secret = "PLP60N5DDKZKMUZLZP6VKXYL5HU9AC0Y";
		
		Message coolsms = new Message(api_key, api_secret);
		HashMap<String, String> params = new HashMap<String, String>();

		int random = (int) (Math.random() * 899999) + 100000;
		
		sms.setRandom_Number(random);
		
		params.put("to", member_phone);
		params.put("from", "07087226321");
		params.put("type", "SMS");
		params.put("text", "안녕하세요. 인증번호는 " + random + "입니다.");
		params.put("app_version", "test app 1.2");

		try {
			System.err.println("try 진입");
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString());
		} catch (CoolsmsException e) {
			System.err.println("catch 진입");
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
	}
}

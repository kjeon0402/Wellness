package com.wellness.certification;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wellness.member.FindIdVO;
import com.wellness.member.FindPwVO;
import com.wellness.member.MemberService;
import com.wellness.member.MemberVO;

@Controller
public class Email_Certification {
	@Autowired private JavaMailSender mailSender;
	
	@Autowired MemberService service;
	
	EmailVO email = new EmailVO();

//	@RequestMapping(value = "member_id_email_certification", method = RequestMethod.GET)
//	public String emailCertify(ModelMap modelMap, HttpSession session,
//			@RequestParam(value = "email_name", required = false) String name,
//			@RequestParam(value = "certification_type", required = false) String email) throws Exception {
//		int certification = Send_Email(email);
//		session.setMaxInactiveInterval(60 * 10);
//		session.setAttribute("name", name);
//		session.setAttribute("email", email);
//		session.setAttribute("certification", certification);
//		session.setAttribute("certification_category", "email");
//		return "view/certification/member_id_certification";
//	}
//
//	@RequestMapping(value = "member_id_email_certification", method = RequestMethod.POST)
//	public String emailCertify(ModelMap modelMap, HttpSession session,
//			@RequestParam(value = "num", required = false) int num) throws Exception {
//		
//		int certification = (Integer) session.getAttribute("certification");
//		int check = 1;
//		if(certification == num) {
//			check = 0;
//		}
//		
//		modelMap.addAttribute("check", check);
//		return "view/certification/member_id_certification";
//	}
//	
//	@RequestMapping(value = "member_id_result")
//	public String email_result(ModelMap modelMap, HttpSession session) throws Exception {
//		
//		String name = (String) session.getAttribute("name");
//		String email = (String) session.getAttribute("email");
//		String tel = (String) session.getAttribute("tel");
//		String certification_category = (String) session.getAttribute("certification_category");
//		
//		if(certification_category.equals("email")) {
//			Member_findVO vo = new Member_findVO(name, email);
//			List<Member_findVO> member_list = service.getMember_id(vo);
//			modelMap.addAttribute("member_list", member_list);
//		} else if(certification_category.equals("tel")) {
//			Member_findVO vo = new Member_findVO(name, tel);
//			List<Member_findVO> member_list = service.getMember_id_2(vo);
//			modelMap.addAttribute("member_list", member_list);
//		}
//		
//		return "view/certification/member_result";
//	}
	
	@RequestMapping(value = "information_check_id_email", method = RequestMethod.POST)
	public @ResponseBody String information_check_id_email(HttpServletRequest request, ModelMap modelmap, FindIdVO vo) {
		MemberVO mvo = new MemberVO();
		mvo = service.findIdByEmail(vo);
		
		int check = 1;
		if(mvo != null) {
			check = 0;
		}
		return String.valueOf(check);
	}
	
	@RequestMapping(value = "information_check_pw_email", method = RequestMethod.POST)
	public @ResponseBody String information_check_pw_email(HttpServletRequest request, ModelMap modelmap, FindPwVO vo) {
		MemberVO mvo = new MemberVO();
		mvo = service.findIdByEmailpw(vo);
		
		int check = 1;
		if(mvo != null) {
			check = 0;
		}
		return String.valueOf(check);
	}
	
	@RequestMapping(value = "sendEmail", method = RequestMethod.GET)
	public String getemail(HttpServletRequest request, ModelMap modelmap, HttpSession session) throws Exception {
		String member_email = request.getParameter("member_email");
		
		int certification = Send_Email(member_email);
		
		session.setAttribute("certification", certification);
		
		modelmap.addAttribute("member_email", member_email);
		
		int check = 0;
		
		if(certification !=0 ) {
			check = 1;
		}
		
		return "view/emailCheck";
	}
	
	@RequestMapping(value = "sendEmail", method = RequestMethod.POST)
	public @ResponseBody String sendemail(HttpServletRequest request, ModelMap modelmap, HttpSession session) {
		
		int num = Integer.parseInt(request.getParameter("certification"));
		
		int certification = (Integer) session.getAttribute("certification");
		
		int check = 1;
		if(certification == num) {
			check = 0;
		}
		modelmap.addAttribute("check", check);
		
		return String.valueOf(check);
	}
	
	public int Send_Email(String email) throws Exception {
		
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		int certification = (int) (Math.random() * 899999) + 100000;
		
		messageHelper.setFrom("k47099965@gmail.com"); // 보내는사람 생략하거나 하면 정상작동을 안함
		messageHelper.setTo(email); // 받는사람 이메일
		messageHelper.setSubject("WELLNESS 인증번호"); // 메일제목은 생략이 가능하다
		messageHelper.setText("안녕하세요. WELLNESS 인증번호는 : " + certification + " 입니다."); // 메일 내용
		
		mailSender.send(message);
		
		return certification;
	}
}

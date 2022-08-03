package kr.board.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.board.entity.Member;
import kr.board.mapper.MemberMapper;

@Controller
public class MemberController {

	@Autowired
	MemberMapper mapper;
	@RequestMapping(value="/memJoin.do")
	public String memJoin() {
		
		return "member/join";
	}
	
	@RequestMapping(value="/memRegisterCheck.do")
	public @ResponseBody int memRegisterCheck(String memID) {
		
		Member m = mapper.registerCheck(memID);
		
		if (m != null || memID.equals("")) {
			return 0; //이미 존재하는 회원
		}
		return 1;
	}
	
	@RequestMapping(value="/memRegister.do")
	public String memRegister(Member m, RedirectAttributes rttr,HttpSession session,
					String memPassword1, String memPassword2) {
		if(m.getMemID()==null || m.getMemID().equals("") || 
		memPassword1 == null || memPassword1.equals("")||
		memPassword2 == null || memPassword2.equals("")||
		m.getMemPassword()==null || m.getMemPassword().equals("") || 	
		m.getMemName()==null || m.getMemName().equals("") || 
		m.getMemAge()==0 ||
		m.getMemGender()==null || m.getMemGender().equals("") || 
		m.getMemEmail()==null || m.getMemEmail().equals("")) {
			
			rttr.addFlashAttribute("msgType","누락 메세지");
			rttr.addFlashAttribute("msg","모든 내용을 입력해주세요.");
			return "redirect:/memJoin.do";
		}
		if (!memPassword1.equals(memPassword2)) {
			rttr.addFlashAttribute("msgType","실패 메세지");
			rttr.addFlashAttribute("msg","비밀번호가 다릅니다.");
			return "redirect:/memJoin.do";
		}
		
		m.setMemProfile("");
		
		// 회원을 테이블에 저장
		int result = mapper.register(m);
		if (result == 1) {
			rttr.addFlashAttribute("msgType","성공 메세지");
			rttr.addFlashAttribute("msg","회원가입에 성공했습니다.");
			session.setAttribute("mvo",m );
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msgType","실패 메세지");
			rttr.addFlashAttribute("msg","이미 존재하는 회원입니다.");
			return "redirect:/memJoin.do";
		}
	}
	
	@RequestMapping(value="/memLogout.do")
	public String memLogout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value="memLoginForm.do")
	public String memLoginForm() {
		
		return "member/memLoginForm";
	}
	
	@RequestMapping(value="memLogin.do")
	public String memLogin(Member m, RedirectAttributes rttr, HttpSession session) {
		
		if(m.getMemID()==null || m.getMemID().equals("") || 
		m.getMemPassword()==null || m.getMemPassword().equals(""))  {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "모든 내용을 입력해주세요.");
			return "redirect:/memLoginForm.do";
		}
		
		Member mvo = mapper.memLogin(m);
		if(mvo!=null) {
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "로그인 하였습니다.");
			session.setAttribute("mvo", mvo);
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "로그인에 실패 하였습니다.");
			return "redirect:/memLoginForm.do";
		}
		
	}
	
	@RequestMapping(value="memUpdateForm.do")
	public String memUpdateForm() {
		
		return "member/memUpdateForm";
	}
	
	@RequestMapping(value="memUpdate.do")
	public String memUpdate(Member m, RedirectAttributes rttr, HttpSession session,
					String memPassword1, String memPassword2) {
		
		if(m.getMemID()==null || m.getMemID().equals("") || 
			memPassword1 == null || memPassword1.equals("")||
			memPassword2 == null || memPassword2.equals("")||
			m.getMemPassword()==null || m.getMemPassword().equals("") || 	
			m.getMemName()==null || m.getMemName().equals("") || 
			m.getMemAge()==0 ||
			m.getMemGender()==null || m.getMemGender().equals("") || 
			m.getMemEmail()==null || m.getMemEmail().equals("")) {
				
				rttr.addFlashAttribute("msgType","누락 메세지");
				rttr.addFlashAttribute("msg","모든 내용을 입력해주세요.");
				return "redirect:/memUpdateForm.do";
			}
		if (!memPassword1.equals(memPassword2)) {
			rttr.addFlashAttribute("msgType","실패 메세지");
			rttr.addFlashAttribute("msg","비밀번호가 다릅니다.");
			return "redirect:/memUpdateForm.do";
		}
		
		m.setMemProfile("");
		
		// 회원을 테이블에 저장
		int result = mapper.memUpdate(m);
		if (result == 1) {
			rttr.addFlashAttribute("msgType","성공 메세지");
			rttr.addFlashAttribute("msg","회원수정에 성공했습니다.");
			session.setAttribute("mvo",m );
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msgType","실패 메세지");
			rttr.addFlashAttribute("msg","회원수정에 실패했습니다.");
			return "redirect:/memUpdateForm.do";
		}
	}
	
	@RequestMapping(value="/memImageForm.do")
	public String memImageForm() {
		return "/member/memImageForm";
	}
	
	@RequestMapping(value="memImageUpdate.do")
	public String memImageUpdate(HttpServletRequest request,RedirectAttributes rttr, HttpSession session) {
		//파일 업로드 api(cos.jar, 3가지)
		MultipartRequest multi= null;
		int fileMaxSize = 10*1024*1024; //10mb
		String savePath = request.getServletContext().getRealPath("resources/upload");		
		try {				
			//이미지 업로드 성공							     	//DefaultFileRenamePolicy -> 중복 이름에 1_1.png로 바꿈
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy()); 
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "파일의 크기는 10MB를 넘을 수 없습니다.");
			return "redirect:/memImageForm.do";
		}
		// 데이터베이스에 회원 이미지 업데이트
		String memID = multi.getParameter("memID");
		String newProfile = "";
		File file = multi.getFile("memProfile");
		if (file != null) { //업로드가 된 상태(png, jpg, gif)
			//이미지 파일 여부를 체크 -> 이미지 파일이 아니면 삭제 
			String ext = file.getName().substring(file.getName().lastIndexOf(".")+1); // 확장자
			ext = ext.toUpperCase();
			if (ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG")) {  //PNG, GIF, JPG
				// 새업로드 파일(new), 존재하는 파일(old)
				String oldProfile = mapper.getMember(memID).getMemProfile();
				File oldFile = new File(savePath+ "/" + oldProfile);
				if (oldFile.exists()) {
					oldFile.delete();
				}
				newProfile = file.getName();
			}else {
				if (file.exists()) {
					file.delete();
				}
				rttr.addFlashAttribute("msgType", "실패 메세지");
				rttr.addFlashAttribute("msg", "이미지 파일만 등록할 수 있습니다.");
				return "redirect:/memImageForm.do";
			}
		}
		//새로운 이미지 db에 저장
		Member mvo = new Member();
		mvo.setMemID(memID);
		mvo.setMemProfile(newProfile);
		mapper.memProfileUpdate(mvo);
		Member m = mapper.getMember(memID);	//업데이트 후 select
		
		//세션을 새롭게 생성
		session.setAttribute("mvo", m);
		rttr.addFlashAttribute("msgType", "성공 메세지");
		rttr.addFlashAttribute("msg", "이미지 변경에 성공하였습니다.");
		
		return "redirect:/";
	}
	
}

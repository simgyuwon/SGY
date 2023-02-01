package com.khj.exam.demo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.khj.exam.demo.service.GenFileService;
import com.khj.exam.demo.service.MemberService;
import com.khj.exam.demo.utill.Ut;
import com.khj.exam.demo.vo.Member;
import com.khj.exam.demo.vo.Rq;

@Controller
public class AdmMemberController {
	private MemberService memberService;
	private GenFileService genFileService;
	private Rq rq;

	public AdmMemberController(MemberService memberService, GenFileService genFileService, Rq rq) {
		this.memberService = memberService;
		this.genFileService = genFileService;
		this.rq = rq;
	}

	@RequestMapping("/adm/member/list")
	public String showList(Model model, @RequestParam(defaultValue = "0") int authLevel,
			@RequestParam(defaultValue = "loginId,name,nickname") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword, @RequestParam(defaultValue = "1") int page) {
		int membersCount = memberService.getMembersCount(authLevel, searchKeywordTypeCode, searchKeyword);

		int itemsCountInAPage = 10;
		int pagesCount = (int) Math.ceil((double) membersCount / itemsCountInAPage);
		List<Member> members = memberService.getForPrintMembers(authLevel, searchKeyword, searchKeywordTypeCode, itemsCountInAPage,
				page);

		model.addAttribute("authLevel",authLevel);
		model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
		model.addAttribute("searchKeyword", searchKeyword);
		
		
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("page", page);
		
		model.addAttribute("membersCount", membersCount);
		model.addAttribute("members", members);

		return "adm/member/list";
	}
	
	@RequestMapping("/adm/member/doDeleteMembers")
	@ResponseBody
	public String doDelete(@RequestParam(defaultValue = "") String ids, @RequestParam(defaultValue = "/adm/member/list") String replaceUri) {
		List<Integer> memberIds = new ArrayList<>();
		
		for ( String idStr : ids.split(",")) {
			memberIds.add(Integer.parseInt(idStr));
		}
		
		memberService.deleteMembers(memberIds);

		return rq.jsReplace("해당 회원들이 삭제되었습니다.", replaceUri);
	}
}

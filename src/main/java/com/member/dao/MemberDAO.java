package com.member.dao;

import java.util.ArrayList;

import com.member.dto.MemberDTO;

public interface MemberDAO {
	
	//�߰�
	public void MemberInsert(MemberDTO member);
	//��ü����
	public ArrayList<MemberDTO>memberList();
	//����
	public void memberUpade(MemberDTO member);
	//����
	public void memberDelete(String userid);
	//�󼼺���
	public MemberDTO fineById(String userid);
	//���̵��ߺ�üũ
	public String idCheck(String userid);
	//�α���üũ
	public int loginCheck(String userid,String pwd);
	//ȸ����
	public int getCount();
}

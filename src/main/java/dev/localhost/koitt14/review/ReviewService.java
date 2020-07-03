package dev.localhost.koitt14.review;

import java.io.File;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dev.localhost.koitt14.product.ProductMapper;
import dev.localhost.koitt14.product.ProductService;



@SuppressWarnings("all")
@Service
public class ReviewService {
	
    @Autowired
    private ReviewMapper reviewMapper;
    @Autowired
    private ProductMapper productMapper;
  	
    //reviewList(일반리뷰 얻어오기)
    public void reviewList(Model model, int seqKey, int reviewPage) {
		  
		int limit=10;//1페이지 = 게시글10개
		
		//전체게시글 카운트
		int reviewListCount = reviewMapper.reviewListCount(seqKey);
		//페이지수 계산(메소드 재활용)
		int reviewStartRow=ProductService.pageCal(reviewListCount, limit, reviewPage, model);
		
		//화면에 뿌려지는 변수
		model.addAttribute("productKey", seqKey);
	    model.addAttribute("reviewList", reviewMapper.reviewList(seqKey,reviewStartRow));
    
   }//reviewList
   //---------------------------------------------------------------------------------------//
   //reviewListCount(리뷰갯수 얻어오기)
    public void reviewListCount(Model model, int seqKey) {
    	model.addAttribute("reviewListCount",reviewMapper.reviewListCount(seqKey));
    }//reviewListCount
   //---------------------------------------------------------------------------------------//
   //(gradeAvg)별점평균 얻어오기
    public void gradeAvg(Model model, int seqKey) {
    
    	model.addAttribute("gradeAvg", reviewMapper.gradeAvg(seqKey)); 
    	
    }//gradeAvg
   //---------------------------------------------------------------------------------------//
    //status(구매완료한 회원인지 여부확인-글작성버튼 누를시 작동)
    public void status(int seqKey, int productKey, HttpSession session, Model model) {
    	
    	if(productMapper.detail(productKey)!=null) {
    	int accountKey=(Integer)session.getAttribute("accountKey");
    	model.addAttribute("statusAll",reviewMapper.status(seqKey,accountKey));
    	}
    	else {
    		model.addAttribute("noProduct","y");
    	}
    	
    }//status
    //---------------------------------------------------------------------------------------//
    //reviewWrite(리뷰 글쓰기) 
    public void reviewWrite(HttpServletRequest request, Model model) {
    	
    	String path_ = request.getSession().getServletContext().getRealPath("");
    	String path = path_+"files/review";
		//파일사이즈 지정-업로드 파일용량 제한
		int size = 1024 * 1024 * 1; //총 1 메가 용량 제한
		try {
			MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
			int accountKey = Integer.parseInt(multi.getParameter("accountKey"));
			int productKey = Integer.parseInt(multi.getParameter("productKey"));
			int grade = Integer.parseInt(multi.getParameter("grade"));
			String content = multi.getParameter("content");
			
			Enumeration files = multi.getFileNames();
			
			String name = (String)files.nextElement();
			String imageFileName = multi.getFilesystemName(name);
			reviewMapper.reviewStatusChange(accountKey, productKey);
			model.addAttribute("reviewSuccess",reviewMapper.reviewWrite(accountKey,productKey,grade,content,imageFileName));
			
		}catch(Exception e) {
			e.printStackTrace();
		}
    	
    }//reviewWrite
    //---------------------------------------------------------------------------------------//
    //reviewModifyView(리뷰 수정 뷰)
    public void reviewModifyView(int seqKey, Model model) {
    	
    	model.addAttribute("reviewModifyView",reviewMapper.reviewModifyView(seqKey));
    	
    }//reviewModifyView
    //---------------------------------------------------------------------------------------//
    //reviewModify(리뷰 수정)
    public void reviewModify(HttpServletRequest request, Model model) {
    	
    	String path_ = request.getSession().getServletContext().getRealPath("");
    	String path = path_+"files/review";
		//파일사이즈 지정-업로드 파일용량 제한
		int size = 1024 * 1024 * 1; //총 1 메가 용량 제한
		try {
			MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
			int seqKey = Integer.parseInt(multi.getParameter("seqKey"));
			int grade = Integer.parseInt(multi.getParameter("grade"));
			String content = multi.getParameter("content");
			String oriFile = multi.getParameter("originFileName");
			
			Enumeration files = multi.getFileNames();
			
			String name = (String)files.nextElement();
			String imageFileName = multi.getFilesystemName(name);
			//들어온 파일이름이 없을경우 원래 파일 이름으로 대체
			if(imageFileName==null || imageFileName.equals("")) {
				imageFileName=oriFile;
			}
			//이미지 파일이 바뀐경우 전의파일 삭제
			if(!(imageFileName.equals(oriFile))) {
				File f = new File(path + "/" + oriFile);
				f.delete();
			}
			model.addAttribute("modifySuccess",reviewMapper.reviewModify(seqKey,grade,content,imageFileName));
			
		}catch(Exception e) {
			e.printStackTrace();
		}
    	
    }//reviewModify
    //---------------------------------------------------------------------------------------//
    //reviewDelete(리뷰삭제)
    public void reviewDelete(int seqKey, String imageFileName,HttpServletRequest request) {
    	
    	String path_ = request.getSession().getServletContext().getRealPath("");
    	String path = path_+"files/review";
    	
    	if(!(imageFileName.equals("n"))) {
    		File f = new File(path + "/" + imageFileName);
    		f.delete();
    	}
    	reviewMapper.reviewDelete(seqKey);
    	
    }//reviewDelete
    //=================================관리자 전용============================================//
    //reviewList(리뷰전체 얻어오기)
    public void reviewListAll(Model model, int reviewPage, String order, String search) {
		String sqlOrder="";
		//정렬값 분기
		switch(order) {
			case "name" :
				sqlOrder="ORDER BY p."+order+" ASC";
				int limit=10;//1페이지 = 게시글10개
				int reviewListCount = reviewMapper.reviewListSearchCount(search);
				//페이지수 계산(메소드 재활용)
				int reviewStartRow=ProductService.pageCal(reviewListCount, limit, reviewPage, model);
				
				
				//화면에 뿌려지는 변수
				model.addAttribute("allCount", reviewListCount);
			    model.addAttribute("reviewList", reviewMapper.reviewListAll(reviewStartRow,search,sqlOrder));
			    model.addAttribute("search",search);
			    model.addAttribute("order",order);
				return;
			case "category" :
				sqlOrder="ORDER BY p.category1 ASC, p.category2 DESC";
				break;
			case "created_date" :
				sqlOrder="ORDER BY u."+order+" DESC";
				break;
		}
		
		int limit=10;//1페이지 = 게시글10개
		int reviewListCount = reviewMapper.reviewListSearchCount(search);
		//페이지수 계산(메소드 재활용)
		int reviewStartRow=ProductService.pageCal(reviewListCount, limit, reviewPage, model);
		
		
		//화면에 뿌려지는 변수
		model.addAttribute("allCount", reviewListCount);
	    model.addAttribute("reviewList", reviewMapper.reviewListAll(reviewStartRow,search,sqlOrder));
	    model.addAttribute("search",search);
	    model.addAttribute("order",order);
    
   }//reviewList
   //---------------------------------------------------------------------------------------//
 
    
    

  
}

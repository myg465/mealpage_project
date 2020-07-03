package dev.localhost.koitt14.product;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@SuppressWarnings("all")
@Service
public class ProductService {
  @Autowired
  private ProductMapper productMapper;
  
  //productList(상품리스트 얻기)
  public void productList(String category1, String category2, int page, Model model) {
		  
	int limit=12;//1페이지 = 게시글12개
	//전체게시글 카운트
	int listCount = productMapper.listCount(category1,category2);
	
	int startRow = pageCal(listCount, limit, page, model);
	ArrayList<String> list= productMapper.getBanner(category1);
	//화면에 뿌려지는 변수
    model.addAttribute("productList", productMapper.productList(category1, category2, startRow, limit));
    model.addAttribute("categoryList", productMapper.categoryList(category1));
    model.addAttribute("banner",productMapper.getBanner(category1));
    model.addAttribute("category1",category1);
    model.addAttribute("category2",category2);
    
  }//productList
  //---------------------------------------------------------------------------------------//
  //*getWishList(위시리스트 얻기 (다른객체로 옮겨질수 있음))
  public void getWishList(HttpSession session,Model model) {
	  
	  int accountKey=0;
	  //세션의 이름 정보를 불러옴
	  Enumeration sessions = session.getAttributeNames();
	  while(sessions.hasMoreElements()) {
		  //세션에 accountKey가 있으면 accountKey변수에 세션의 값을 아니면 0을 넣음
	      if(sessions.nextElement().toString().contains("accountKey")) {
	    	  accountKey=(int)session.getAttribute("accountKey");
	      }
	      else {
	    	  accountKey=0;
	      }
	  }
	  
	  model.addAttribute("wishList", productMapper.getWishList(accountKey));
	  
  }//getWishList
  //---------------------------------------------------------------------------------------//
  //detail(상품 상세정보)
  public void detail(Model model, int seqKey) {
	  
	model.addAttribute("productDetail",productMapper.detail(seqKey));  
	
  }//detail
  //---------------------------------------------------------------------------------------//
  //search(상품검색)
  public void search(String productSearch, String searchOrder, int page,Model model) {

    //검색값 분기
    String orderSql="";
    
    switch(searchOrder) {
    
    case "hot" :
    	int limit=12;//1페이지 = 게시글12개
    	//전체게시글 카운트
    	int listCount = productMapper.searchListCount(productSearch);
    	
    	int startRow = pageCal(listCount, limit, page, model);
    	//화면에 뿌려지는 변수
    	model.addAttribute("searchListCount",listCount);
        model.addAttribute("searchResult",productMapper.productHotSearch(productSearch, startRow));
        model.addAttribute("productSearch",productSearch);
        model.addAttribute("searchOrder",searchOrder);
        return;
    
    case "new" : 
    	orderSql="ORDER BY seq_key DESC";
    	break;
    
    case "priceHigh" :
    	orderSql="ORDER BY price DESC";
    	break;
    
    case "priceLow" :
    	orderSql="ORDER BY price ASC";
    
    }
    
    int limit=12;//1페이지 = 게시글12개
	//전체게시글 카운트
	int listCount = productMapper.searchListCount(productSearch);
	
	int startRow = pageCal(listCount, limit, page, model);
	
	//화면에 뿌려지는 변수
	model.addAttribute("searchListCount",listCount);
    model.addAttribute("searchResult",productMapper.productSearch(productSearch, orderSql, startRow));
    model.addAttribute("productSearch",productSearch);
    model.addAttribute("searchOrder",searchOrder);
	  
  }//search
  //---------------------------------------------------------------------------------------//
  //relationProduct(관련상품 얻기)
  public void relationProduct(String category1, String category2, int page, Model model) {
	  
    int limit = 5;
    int listCount = productMapper.listCount(category1, category2);
    int startRow = pageCal(listCount, limit, page, model);
    //화면에 뿌려지는 변수
    model.addAttribute("relationProduct",productMapper.productList(category1, category2, startRow, limit));
	  
  }//relationProduct
  //---------------------------------------------------------------------------------------//
  //pageCal(페이지값 얻기)-> 카운트를 얻는 모든곳에 쓰인다
  public static int pageCal(int listCount, int limit, int page, Model model) {
	
	int pageNum=5;//한줄에 5페이지씩 이동
	//최대 페이지수
	int maxPage = (int)((double)listCount/limit+0.9);
	//처음 페이지
	int startPage = ((int)((double)page/pageNum+0.9)-1)*pageNum+1;
	//마지막 페이지
	int endPage = maxPage;//1~5까지는 maxpage가 endpage가 되야함
	if(endPage>startPage+pageNum-1) endPage=startPage+pageNum-1;//만약에 6이상의 수가 endpage라면
	
	//페이징을 위한 변수세팅
	model.addAttribute("listCount", listCount);
	model.addAttribute("page", page);
	model.addAttribute("maxPage", maxPage);
	model.addAttribute("startPage", startPage);
	model.addAttribute("endPage", endPage);
	
	return (page-1)*limit;
  }//pageCal
  //---------------------------------------------------------------------------------------//
  //getDetail-> 상품정보를 얻는 모든곳에 쓰인다
  public ProductVo getDetail(int seqKey) {
	  
	  ProductVo pVo=productMapper.detail(seqKey);
	  return pVo;
	  
  }//getDetail
  //---------------------------------------------------------------------------------------//
  //setNav-> 네비게이션 세팅 ( 세션저장 )
  public void setNav(HttpSession session) {
	  //1차 카테고리의 전체 숫자를 구한다.
	  int navNum=productMapper.navNum();
	  //1차 카테고리의 리스트를 얻는다.
	  String[]category1=productMapper.navCategory1();
	  //navNum 만큼의 1차원 arraylist배열을 만든다.
	  ArrayList[] navList=new ArrayList[navNum];
	  //arraylist배열에 각 카테고리의 하위카테고리 검색값을 넣는다.
	  for(int i=0; i<navList.length;i++) {
		  navList[i]=productMapper.navCategory2(category1[i]);
	  }
	  session.setAttribute("nav1", category1);
	  session.setAttribute("nav2", navList);
	  
  }//setNav
  //--------------------------------------------재고관련-------------------------------------------//
  //stockCheck(재고 체크하기)
  public int stockCheck(int seqKey) {
	  
	  return productMapper.stockCheck(seqKey);
	  
  }//stockCheck
  
  //stockDown(주문시 재고감소 시키기)
  public void stockDown(int quantity, int seqKey) {
	  
	  productMapper.stockDown(quantity, seqKey);
	  
  }//stockDown
  
  //stockUp(반품,취소,환불,교환시 재고증가 시키기)
  public void stockUp(int quantity, int seqKey) {
	  
	  productMapper.stockUp(quantity, seqKey);
	  
  }//stockUp
  
  //====================================관리자 전용==========================================//
  //productListAll(상품전체 얻어오기)
  public void productListAll(Model model, int productPage, String order, String search) {
		String sqlOrder="";
		//정렬값 분기
		switch(order) {
			case "name" :
				sqlOrder="ORDER BY "+order+" ASC";
				int limit=10;//1페이지 = 게시글10개
				int productListCount = productMapper.productListSearchCount(search);
				//페이지수 계산(메소드 재활용)
				int productStartRow=ProductService.pageCal(productListCount, limit, productPage, model);
				
				//화면에 뿌려지는 변수
				model.addAttribute("allCount", productListCount);
			    model.addAttribute("productList", productMapper.productListAll(productStartRow,search,sqlOrder));
			    model.addAttribute("search",search);
			    model.addAttribute("order",order);
				return;
			case "category" :
				sqlOrder="ORDER BY category1 ASC, category2 DESC";
				break;
			case "seq_key" :
				sqlOrder="ORDER BY "+order+" DESC";
				break;
		}
		
		int limit=10;//1페이지 = 게시글10개
		int productListCount = productMapper.productListSearchCount(search);
		//페이지수 계산(메소드 재활용)
		int productStartRow=ProductService.pageCal(productListCount, limit, productPage, model);
		
		
		//화면에 뿌려지는 변수
		model.addAttribute("allCount", productListCount);
	    model.addAttribute("productList", productMapper.productListAll(productStartRow,search,sqlOrder));
	    model.addAttribute("search",search);
	    model.addAttribute("order",order);
  
  }//productListAll
  //---------------------------------------------------------------------------------------//
  //상품등록(productInsert)
  public void productInsert(HttpServletRequest request, Model model) {
	    String path_ = request.getSession().getServletContext().getRealPath("");
	    String path = path_+"files/product";
		//파일사이즈 지정-업로드 파일용량 제한
		int size = 1024 * 1024 * 10; //총 10 메가 용량 제한
		try {
			MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
			String category1 = multi.getParameter("category1");
			String category2 = multi.getParameter("category2");
			String name = multi.getParameter("name");
			int price = Integer.parseInt(multi.getParameter("price"));
			int stock = Integer.parseInt(multi.getParameter("stock"));
			int calorie = Integer.parseInt(multi.getParameter("calorie"));
			String type = multi.getParameter("type");
			String volume = multi.getParameter("volume");
			String importer = multi.getParameter("importer");
			if(importer==null) { importer="해당없음";}
			String importDeclaration = multi.getParameter("importDeclaration");
			if(importDeclaration==null) { importDeclaration="해당없음";}
			String productor = multi.getParameter("productor");
			String useByDate = multi.getParameter("useByDate");
			int salePercent = Integer.parseInt(multi.getParameter("salePercent"));
			String rawMaterials = multi.getParameter("rawMaterials");
			String nutrients = multi.getParameter("nutrients");
			if(nutrients==null) { nutrients="상품참조";}
			String gmFood = multi.getParameter("gmFood");
			if(gmFood==null) { gmFood="해당없음";}
			String csPhone = multi.getParameter("csPhone");
			String recommend = multi.getParameter("recommend");
			String newProduct = multi.getParameter("newProduct");
			String contentText = multi.getParameter("contentText");
			
			Enumeration files = multi.getFileNames();
			
			String filename1 = (String)files.nextElement();
			String contentImageFilename = multi.getFilesystemName(filename1);
			
			String filename2 = (String)files.nextElement();
			String detailImageFilename3 = multi.getFilesystemName(filename2);
			
			String filename3 = (String)files.nextElement();
			String detailImageFilename2 = multi.getFilesystemName(filename3);
			
			String filename4 = (String)files.nextElement();
			String detailImageFilename1 = multi.getFilesystemName(filename4);
			model.addAttribute("productSuccess",productMapper.productInsert(category1,category2,name,price,stock,calorie,type,volume,importer,
					importDeclaration,productor,useByDate,salePercent,rawMaterials,nutrients,gmFood,csPhone,recommend,newProduct,contentText,
					detailImageFilename1,detailImageFilename2,detailImageFilename3,contentImageFilename));
			
		}catch(Exception e) {
			e.printStackTrace();
	    }
  }//productInsert
  //---------------------------------------------------------------------------------------//
  //상품수정(productModify)
  public void productModify(HttpServletRequest request, Model model) {
	  
	    String path_ = request.getSession().getServletContext().getRealPath("");
	    String path = path_+"files/product";
		//파일사이즈 지정-업로드 파일용량 제한
		int size = 1024 * 1024 * 10; //총 10 메가 용량 제한
		try {
			MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
			int seqKey = Integer.parseInt(multi.getParameter("seqKey")); 
			String category1 = multi.getParameter("category1");
			String category2 = multi.getParameter("category2");
			String name = multi.getParameter("name");
			int price = Integer.parseInt(multi.getParameter("price"));
			int stock = Integer.parseInt(multi.getParameter("stock"));
			int calorie = Integer.parseInt(multi.getParameter("calorie"));
			String type = multi.getParameter("type");
			String volume = multi.getParameter("volume");
			String importer = multi.getParameter("importer");
			if(importer==null) { importer="해당없음";}
			String importDeclaration = multi.getParameter("importDeclaration");
			if(importDeclaration==null) { importDeclaration="해당없음";}
			String productor = multi.getParameter("productor");
			String useByDate = multi.getParameter("useByDate");
			int salePercent = Integer.parseInt(multi.getParameter("salePercent"));
			String rawMaterials = multi.getParameter("rawMaterials");
			String nutrients = multi.getParameter("nutrients");
			if(nutrients==null) { nutrients="상품참조";}
			String gmFood = multi.getParameter("gmFood");
			if(gmFood==null) { gmFood="해당없음";}
			String csPhone = multi.getParameter("csPhone");
			String recommend = multi.getParameter("recommend");
			String newProduct = multi.getParameter("newProduct");
			String contentText = multi.getParameter("contentText");
			String oldfile1 = multi.getParameter("oldfile1");
			String oldfile2 = multi.getParameter("oldfile2");
			String oldfile3 = multi.getParameter("oldfile3");
			String oldfile4 = multi.getParameter("oldfile4");
			
			Enumeration files = multi.getFileNames();
			
			String filename1 = (String)files.nextElement();
			String contentImageFilename = multi.getFilesystemName(filename1);
			
			if(contentImageFilename==null || contentImageFilename.equals("")) {
				contentImageFilename=oldfile1;
			}
			if(contentImageFilename!=null) {
				if(!(contentImageFilename.equals(oldfile1))) {
					File f = new File(path + "/" + oldfile1);
					f.delete();
				}
			}
			
			String filename2 = (String)files.nextElement();
			String detailImageFilename3 = multi.getFilesystemName(filename2);
			
			if(detailImageFilename3==null || detailImageFilename3.equals("")) {
				detailImageFilename3=oldfile2;
			}
			if(detailImageFilename3!=null) {
				if(!(detailImageFilename3.equals(oldfile2))) {
					File f = new File(path + "/" + oldfile2);
					f.delete();
				}
			}
			
			String filename3 = (String)files.nextElement();
			String detailImageFilename2 = multi.getFilesystemName(filename3);
			
			if(detailImageFilename2==null || detailImageFilename2.equals("")) {
				detailImageFilename2=oldfile3;
			}
			if(detailImageFilename2!=null) {
				if(!(detailImageFilename2.equals(oldfile3))) {
					File f = new File(path + "/" + oldfile3);
					f.delete();
				}
			}
			
			String filename4 = (String)files.nextElement();
			String detailImageFilename1 = multi.getFilesystemName(filename4);
			
			if(detailImageFilename1==null || detailImageFilename1.equals("")) {
				detailImageFilename1=oldfile4;
			}
			if(detailImageFilename1!=null) {
				if(!(detailImageFilename1.equals(oldfile4))) {
					File f = new File(path + "/" + oldfile4);
					f.delete();
				}
			}
			model.addAttribute("modifySuccess",productMapper.productModify(category1,category2,name,price,stock,calorie,type,volume,importer,
					importDeclaration,productor,useByDate,salePercent,rawMaterials,nutrients,gmFood,csPhone,recommend,newProduct,contentText,
					detailImageFilename1,detailImageFilename2,detailImageFilename3,contentImageFilename,seqKey));
			
		}catch(Exception e) {
			e.printStackTrace();
	    }
	  
  }//productModify
  //---------------------------------------------------------------------------------------//
  //상품삭제(productDelete)
  public String productDelete(HashMap<String, String> reqMap, HttpServletRequest request) {
	  
	  	int seqKey = Integer.parseInt(reqMap.get("seqKey"));
	    String path_ = request.getSession().getServletContext().getRealPath("");
	  	String path = path_+"files/product";
	  	ProductVo pVo=productMapper.detail(seqKey);
	  	String detailImageFilename1=pVo.getDetailImageFilename1();
	  	String detailImageFilename2=pVo.getDetailImageFilename2();
	  	String detailImageFilename3=pVo.getDetailImageFilename3();
	  	String contentImageFilename=pVo.getContentImageFilename();
	  	if(detailImageFilename1!=null) {
	  		File f1 = new File(path + "/" + detailImageFilename1);
	  		f1.delete();
	  	}
	  	if(detailImageFilename2!=null) {
	  		File f2 = new File(path + "/" + detailImageFilename2);
	  		f2.delete();
	  	}
	  	if(detailImageFilename3!=null) {
	  		File f3 = new File(path + "/" + detailImageFilename3);
	  		f3.delete();
	  	}
	  	if(contentImageFilename!=null) {
	  		File f4 = new File(path + "/" + contentImageFilename);
	  		f4.delete();
	  	}
	  	if(productMapper.productDelete(seqKey)==1) {
	  		return "ok";
	  	}
	  	else {
	  		return "no";
	  	}
	  
  }//productDelete
  //---------------------------------------------------------------------------------------//
  //배너등록(bannerInsert)
  public void bannerInsert(HttpServletRequest request, RedirectAttributes redirect) {
	  
	    String path_ = request.getSession().getServletContext().getRealPath("");
	    String path = path_+"files/banner";
	    //파일사이즈 지정-업로드 파일용량 제한
  		int size = 1024 * 1024 * 1; //총 1 메가 용량 제한
  		try {
  			MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
  			String category = multi.getParameter("category");
  			
  			Enumeration files = multi.getFileNames();
  			
  			String file = (String)files.nextElement();
  			String filename = multi.getFilesystemName(file);
  			
  			redirect.addAttribute("bannerSuccess",productMapper.bannerInsert(category,filename));
  			
  		}catch(Exception e) {
  			e.printStackTrace();
  	    }
		
  }//bannerInsert
  
  //배너수정(bannerModify)
  public void bannerModify(HttpServletRequest request, Model model) {
	  
	    String path_ = request.getSession().getServletContext().getRealPath("");
	    String path = path_+"files/banner";
		//파일사이즈 지정-업로드 파일용량 제한
		int size = 1024 * 1024 * 1; //총 1 메가 용량 제한
		try {
			MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
			String category = multi.getParameter("category");
			String oldfile = multi.getParameter("oldfile");
			int seqKey = Integer.parseInt(multi.getParameter("seqKey"));
			
			Enumeration files = multi.getFileNames();
			
			String file = (String)files.nextElement();
			String filename = multi.getFilesystemName(file);
			
			if(filename==null || filename.equals("")) {
				filename=oldfile;
			}
			if(!(filename.equals(oldfile))) {
				File f = new File(path + "/" + oldfile);
				f.delete();
			}
			
			model.addAttribute("modifySuccess",productMapper.bannerModify(category, filename, seqKey));
			
		}catch(Exception e) {
			e.printStackTrace();
	    }
	   
  }//bannerModify
  //---------------------------------------------------------------------------------------//
  //배너삭제
  public String bannerDelete(HashMap<String, String> reqMap, HttpServletRequest request) {
	  
	  String path_ = request.getSession().getServletContext().getRealPath("");
	  String path = path_+"files/banner";
	  int seqKey = Integer.parseInt(reqMap.get("seqKey"));
	  String filename = reqMap.get("filename");
	  
	  File f = new File(path + "/" + filename);
	  f.delete();
	  
	  productMapper.bannerDelete(seqKey);
	  
	  return "ok";
	  
  }//bannerDelete
  
  
  

  
}//class

package dev.localhost.koitt14.admin;

public class BannerVo {
	
	
	public BannerVo(int seqKey, String category, String filename) {
		super();
		this.seqKey = seqKey;
		this.category = category;
		this.filename = filename;
	}
	
	int seqKey;
	String category;
	String filename;
	
	
	public int getSeqKey() {
		return seqKey;
	}
	public void setSeqKey(int seqKey) {
		this.seqKey = seqKey;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	
	

}

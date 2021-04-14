package bbs;

public class Bbs {
	private int bbsID ;
	private String bbsTitle ;
	private String userID ;
	private String bbsDate ;
	private String bbsContent ;
	private int bbsOption ;
	private int rp ;
	private String buyuserID ;
	private int firstPrice ;
	private int secondPrice ;
	private int bbsAvailable ;
	
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getBbsTitle() {
		return bbsTitle;
	}
	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBbsDate() {
		return bbsDate;
	}
	public void setBbsDate(String bbsDate) {
		this.bbsDate = bbsDate;
	}
	public String getBbsContent() {
		return bbsContent;
	}
	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}
	public int getBbsOption() {
		return bbsOption;
	}
	public void setBbsOption(int bbsOption) {
		this.bbsOption = bbsOption;
	}
	public int getRp() {
		return rp;
	}
	public void setRp(int rp) {
		this.rp = rp;
	}
	public String getBuyuserID() {
		return buyuserID;
	}
	public void setBuyuserID(String buyuserID) {
		this.buyuserID = buyuserID;
	}
	public int getFirstPrice() {
		return firstPrice;
	}
	public void setFirstPrice(int firstPrice) {
		this.firstPrice = firstPrice;
	}
	public int getSecondPrice() {
		return secondPrice;
	}
	public void setSecondPrice(int secondPrice) {
		this.secondPrice = secondPrice;
	}
	public int getBbsAvailable() {
		return bbsAvailable;
	}
	public void setBbsAvailable(int bbsAvailable) {
		this.bbsAvailable = bbsAvailable;
	}
	
	
	@Override
	public String toString() {
		return "Bbs [bbsID=" + bbsID + ", bbsTitle=" + bbsTitle + ", userID=" + userID + ", bbsDate" + bbsDate
				+ ", bbsContent" + bbsContent + ", bbsAvailable" + bbsAvailable + "]";

	}


	
	
}

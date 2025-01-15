package jspStudy;

public class CommentC {
	/**
	 * @return the qno
	 */
	public int getCno() {
		return cno;
	}

	/**
	 * @param qno the qno to set
	 */
	public void setCno(int cno) {
		this.cno = cno;
	}

	/**
	 * @return the nno
	 */
	public int getFno() {
		return fno;
	}

	/**
	 * @param nno the nno to set
	 */
	public void setFno(int fno) {
		this.fno = fno;
	}

	/**
	 * @return the uno
	 */
	public int getUno() {
		return uno;
	}

	/**
	 * @param uno the uno to set
	 */
	public void setUno(int uno) {
		this.uno = uno;
	}

	/**
	 * @return the content
	 */
	public String getContent() {
		return content;
	}

	/**
	 * @param content the content to set
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * @return the rdate
	 */
	public String getRdate() {
		return rdate;
	}

	/**
	 * @param rdate the rdate to set
	 */
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}

	/**
	 * @return the state
	 */
	public String getState() {
		return state;
	}

	/**
	 * @param state the state to set
	 */
	public void setState(String state) {
		this.state = state;
	}

	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}

	private int  cno;
	private int  fno;
	private int  uno;
	private String content;
	private String rdate;
	private String state;
	private String id;
	
	public CommentC(int cno, int fno, int uno, String content, String rdate, String state, String id) {
		this.cno = cno;
		this.fno = fno;
		this.uno = uno;
		this.content = content;
		this.rdate = rdate;
		this.state = state;
		this.id = id;
	}

	
	
	

}

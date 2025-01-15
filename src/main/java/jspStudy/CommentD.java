package jspStudy;

public class CommentD {
	/**
	 * @return the qno
	 */
	public int getSno() {
		return sno;
	}

	/**
	 * @param qno the qno to set
	 */
	public void setSno(int sno) {
		this.sno = sno;
	}

	/**
	 * @return the nno
	 */
	public int getDno() {
		return dno;
	}

	/**
	 * @param nno the nno to set
	 */
	public void setDno(int dno) {
		this.dno = dno;
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

	private int  sno;
	private int  dno;
	private int  uno;
	private String content;
	private String rdate;
	private String state;
	private String id;
	
	public CommentD(int sno, int dno, int uno, String content, String rdate, String state, String id) {
		this.sno = sno;
		this.dno = dno;
		this.uno = uno;
		this.content = content;
		this.rdate = rdate;
		this.state = state;
		this.id = id;
	}
	
	

}

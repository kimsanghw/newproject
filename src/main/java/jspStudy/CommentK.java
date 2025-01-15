package jspStudy;

public class CommentK {
	/**
	 * @return the qno
	 */
	public int getTno() {
		return tno;
	}

	/**
	 * @param qno the qno to set
	 */
	public void setTno(int tno) {
		this.tno = tno;
	}

	/**
	 * @return the nno
	 */
	public int getKno() {
		return kno;
	}

	/**
	 * @param nno the nno to set
	 */
	public void setKno(int kno) {
		this.kno = kno;
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

	private int  tno;
	private int  kno;
	private int  uno;
	private String content;
	private String rdate;
	private String state;
	private String id;
	
	public CommentK(int tno, int kno, int uno, String content, String rdate, String state, String id) {
		this.tno = tno;
		this.kno = kno;
		this.uno = uno;
		this.content = content;
		this.rdate = rdate;
		this.state = state;
		this.id = id;
	}

	
	
	

}

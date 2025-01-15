package jspStudy;


public class UserDTO {
	
	
	private int uno;
	private String id;
	private String password;
	private String name;
	private String email;
	private int age;
	private char gender;
	private char interest;
	private String rdate;
	private  char authorization; 
	
	public UserDTO(int uno, String id, String password, String name, String email, int age, char gender, char interest, String rdate, char authorization ) {
		this.uno = uno;
		this.id = id;
		this.password = password;
		this.name = name;
		this.email = email;
		this.age = age;
		this.gender = gender;
		this.interest = interest;
		this.rdate = rdate;
		this.authorization = authorization;
		
	}
	
	
	public char getAuthorization() {
		return authorization;
	}


	public void setAuthorization(char authorization) {
		this.authorization = authorization;
	}
	
	
	public int getUno() {
		return uno;
	}
	public void setUno(int uno) {
		this.uno = uno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public char getGender() {
		return gender;
	}
	public void setGender(char gender) {
		this.gender = gender;
	}
	public char getInterest() {
		return interest;
	}
	public void setInterest(char interest) {
		this.interest = interest;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	private String state;
	

}

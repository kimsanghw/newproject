package jspStudy;

public class PagingUtil {
	//0 : �ܺο��� �޾ƿ� ���꿡 �ʿ��� �����͸� ���� �ʵ�
	//0�� ���� : 0�����͵��� Ȱ���Ͽ� ����� ����� ���� �ʵ�
	private int nowPage;   //������������ȣ0
	private int startPage; //������������ȣ
	private int endPage;   //������������ȣ
	private int total;      //��ü �Խñ� ��0
	private int perPage;    //���������� �Խñ� ����0
	private int lastPage;   //���������� ��ȣ
	private int start;      //���� �Խñ� ��ȣ
	private int end;       //���� �Խñ� ��ȣ
	private int cntPage=5;//������������ �������� ����¡��ȣ ����0
	
	public PagingUtil() {}
	public PagingUtil(int nowPage, int total, int perPage) {
		setNowPage(nowPage);
		setTotal(total);
		setPerPage(perPage);
		
		calcStartEnd(nowPage,perPage);//���۹�ȣ �����ȣ ���� ��� ȣ��
		calcLastPage(total,perPage);//���� ������ ��ȣ ���� ��� ȣ��
		calcStartEndPage(nowPage,cntPage);
		
	}
	public void calcStartEnd(int nowPage, int perPage) {
		int end = nowPage*perPage; //�Խñ� ���� ��ȣ(����Ŭ�� ���)
		
		//���� ������ : 1/�Խñ۳��ⰹ��:5
		//�����ȣ : 1*5 => 5
		//���۹�ȣ : �����ȣ - �Խñ� ���� ����(5-5=0);
		int start = end - perPage;//�Խñ� ���۹�ȣ(����Ŭ������ +1�� ����� �Ѵ�)
		
		setEnd(end);
		setStart(start);
	}
	//�� 11�� ���������� 10���� ������ ���� ��ȣ : 2
	public void calcLastPage(int total, int perPage) {
		//��ü�Խñۿ��� �������� �Խñ� ���� ���� �Ǽ��� �ø�ó�� �� ���� ��ȯ
		int lastPage = (int)Math.ceil((double)total/perPage);
		
		setLastPage(lastPage);
	}
	
	//���� ������
	public void calcStartEndPage(int nowPage, int cntPage) {
		
		//������������ 10�� �ڸ��� ���ؿ� +1�� �� �������� ���� ���������� ���ϱ�
		int endPage = (int)Math.ceil((double)nowPage/cntPage)*cntPage;
		
		int startPage = endPage - cntPage+1;
		
		if(endPage > lastPage) {endPage = lastPage;
		}
		
		
		setEndPage(endPage);
		setStartPage(startPage);
		
	}
		
	
	
	
	
	
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getPerPage() {
		return perPage;
	}
	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}
	public int getLastPage() {
		return lastPage;
	}
	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public int getCntPage() {
		return cntPage;
	}
	public void setCntPage(int cntPage) {
		this.cntPage = cntPage;
	}

}

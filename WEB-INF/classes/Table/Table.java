package Table;

import java.util.Date;

public class Table{
	private String hit;
	private Date date;
	private long time;
	private int x;
	private int y;
	private int r;

	public Table(String hit, Date date, long time, int x, int y, int r){
		this.hit = hit;
		this.date = date;
		this.time = time;
		this.x = x;
		this.y = y;
		this.r = r;
	}
	public String getHit(){
		return this.hit;
	}
	public Date getDate(){
		return this.date;
	}
	public long getTime(){
		return this.time;
	}
	public int getX(){
		return this.x;
	}
	public int getY(){
		return this.y;
	}
	public int getR(){
		return this.r;
	}
}
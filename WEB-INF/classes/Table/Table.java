package Table;

import java.util.Date;

public class Table{
	private String hit;
	private Date date;
	private long time;
	private double x;
	private double y;
	private double r;

	public Table(String hit, Date date, long time, double x, double y, double r){
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
	public double getX(){
		return this.x;
	}
	public double getY(){
		return this.y;
	}
	public double getR(){
		return this.r;
	}
	public String getColor(){
		if (this.hit.equals("Попадание")){
			return "green";
		}else {
			return "black";
		}
	}
}
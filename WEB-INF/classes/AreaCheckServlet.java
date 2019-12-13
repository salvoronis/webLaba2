import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import Table.Table;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.ArrayList;
import java.lang.Math;


public class AreaCheckServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		long start = System.currentTimeMillis();
		PrintWriter printWriter = resp.getWriter();

		HttpSession session = req.getSession();

		double x = Double.parseDouble(req.getParameter("x"));
		double y = Double.parseDouble(req.getParameter("y"));
		double r = Double.parseDouble(req.getParameter("r"));

		x*=50.0;
		y*=50.0;
		r*=50.0;

		System.out.println(x+" "+y+" "+r);

		int kolvo = 1;
		Table[] chasatri;

		Table[] жопа = (Table[]) session.getAttribute("cell");
		if(жопа != null){
			kolvo = жопа.length + 1;
		}
		
		chasatri = new Table[kolvo];

		if(жопа != null){
			for (int i = 0; i<жопа.length; i++){
				chasatri[i] = жопа[i];
			}
		}

		String hitman = checkOutThisShit(x,y,r);
		long timeSpent = System.currentTimeMillis() - start;
		Table elem = new Table(hitman,new Date(), timeSpent, x,y,r);
		chasatri[kolvo-1] = elem;

		session.setAttribute("cell", chasatri);
	}
	private String checkOutThisShit(double x,double y, double r){
		if((x <= 0) && (y <= 0) && (x >= (-r/2)) && (y >= -r)){
			return "Попадпние";
		} else
		if((x >= 0) && (y <= 0) && (y >= x-(r/2))){
			return "Попадание";
		}else
		if((x <= 0) && (y >= 0) && ((Math.pow((Math.abs(x)), 2) + Math.pow((y), 2))<=Math.pow(r, 2))){
			return "Попадание";
		}else{
			return "Промах";
		}
	}
}
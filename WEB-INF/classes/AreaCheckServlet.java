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

		int x = Integer.parseInt(req.getParameter("x"));
		int y = Integer.parseInt(req.getParameter("y"));
		int r = Integer.parseInt(req.getParameter("r"));
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

		/*Table[] mda = (Table[]) session.getAttribute("cell");
		System.out.println(mda[0]);
		for (int i = 0; i < mda.length-1; i++){
			System.out.println(i);
			System.out.println(mda[i].getHit());
		}*/
	}
	private String checkOutThisShit(int x,int y, int r){
		if((x <= 0) && (y <= 0) && (x >= (-r/2)) && (y >= -r)){
			return "Попадпние";
		} else
		if((x >= 0) && (y <= 0) && (y >= x-(r/2))){
			return "Попадание";
		}else
		if((x <= 0) && (y >= 0)){
			double d = Math.sqrt(Math.pow((Math.abs(x)-r), 2)) + Math.sqrt(Math.pow((y-r), 2));
			if (d <= r){
				return "Попадание";
			}else {
				return "Промах";
			}
		}else{
			return "Промах";
		}
	}
}
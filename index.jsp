<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Table.Table"%>
<!DOCTYPE html>
<html>
 <head lang="en" xmlns:https="http://www.w3.org/1999/xhtml">
   	<meta charset="UTF-8">
   	<title>piha</title>
   	<link href="style/style.css" rel="stylesheet" type="text/css"/>
   	<script src="http://code.jquery.com/jquery-latest.js"></script>
   	<script src="lib/date.format.js"></script>
   	<script type="text/javascript">
    $(function(){
    	doFig($("#radius").val());

    	$("#radius").change(function(){
    		doFig($("#radius").val());
    	});
       	$("input").keydown(function(event){
        	if(event.keyCode == 13){
          		event.preventDefault();
          		return false;
        	}
      	});
       	$('.radcheck').click(function(){
         	$('.radcheck').removeAttr('checked','checked');
         	$(this).prop('checked', true);
       	});
       	$('.xdim').click(function(){
         	$('.xdim').removeAttr('checked','checked');
         	$(this).prop('checked', true);
       	});

        $(".graph").on('click', function(e){
           	e.preventDefault();
           	$.ajax({
             	type: "POST",
             	url: "/ctrl",
             	data: 'x='+((e.clientX-280.0)/50.0)+'&y='+((250.0-(e.pageY-90.0))/50.0)+'&r='+$('#radius :selected').val(),
             	success: function(response){
               		console.log("ok");
               	}
           	});
       	});
    });

    function pognali(){
      var yok = false;
      var radius = $('#radius :selected').val(); //r
      var x; //x
      doFig(radius);

      var xdim = $('.xdim').each(function(){
         if ($(this).prop('checked') == true){
           x = $(this).val();
         }
       });
      //y start
      var ydim = $('#ydim').val(); // y
      var reg = /^-[1-5]$/;
      var reg2 = /^[0-3]$/;
      yok = reg.test(ydim) || reg2.test(ydim);
      //send data
      if (!yok){
        $('#kotae').remove();
        $('.form').after('<div id="kotae">Data error</div>');
      } else {
        $('#kotae').remove();
        $.ajax({
          type: "POST",
          url: "/ctrl",
          data: 'x='+x+'&y='+ydim+'&r='+radius,
          success: function(response){
            	console.log("ok");
            },
          error : function(data){
            console.log(data.getResponseHeader());
        }
        });
      }
     }

     function doIT(maxx, minx, miny, maxy){
       var point = 20;
       for (var i = -5; i < 6; i++) {
         if (minx == i) {
           minx = point;
         }
         if (maxx == i) {
           maxx = point;
         }
         if (miny == i) {
           miny = point;
         }
         if (maxy == i){
           maxy = point;
         }
         point+=50;
       }
       $('#xline').attr('x1',minx);
       $('#xline').attr('x2',maxx);
       $('#xtrig').attr('points', maxx+',265 '+maxx+',275 '+(maxx+20)+',270');
       $('#xp').attr('x', maxx+10);
       $('#yline').attr('y1',miny);
       $('#yline').attr('y2',maxy);
       $('#ytrig').attr('points', '270,'+(miny-20)+' 265,'+miny+' 275,'+miny);
       $('#yp').attr('y',miny-10);
     }

     function doFig(r){
       r*=50;
       var rh = r/2;
       var ostRec = 195+(75-rh);
       var poly = 270-r;
       var ring = 270+rh;
       var pointy = 270-r;
       $('rect').attr('x', ostRec);
       $('rect').attr('width', rh);
       $('rect').attr('height', r);
       $('#triangle').attr('points', '270,270 '+ring+',270 270,'+ring);
       $('path').attr('d','M 270 '+poly+' A '+r+' '+r+', 90, 0, 0, '+poly+' 270 L 270 270 Z');
       $('.ypoint').each(function(index){
         var kuda = (index*rh)+pointy;
         $(this).attr('y',kuda);
       });
       $('.xpoint').each(function(index){
         var kuda = (index*rh)+pointy;
         $(this).attr('x',kuda);
       });
     }
   </script>
 </head>
 <body>
   	<div id="header">
    	Яремко Роман Группа: R3236(P3202) Вариант: 202023
   	</div>
   	<div class="top">
         <div id="svg">
           <svg version="1.2" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" class="graph" aria-labelledby="title" role="img">
             <title id="title">хех лол</title>
             <g class="grid x-grid" id="xGrid">
               <line id="yline" x1="270" x2="270" y1="20" y2="520"></line>
               <polygon id="ytrig" points="270,0 265,20 275,20" stroke="#acb299" fill="#acb299"></polygon>
             </g>
             <g class="grid y-grid" id="yGrid">
               <line fill="black" id="xline" x1="20" x2="520" y1="270" y2="270"></line>
               <polygon id="xtrig" points="520,265 520,275 540,270" stroke="#acb299" fill="#acb299"></polygon>
             </g>
             <g class="labels x-labels">
               <text class="xpoint" x="120" y="270">-r</text>
               <text class="xpoint" x="195" y="270">-r/2</text>
               <text class="xpoint" x="270" y="270">0</text>
               <text class="xpoint" x="345" y="270">r/2</text>
               <text class="xpoint" x="420" y="270">r</text>
               <text id="xp" x="430" y="265" class="label-title">x</text>
             </g>
             <g class="labels y-labels">
               <text class="ypoint" x="270" y="120">r</text>
               <text class="ypoint" x="270" y="195">r/2</text>
               <text class="ypoint" x="270" y="270"></text>
               <text class="ypoint" x="270" y="345">-r/2</text>
               <text class="ypoint" x="270" y="420">-r</text>
               <text id="yp" x="270" y="10" class="label-title">y</text>
             </g>
             <g class="data" data-setname="Our first data set">
                 <rect class="meichu" x="195" y="270" width="75" height="150"/>
                 <polygon id="triangle" class="meichu" points="270,270 345,270 270,345"></polygon>
                 <path class="meichu" d="M 270 120 A 150 150, 90, 0, 0, 120 270 L 270 270 Z"></path>
                <%
		       	if (session.getAttribute("cell") != null){
		       		Table[] table = (Table[]) session.getAttribute("cell");
		       		for (int i = 0; i<table.length; i++){
		       	%>
		       		<circle style="fill: green" cx="<%=table[i].getX()+270%>" cy="<%=Math.abs(table[i].getY()-270)%>" r="4"/>
		       	<%System.out.println(table[i].getY());
		    	}}
		       	%>
             </g>
           </svg>
         </div>
         <div class="form">
           <form id="forma">
             <table>
               <tr>
                 <td></td>
                 <td>-2</td>
                 <td>-1.5</td>
                 <td>-1</td>
                 <td>-0.5</td>
                 <td>0</td>
                 <td>0.5</td>
                 <td>1</td>
                 <td>1.5</td>
                 <td>2</td>
               </tr>
               <tr>
                 <td>x</td>
                 <td><input type="checkbox" class="xdim" value="-2"></td>
                 <td><input type="checkbox" class="xdim" value="-1.5"></td>
                 <td><input type="checkbox" class="xdim" value="-1"></td>
                 <td><input type="checkbox" class="xdim" value="-0.5"></td>
                 <td><input type="checkbox" class="xdim" value="0" checked></td>
                 <td><input type="checkbox" class="xdim" value="0.5"></td>
                 <td><input type="checkbox" class="xdim" value="1"></td>
                 <td><input type="checkbox" class="xdim" value="1.5"></td>
                 <td><input type="checkbox" class="xdim" value="2"></td>
               </tr>
             </table>
             <p>y</p><input id="ydim" type="text" name="ydim" placeholder="(-5..3)">
             <table>
               <tr>
               	<td>R</td>
               	<td>
               		<select required id="radius">
               			<option value="1">1</option>
               			<option value="2">2</option>
            	   		<option value="3">3</option>
               			<option value="4">4</option>
               			<option value="5">5</option>
               		</select>
               	</td>
               </tr>
             </table>
             <input id="butt" type="button" onclick="pognali();" value="Проверить">
           </form>
         </div>
   </div>
   <div>
     <table id="resultSet">
       <tr id="tableHead">
         <th>№</th>
         <th>Попадание</th>
         <th>Время</th>
         <th>Время работы скрипта</th>
         <th>x</th>
         <th>y</th>
         <th>r</th>
       </tr>
       	<%
       	if (session.getAttribute("cell") != null){
       		Table[] table = (Table[]) session.getAttribute("cell");
       		for (int i = 0; i<table.length; i++){
       	%>
       		<tr class="tableCell">
       			<td><%=i%></td>
       			<td><%=table[i].getHit()%></td>
       			<td><%=table[i].getDate()%></td>
       			<td><%=table[i].getTime()%></td>
       			<td><%=table[i].getX()/50%></td>
       			<td><%=table[i].getY()/50%></td>
       			<td><%=table[i].getR()/50%></td>
       		</tr>
       	<%
    	}}
       	%>
     </table>
   </div>
 </body>
</html>
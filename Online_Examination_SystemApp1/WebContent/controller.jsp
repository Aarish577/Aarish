
<%@page import="java.time.LocalTime"%>
<%@page import="com.riveyra.User"%>
<%@page import="com.riveyra.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <%-- <jsp:useBean id="pDAO" class="com.riveyra.DatabaseClass" scope="page"/> --%>
<%

DatabaseClass obj1=new DatabaseClass();
if(request.getParameter("page").toString().equals("login")){
	
if(obj1.loginValidate(request.getParameter("username").toString(), request.getParameter("password").toString())){
    //session.setAttribute("userStatus", "1");
    //session.setAttribute("user_id",pDAO.getUserId(request.getParameter("username")));
    response.sendRedirect("dashboard.jsp");

}else{
    //request.getSession().setAttribute("userStatus", "-1");
    response.sendRedirect("dashboard.jsp");
}

}else if(request.getParameter("page").toString().equals("register")){
	String user_id =request.getParameter("user_id");
        String fName =request.getParameter("fname");
        String lName =request.getParameter("lname");
        String uName=request.getParameter("uname");
        String email=request.getParameter("email");
        String pass=request.getParameter("pass");
        String contactNo =request.getParameter("contactno");
        String city =request.getParameter("city");
        String address =request.getParameter("address");
    
         
    obj1.addNewStudent(user_id,fName,lName,uName,email,pass,contactNo,city,address);
    response.sendRedirect("adm-page.jsp?pgprt=1");
}else if(request.getParameter("page").toString().equals("profile")){
	String user_id =request.getParameter("user_id");
        String fName =request.getParameter("fname");
        String lName =request.getParameter("lname");
        String uName=request.getParameter("uname");
        String email=request.getParameter("email");
        String pass=request.getParameter("pass");
        String contactNo =request.getParameter("contactno");
        String city =request.getParameter("city");
        String address =request.getParameter("address");
         String uType =request.getParameter("utype");
        int uid=Integer.parseInt(session.getAttribute("user_id").toString());
    
         
    obj1.updateStudent(uid,fName,lName,uName,email,pass,contactNo,city,address,uType);
    response.sendRedirect("dashboard.jsp");
}else if(request.getParameter("page").toString().equals("courses")){
    if(request.getParameter("operation").toString().equals("addnew")){
    	obj1.addNewCourse(request.getParameter("coursename"),Integer.parseInt(request.getParameter("totalmarks")),
                request.getParameter("time"));
        response.sendRedirect("adm-page.jsp?pgprt=2");
    }else if(request.getParameter("operation").toString().equals("del")){
    	obj1.delCourse(request.getParameter("cname").toString());
        response.sendRedirect("adm-page.jsp?pgprt=2");
    }

}else if(request.getParameter("page").toString().equals("accounts")){
    if(request.getParameter("operation").toString().equals("del")){
    	obj1.delUser(Integer.parseInt(request.getParameter("uid")));
        response.sendRedirect("adm-page.jsp?pgprt=1");
    }

}else if(request.getParameter("page").toString().equals("questions")){
    if(request.getParameter("operation").toString().equals("addnew")){
    	obj1.addQuestion(request.getParameter("coursename"),request.getParameter("question"),
                request.getParameter("opt1"), request.getParameter("opt2"),request.getParameter("opt3"),
        request.getParameter("opt4"), request.getParameter("correct"));
        response.sendRedirect("adm-page.jsp?pgprt=3");
    }else if(request.getParameter("operation").toString().equals("del")){
    	obj1.delCourse(request.getParameter("cname").toString());
        response.sendRedirect("adm-page.jsp?pgprt=3");
    }else if(request.getParameter("operation").toString().equals("delQuestion")){
    	obj1.delQuestion(Integer.parseInt(request.getParameter("qid")));
        response.sendRedirect("adm-page.jsp?pgprt=3");
        
    }

}else if(request.getParameter("page").toString().equals("exams")){
    if(request.getParameter("operation").toString().equals("startexam")){
        String cName=request.getParameter("coursename");
        int user_id=Integer.parseInt(session.getAttribute("user_id").toString());
        
        int examId=obj1.startExam(cName,user_id);
        session.setAttribute("examId",examId);
        session.setAttribute("examStarted","1");
        response.sendRedirect("std-page.jsp?pgprt=1&coursename="+cName);
    }else if(request.getParameter("operation").toString().equals("submitted")){
        try{
        String time=LocalTime.now().toString();
        int size=Integer.parseInt(request.getParameter("size"));
        int eId=Integer.parseInt(session.getAttribute("examId").toString());
        int tMarks=Integer.parseInt(request.getParameter("totalmarks"));
        session.removeAttribute("examId");
        session.removeAttribute("examStarted");
        for(int i=0;i<size;i++){
            String question=request.getParameter("question"+i);
            String ans=request.getParameter("ans"+i);
            
            int qid=Integer.parseInt(request.getParameter("qid"+i));
            
            obj1.insertAnswer(eId,qid,question,ans);
        }
        System.out.println(tMarks+" conn\t Size: "+size);
        obj1.calculateResult(eId,tMarks,time,size);
        
        response.sendRedirect("std-page.jsp?pgprt=1&eid="+eId+"&showresult=1");
        }catch(Exception e){
            e.printStackTrace();
        }
        
        
    }

}else if(request.getParameter("page").toString().equals("logout")){
    session.setAttribute("userStatus","0");
    session.removeAttribute("examId");
    session.removeAttribute("examStarted");
    response.sendRedirect("index.jsp");
}

%>
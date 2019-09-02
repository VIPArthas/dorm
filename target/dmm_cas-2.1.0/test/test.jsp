<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Insert title here</title>
</head>
<body>
ssssssssssss


<script type="text/javascript">  
    function getXMLHTTPRequest(){  
        if (XMLHttpRequest)    {  
            return new XMLHttpRequest();  
        } else {  
            try{  
                return new ActiveXObject('Msxml2.XMLHTTP');  
            }catch(e){  
                return new ActiveXObject('Microsoft.XMLHTTP');  
            }  
        }  
    }  
    var req = getXMLHTTPRequest();  
    req.open('DELETE','http://localhost:8080/dmm_cas/test/test.html',false);  
    req.send(null);  
    document.write(req.responseText);  
      
</script>  
    
</body>
</html>
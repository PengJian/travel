
//动态的查看被选择线路的结果
var xmlHttp;
function createXDOM() {   
     
  if(window.XMLHttpRequest) {   
         
      xmlHttp = new XMLHttpRequest;      
         
  } else if (window.ActiveXObject) {   
         
      xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");   
  } else {   
         
      xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");   
  }       
}   

function getInfoByValue(url,value) {   
  createXDOM();   
// var name = document.getElementsByName(name)[0].value;   
     
// var url = "query.do";   
  var param = value;   
  xmlHttp.open("post",url,true); 
//xmlHttp.setRequestHeader("Content-Type","text/xml");   
  xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
//xmlhttp.setRequestHeader("Content-Length",param.length); 
//xmlHttp.setRequestHeader("Charset","utf-8");
//xmlhttp.setRequestHeader("Connection", "close");

  xmlHttp.onreadystatechange = function(){   
      if(xmlHttp.readyState==4) {   
          //alert(xmlHttp.responseText);
          document.getElementById("post").innerHTML=xmlHttp.responseText;   
      } else {   
          document.getElementById("post").innerHTML="请稍等...";   
      }   
  } ;
  xmlHttp.send(param);  
} 

function doTravelChoose(url,id){
  getInfoByValue(url,encodeURI("routeId="+id));
}



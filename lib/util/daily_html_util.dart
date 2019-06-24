import 'package:flutter_zhihu_daily/model/models.dart';

///生成详情html文本
String parseDetailHtml(Detail detail) {
  assert(detail!=null);
  //参考了web端的排版
  String htmlTemplate = """
    <!DOCTYPE HTML>
    <html>
      <head>
        <meta name="viewport" content="user-scalable=no, width=device-width">
        <link rel='stylesheet' type='text/css' href='http://daily.zhihu.com/css/share.css'/>
        ${_parseCSSLink(detail.css)}
      </head>
      <body>
        ${detail.body}
      </body>
      ${_parseJSScript(detail.js)}
      <script type="text/javascript">
		    var x=document.getElementsByClassName('headline')[0]
			    .getElementsByClassName('img-place-holder')[0];
			  x.setAttribute("class", "img-wrap");
			  x.innerHTML='<h1 class="headline-title">${detail.title}</h1>'
				  +'<span class="img-source">${detail.imageSource}</span>'
				  +'<img id="head_image" src="${detail.image}" alt="">'
				  +'<div class="img-mask"></div>';
				var img=document.getElementById('head_image');
			  img.style.height=img.offsetWidth*0.75+'px';
	  </script>
    </html>
    """;
  return htmlTemplate;
}

///将css地址转换成dom元素
String _parseCSSLink(List<String> cssUrlList){
  String cssString="";
  if(cssUrlList!=null){
    for(String css in cssUrlList){
      cssString+="<link rel='stylesheet' type='text/css' href='$css'/>";
    }
  }
  return cssString;
}

///将js地址转换成dom元素
String _parseJSScript(List<String> jsUrlList){
  String jsString="";
  if(jsUrlList!=null){
    for(String js in jsUrlList){
      jsString+="<script type='text/javascript' src='$js'></script>";
    }
  }
  return jsString;
}
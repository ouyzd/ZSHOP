<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/layout/taglib.jspf"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>主页--简易出单系统</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <%@ include file="/WEB-INF/layout/common-css.jspf"%>
  </head>
  <body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper" id="wrapper">
  
	<%@ include file="/WEB-INF/layout/menu.jspf"%>
      <div class="content-wrapper" id="content-wrapper">
        <div class=" main-bg2"></div>
        <section class="content-header">
          <ol class="breadcrumb" id="breadcrumb" style="display:none">  
          </ol>
        </section>

        <!-- Main content -->
        <section class="content" id="main-content" > 
        	<!-- <div ><img src="dist/img/welcome-bg3.png" alt="背景图" style="position: absolute;top: 15%;
    left: 40%;" class="wel-shadow"></div> -->
        </section>
      
       </div>
      <footer class="main-footer" id="main-footer">
        <div class="pull-right hidden-xs">
          <b>版本</b> 1.0.0
        </div>
      <strong>Copyright &copy; 2016-2017 <a href="javascript:;">深圳华安保险</a>.</strong> 保留所有权利.
      </footer>

      <aside class="control-sidebar control-sidebar-dark" id="control-sidebar">
        <!-- Create the tabs -->
        <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
        </ul>
        <!-- Tab panes -->
        <div class="tab-content">
          <div class="tab-pane" id="control-sidebar-home-tab">
          </div>
        </div>
      </aside>
      <div class="control-sidebar-bg"></div>
    </div>

    <script type="text/javascript">
		var contextPath = "${ctx}";
	</script>
    <script src="${ctx}/plugins/requirejs/require.js"></script>
    <script type="text/javascript">
    function init(){
    	var MAC="";
    	try {
    		var locator = new ActiveXObject("WbemScripting.SWbemLocator"); 
    		var service = locator.ConnectServer("."); 
    		var properties = service.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration Where IPEnabled=TRUE"); 
    		var e = new Enumerator (properties); 
    		var i=1; 
    		for (;!e.atEnd();e.moveNext()){
    			var p = e.item();
    			MAC = p.MACAddress;
    			i++; 
    		}
    	    require(['require', './devjs/require_config'], function (require, config) {
    	        /* config.urlArgs = version_; */
    	        window.require.config(config);
    	        require(['${ctx}/plugins/jQueryUI/jquery-ui.min.js']);
    	        require(['${ctx}/devjs/bootstrap.js']);
    	        require(['jquery'],function(){
    	        	$.ajax('/commonAjax/checkMac/', {
    	         	   type : 'GET',
    					   data : {  'macNo' : MAC },
    					   async : false,
    					   cache:false,
    					   success : function(data){
    							var errorMassage = data.datas.errorMassage;
    							if(errorMassage && errorMassage != ""){
    								alert(errorMassage);
    								location.href ="${ctx}/logout";
    							}
    						}
    					});
    	        });
    	    });
    	} catch(e) {
    		MAC = "";
    	}
    }
    window.onload=init;
	</script>
    <script>
        // obtain requirejs config
        require(['require', './devjs/require_config'], function (require, config) {

            // set cache beater
            config.urlArgs = 'bust=v0.1.0';

            // update global require config
            window.require.config(config);

            // load app
            require(['${ctx}/devjs/bootstrap.js']);
        });
    </script>
  </body>
</html>
MODx.panel.Welcome=function(A){A=A||{};Ext.applyIf(A,{id:"modx-panel-welcome",defaults:{collapsible:false,autoHeight:true},items:[{html:"<h2>"+MODx.config.site_name+"</h2>",id:"modx-welcome-header",cls:"modx-page-header",border:false},{title:_("configcheck_title"),contentEl:"modx-config",style:"padding: 0 0 10px;",bodyStyle:"padding: 10px;",collapsible:true,titleCollapse:true,hidden:!A.displayConfigCheck},{xtype:"portal",id:"modx-welcome-portal",items:[{columnWidth:0.47,id:"modx-welcome-col-left",defaults:{height:300,autoHeight:false,autoScroll:true,titleCollapse:true},items:[{title:_("modx_news"),contentEl:"modx-news",cls:"x-panel-header x-portal-space",hidden:A.newsEnabled?false:true},{title:_("recent_docs"),id:"modx-recent",cls:"x-panel-header x-portal-space",collapsed:true,hidden:MODx.hasViewDocument==1?false:true,items:[{html:"<p>"+_("activity_message"),border:false},{xtype:"modx-grid-user-recent-resource",user:A.user,preventRender:true}]},{title:_("online"),contentEl:"modx-online",collapsed:true,cls:"x-panel-header x-portal-space",hidden:MODx.hasViewUser==1?false:true}]},{columnWidth:0.47,id:"modx-welcome-col-right",defaults:{height:300,autoHeight:false,autoScroll:true,titleCollapse:true},items:[{title:_("security_notices"),contentEl:"modx-security",cls:"x-panel-header x-portal-space",hidden:A.securityEnabled?false:true},{title:_("info"),contentEl:"modx-info",cls:"x-panel-header x-panel-footer x-portal-space",style:"",collapsed:true}]}]}]});MODx.panel.Welcome.superclass.constructor.call(this,A);MODx.fireEvent("ready");};Ext.extend(MODx.panel.Welcome,MODx.FormPanel);Ext.reg("modx-panel-welcome",MODx.panel.Welcome);
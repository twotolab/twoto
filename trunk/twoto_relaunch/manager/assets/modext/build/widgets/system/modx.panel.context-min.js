MODx.panel.Context=function(A){A=A||{};Ext.applyIf(A,{url:MODx.config.connectors_url+"context/index.php",baseParams:{},id:"modx-panel-context",class_key:"modContext",plugin:"",bodyStyle:"",items:[{html:"<h2>"+_("context")+": "+A.context+"</h2>",border:false,id:"modx-context-name",cls:"modx-page-header"},MODx.getPageStructure([{title:_("general_information"),autoHeight:true,layout:"form",bodyStyle:"padding: 15px",defaults:{border:false,msgTarget:"side"},items:[{xtype:"statictextfield",fieldLabel:_("key"),name:"key",width:300,maxLength:255,enableKeyEvents:true,allowBlank:false,value:A.context,submitValue:true},{xtype:"textarea",fieldLabel:_("description"),name:"description",width:300,grow:true},{html:MODx.onContextFormRender,border:false}]},{title:_("context_settings"),bodyStyle:"padding: 15px",autoHeight:true,items:[{html:"<p>"+_("context_settings_desc")+"</p>",id:"modx-context-settings-desc",border:false},{xtype:"modx-grid-context-settings",title:"",preventRender:true,context_key:A.context,listeners:{"afteredit":{fn:function(){this.markDirty();},scope:this}}}]},{title:_("access_permissions"),bodyStyle:"padding: 15px",autoHeight:true,items:[{xtype:"modx-grid-access-context",title:"",preventRender:true,context_key:A.context,listeners:{"afteredit":{fn:function(){this.markDirty();},scope:this}}}]}],{id:"modx-context-tabs"})],useLoadingMask:true,listeners:{"setup":{fn:this.setup,scope:this},"success":{fn:this.success,scope:this},"beforeSubmit":{fn:this.beforeSubmit,scope:this}}});MODx.panel.Context.superclass.constructor.call(this,A);};Ext.extend(MODx.panel.Context,MODx.FormPanel,{setup:function(){if(this.config.context===""||this.config.context===0){this.fireEvent("ready");return false;}MODx.Ajax.request({url:this.config.url,params:{action:"get",key:this.config.context},listeners:{"success":{fn:function(B){this.getForm().setValues(B.object);var A=Ext.getCmp("modx-context-name");if(A){A.getEl().update("<h2>"+_("context")+": "+B.object.key+"</h2>");}this.fireEvent("ready");MODx.fireEvent("ready");},scope:this}}});},beforeSubmit:function(C){var B={};var A=Ext.getCmp("modx-grid-context-settings");if(A){B.settings=A.encodeModified();}Ext.apply(C.form.baseParams,B);},success:function(C){var B=Ext.getCmp("modx-grid-context-settings");if(B){B.getStore().commitChanges();}var A=parent.Ext.getCmp("modx-resource-tree");if(A){A.refreshNode(this.config.context+"_0",true);}}});Ext.reg("modx-panel-context",MODx.panel.Context);
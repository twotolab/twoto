Ext.onReady(function(){MODx.load({xtype:"modx-page-content-type"});});MODx.page.ContentType=function(A){A=A||{};Ext.applyIf(A,{formpanel:"modx-panel-content-type",buttons:[{process:"updateFromGrid",text:_("save"),method:"remote",keys:[{key:MODx.config.keymap_save||"s",alt:true,ctrl:true}]},"-",{process:"cancel",text:_("cancel"),params:{a:MODx.action["welcome"]}},"-",{text:_("help_ex"),handler:MODx.loadHelpPane}],components:[{xtype:"modx-panel-content-type",title:"",renderTo:"modx-panel-content-type-div"}]});MODx.page.ContentType.superclass.constructor.call(this,A);};Ext.extend(MODx.page.ContentType,MODx.Component);Ext.reg("modx-page-content-type",MODx.page.ContentType);
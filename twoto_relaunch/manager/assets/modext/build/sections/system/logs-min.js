Ext.onReady(function(){MODx.load({xtype:"modx-page-manager-log"});});MODx.page.ManagerLog=function(A){A=A||{};Ext.applyIf(A,{formpanel:"modx-panel-manager-log",components:[{xtype:"modx-panel-manager-log",renderTo:"modx-panel-manager-log-div"}]});MODx.page.ManagerLog.superclass.constructor.call(this,A);};Ext.extend(MODx.page.ManagerLog,MODx.Component);Ext.reg("modx-page-manager-log",MODx.page.ManagerLog);
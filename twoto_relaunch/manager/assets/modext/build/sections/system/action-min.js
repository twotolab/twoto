Ext.onReady(function(){MODx.load({xtype:"modx-page-actions"});});MODx.page.Actions=function(A){A=A||{};Ext.applyIf(A,{components:[{xtype:"modx-panel-actions",renderTo:"modx-panel-actions-div"}],buttons:[{text:_("help_ex"),handler:MODx.loadHelpPane}]});MODx.page.Actions.superclass.constructor.call(this,A);};Ext.extend(MODx.page.Actions,MODx.Component);Ext.reg("modx-page-actions",MODx.page.Actions);
Ext.onReady(function(){MODx.load({xtype:"modx-page-workspace"});});MODx.page.Workspace=function(A){A=A||{};Ext.applyIf(A,{components:[{xtype:"modx-panel-workspace",renderTo:"modx-panel-workspace-div"}],buttons:[{text:_("help_ex"),handler:MODx.loadHelpPane}]});MODx.page.Workspace.superclass.constructor.call(this,A);Ext.Ajax.timeout=0;};Ext.extend(MODx.page.Workspace,MODx.Component);Ext.reg("modx-page-workspace",MODx.page.Workspace);
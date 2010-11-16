MODx.grid.Language=function(A){A=A||{};Ext.applyIf(A,{title:_("languages"),id:"modx-grid-language",url:MODx.config.connectors_url+"system/language.php",fields:["id","name","menu"],width:"97%",paging:true,autosave:true,primaryKey:"name",columns:[{header:_("name"),dataIndex:"name",width:200,sortable:true}],tbar:[{text:_("language_create"),handler:{xtype:"modx-window-language-create",listeners:{"success":{fn:function(D){var C=D.a.result.object;this.refresh();var B=Ext.getCmp("modx-grid-lexicon");if(B){B.setFilterParams(null,null,C.name);}},scope:this}}},scope:this}]});MODx.grid.Language.superclass.constructor.call(this,A);};Ext.extend(MODx.grid.Language,MODx.grid.Grid,{duplicateLanguage:function(A,B){var C=Ext.Ajax.timeout;Ext.Ajax.timeout=0;this.menu.record.new_name=_("duplicate_of")+this.menu.record.name;this.loadWindow(A,B,{xtype:"modx-window-language-duplicate",record:this.menu.record,listeners:{"success":{fn:function(E){Ext.Ajax.timeout=C;this.refresh();var D=Ext.getCmp("modx-grid-lexicon");if(D){D.setFilterParams(null,null,E.name);}},scope:this}}});}});Ext.reg("modx-grid-language",MODx.grid.Language);MODx.window.CreateLanguage=function(A){A=A||{};var B=A.record;Ext.applyIf(A,{title:_("language_create"),url:MODx.config.connectors_url+"system/language.php",action:"create",fields:[{xtype:"textfield",fieldLabel:_("name"),name:"name",itemId:"name",anchor:"95%",maxLength:100,allowBlank:false}]});MODx.window.CreateLanguage.superclass.constructor.call(this,A);};Ext.extend(MODx.window.CreateLanguage,MODx.Window);Ext.reg("modx-window-language-create",MODx.window.CreateLanguage);MODx.window.DuplicateLanguage=function(A){A=A||{};var B=A.record;Ext.applyIf(A,{title:_("language_duplicate"),url:MODx.config.connectors_url+"system/language.php",action:"duplicate",fields:[{xtype:"statictextfield",fieldLabel:_("duplicate"),name:"name",itemId:"name",anchor:"95%",maxLength:100,allowBlank:false,submitValue:true},{xtype:"textfield",fieldLabel:_("language_new_name"),description:_("language_new_name_desc"),name:"new_name",itemId:"new_name",anchor:"95%",allowBlank:false},{xtype:"checkbox",boxLabel:_("language_recursive"),description:_("language_recursive_desc"),name:"recursive",itemId:"recursive",inputValue:1,checked:true}]});MODx.window.DuplicateLanguage.superclass.constructor.call(this,A);};Ext.extend(MODx.window.DuplicateLanguage,MODx.Window);Ext.reg("modx-window-language-duplicate",MODx.window.DuplicateLanguage);
MODx.combo.LexiconTopic=function(A){A=A||{};Ext.applyIf(A,{name:"topic",hiddenName:"topic",forceSelection:true,typeAhead:false,editable:false,allowBlank:false,listWidth:300,url:MODx.config.connectors_url+"workspace/lexicon/topic.php",fields:["name"],displayField:"name",valueField:"name",baseParams:{action:"getList","namespace":"core","language":"en"}});MODx.combo.LexiconTopic.superclass.constructor.call(this,A);};Ext.extend(MODx.combo.LexiconTopic,MODx.combo.ComboBox,{setNamespace:function(B,A){this.store.baseParams["namespace"]=B;this.store.load({callback:function(){if(A){this.setValue(A);}},scope:this});},setLanguage:function(B,A){this.store.baseParams["language"]=B;this.store.load({callback:function(){if(A){this.setValue(A);}},scope:this});}});Ext.reg("modx-combo-lexicon-topic",MODx.combo.LexiconTopic);
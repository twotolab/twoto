Ext.namespace("MODx.tree");MODx.tree.Tree=function(D){D=D||{};Ext.applyIf(D,{baseParams:{},action:"getNodes",loaderConfig:{}});if(D.action){D.baseParams.action=D.action;}D.loaderConfig.dataUrl=D.url;D.loaderConfig.baseParams=D.baseParams;Ext.applyIf(D.loaderConfig,{preloadChildren:true,clearOnLoad:true});this.config=D;var C,B;if(this.config.url){C=new Ext.tree.TreeLoader(D.loaderConfig);C.on("beforeload",function(F,G){C.dataUrl=this.config.url+"?action="+this.config.action+"&id="+G.attributes.id;if(G.attributes.type){C.dataUrl+="&type="+G.attributes.type;}},this);C.on("load",this.onLoad,this);B={nodeType:"async",text:D.root_name||D.rootName||"",draggable:false,id:D.root_id||D.rootId||"root"};}else{C=new Ext.tree.TreeLoader({preloadChildren:true,baseAttrs:{uiProvider:MODx.tree.CheckboxNodeUI}});B=new Ext.tree.TreeNode({text:this.config.rootName||"",draggable:false,id:this.config.rootId||"root",children:this.config.data||[]});}Ext.applyIf(D,{useArrows:true,autoScroll:true,animate:true,enableDD:true,enableDrop:true,ddAppendOnly:false,containerScroll:true,collapsible:true,border:false,autoHeight:true,rootVisible:true,loader:C,header:false,hideBorders:true,bodyBorder:false,cls:"modx-tree",root:B,preventRender:false,menuConfig:{defaultAlign:"tl-b?",enableScrolling:false}});if(D.remoteToolbar===true&&(D.tbar===undefined||D.tbar===null)){Ext.Ajax.request({url:D.url,params:{action:"getToolbar"},scope:this,success:function(I){I=Ext.decode(I.responseText);if(I.success){var H=this._formatToolbar(I.object);var F=this.getTopToolbar();if(F){for(var G=0;G<H.length;G++){F.add(H[G]);}F.doLayout();}}}});D.tbar={bodyStyle:"padding: 0"};}else{var A=this.getToolbar();if(D.tbar&&D.useDefaultToolbar){A.push("-");for(var E=0;E<D.tbar.length;E++){A.push(D.tbar[E]);}}else{if(D.tbar){A=D.tbar;}}Ext.apply(D,{tbar:A});}this.setup(D);this.config=D;};Ext.extend(MODx.tree.Tree,Ext.tree.TreePanel,{menu:null,options:{},disableHref:false,onLoad:function(C,E,F){var D=Ext.decode(F.responseText);if(D.message){var B=this.getTreeEl();B.addClass("modx-tree-load-msg");B.update(D.message);var A=270;if(this.config.width>150){A=this.config.width;}B.setWidth(A);this.doLayout();}},setup:function(A){MODx.tree.Tree.superclass.constructor.call(this,A);this.addEvents("afterSort","beforeSort");this.cm=new Ext.menu.Menu(A.menuConfig);this.on("contextmenu",this._showContextMenu,this);this.on("beforenodedrop",this._handleDrop,this);this.on("nodedragover",this._handleDrop,this);this.on("nodedrop",this._handleDrag,this);this.on("click",this._saveState,this);this.on("contextmenu",this._saveState,this);this.on("click",this._handleClick,this);this.treestate_id=this.config.id||Ext.id();this.on("load",this._initExpand,this,{single:true});this.on("expandnode",this._saveState,this);this.on("collapsenode",this._saveState,this);this.on("render",function(){this.root.expand();var B=this.getLoader();Ext.apply(B,{fullMask:new Ext.LoadMask(this.getEl(),{msg:_("loading")})});B.fullMask.removeMask=false;B.on({"load":function(){this.fullMask.hide();},"loadexception":function(){this.fullMask.hide();},"beforeload":function(){this.fullMask.show();},scope:B});},this);},_initExpand:function(){var A=Ext.state.Manager.get(this.treestate_id);if(Ext.isEmpty(A)&&this.root){this.root.expand();if(this.root.firstChild&&this.config.expandFirst){this.root.firstChild.select();this.root.firstChild.expand();}}else{for(var B=0;B<A.length;B++){this.expandPath(A[B]);}}},addContextMenuItem:function(C){var B=C,A=B.length;for(var D=0;D<A;D++){B[D].scope=this;this.cm.add(B[D]);}},_showContextMenu:function(B,C){B.select();this.cm.activeNode=B;this.cm.removeAll();var A;if(this.getMenu){A=this.getMenu(B,C);}else{if(B.attributes.menu&&B.attributes.menu.items){A=B.attributes.menu.items;}}this.addContextMenuItem(A);this.cm.showAt(C.xy);C.preventDefault();C.stopEvent();},hasNode:function(A,B){return(A.findChild("id",B.id))||(A.leaf===true&&A.parentNode.findChild("id",B.id));},refresh:function(E,D,B){var A=Ext.state.Manager.get(this.treestate_id);this.root.reload();if(A===undefined){this.root.expand(null,null);}else{for(var C=0;C<A.length;C++){this.expandPath(A[C]);}}if(E){D=D||this;B=B||[];this.root.on("load",function(){Ext.callback(E,D,B);},D);}return true;},removeChildren:function(A){while(A.firstChild){var B=A.firstChild;A.removeChild(B);B.destroy();}},loadRemoteData:function(A){this.removeChildren(this.getRootNode());for(var B in A){if(typeof A[B]==="object"){this.getRootNode().appendChild(A[B]);}}},reloadNode:function(A){this.getLoader().load(A);A.expand();},remove:function(F,D,A){var C=this.cm.activeNode;var G=this._extractId(C.id,D,A);var E={action:"remove"};var B=this.config.primaryKey||"id";E[B]=G;MODx.msg.confirm({title:_("warning"),text:_(F),url:this.config.url,params:E,listeners:{"success":{fn:this.refresh,scope:this}}});},_extractId:function(C,B,A){B=B||false;A=A||false;if(B!==false){C=node.id.substr(B);}if(A!==false){C=node.id.split("_");C=C[A];}return C;},expandNodes:function(){if(this.root){this.root.expand();this.root.expandChildNodes(true);}},collapseNodes:function(){if(this.root){this.root.collapseChildNodes(true);this.root.collapse();}},_saveState:function(F){var C=Ext.state.Manager.get(this.treestate_id);var E=F.getPath();var A;if(!Ext.isObject(C)&&!Ext.isArray(C)){C=[C];}if(Ext.isEmpty(E)||E==undefined){return ;}if(F.expanded){if(Ext.isString(E)&&C.indexOf(E)===-1){var D=false;var B;for(A=0;A<C.length;A++){if(C[A]==undefined||C[A]=="undefined"){C.splice(A,1);continue;}B=C[A].search(E);if(B!==-1&&C[B]){if(C[B].length>C[A].length){D=true;}}}if(!D){C.push(E);}}}else{C=C.remove(E);for(A=0;A<C.length;A++){if(C[A]==undefined||C[A]=="undefined"){C.splice(A,1);continue;}if(C[A].search(E)!==-1){delete C[A];}}}for(A=0;A<C.length;A++){if(C[A]==undefined||C[A]=="undefined"){C.splice(A,1);continue;}}Ext.state.Manager.set(this.treestate_id,C);},_handleClick:function(B,A){A.stopEvent();A.preventDefault();if(this.disableHref){return true;}if(A.ctrlKey){return true;}if(B.attributes.page&&B.attributes.page!==""){location.href=B.attributes.page;}return true;},encode:function(B){if(!B){B=this.getRootNode();}var C=function(G){var D={};var E=G.childNodes;for(var F=0;F<E.length;F=F+1){var H=E[F];D[H.id]={id:H.id,checked:H.ui.isChecked(),type:H.attributes.type||"",data:H.attributes.data||{},children:C(H)};}return D;};var A=C(B);return Ext.encode(A);},_handleDrag:function(A){function C(H){var E={};var F=H.childNodes;var D=F.length;for(var G=0;G<D;G++){E[F[G].id]=C(F[G]);}return E;}var B=Ext.encode(C(A.tree.root));this.fireEvent("beforeSort",B);MODx.Ajax.request({url:this.config.url,params:{data:encodeURIComponent(B),action:this.config.sortAction||"sort"},listeners:{"success":{fn:function(E){var D=A.dropNode.getUI().getTextEl();if(D){Ext.get(D).frame();}this.fireEvent("afterSort",{event:A,result:E});},scope:this},"failure":{fn:function(D){MODx.form.Handler.errorJSON(D);return false;},scope:this}}});},_handleDrop:function(){},_guid:function(A){return A+(new Date().getTime());},redirect:function(A){location.href=A;},loadAction:function(B){var C=this.cm.activeNode.id.split("_");C=C[1];var A="index.php?id="+C+"&"+B;location.href=A;},_loadToolbar:function(){},refreshNode:function(E,B){var C=this.getNodeById(E);if(C){var D=B?C:C.parentNode;var A=this.getLoader().load(D,function(){D.expand();},this);}},refreshActiveNode:function(){this.getLoader().load(this.cm.activeNode,this.cm.activeNode.expand);},refreshParentNode:function(){this.getLoader().load(this.cm.activeNode.parentNode,this.cm.activeNode.expand);},removeNode:function(B){var A=this.getNodeById(B);if(A){A.remove();}},removeActiveNode:function(){this.cm.activeNode.remove();},getToolbar:function(){var A=MODx.config.template_url+"images/restyle/icons/";return[{icon:A+"arrow_down.png",cls:"x-btn-icon",tooltip:{text:_("tree_expand")},handler:this.expandNodes,scope:this},{icon:A+"arrow_up.png",cls:"x-btn-icon",tooltip:{text:_("tree_collapse")},handler:this.collapseNodes,scope:this},"-",{icon:A+"refresh.png",cls:"x-btn-icon",tooltip:{text:_("tree_refresh")},handler:this.refresh,scope:this}];},_formatToolbar:function(a){var l=a.length;for(var i=0;i<l;i++){if(a[i].handler){a[i].handler=eval(a[i].handler);}Ext.applyIf(a[i],{scope:this,cls:"x-btn-icon"});}return a;}});Ext.reg("modx-tree",MODx.tree.Tree);
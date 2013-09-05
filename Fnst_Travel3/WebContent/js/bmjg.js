/*
 * 报名结果js
 * @author JianLeiXing
 * @Datetime 2012-08-04
 * @Class 
 * */
Ext.onReady(function(){
	var NRoot = new  Ext.tree.AsyncTreeNode({
	    text:'线路',
	    children:[
	         {text:'西安',leaf:true},
	         {text:'南京',leaf:true},
	         {text:'北京',leaf:true},
	         {text:'杭州',leaf:true},
	         {text:'武汉',leaf:true},
	         {text:'上海',leaf:true}
	    ]
   });

	var WRoot = new  Ext.tree.AsyncTreeNode({
		    text:'线路',
		    children:[
		         {text:'东京',leaf:true},
		         {text:'巴黎',leaf:true},
		         {text:'伦敦',leaf:true},
		         {text:'洛杉矶',leaf:true},
		         {text:'迈阿密',leaf:true},
		         {text:'华盛顿',leaf:true}
		    ]
	});
	
	var nTreePanel = new Ext.tree.TreePanel({
	            title:'5月份报名结果查询',
		        xtype:'treepanel',
		        root: NRoot,
		        rootVisible:false,
		        //autoHeight:true,
		        autoScroll:true,
		        border:false
	});
	var wTreePanel = new Ext.tree.TreePanel({
	             title:'8月份报名结果查询',
	             autoScroll:true,
	             root:WRoot,
	             rootVisible:false,
	             //autoHeight:true,
	             xtype:'treepanel',
	             border:false
	});

	nTreePanel.on("click",function(node){
	     Ext.Msg.alert("",node.id);
	 });
	
	
	var westPane = new Ext.Panel({
        title:'历史查询',
        //split:true,
        //autoHeight:true,
        height:430,
        frame:false,
        margins:'0 0 5 5',
        cmargins:'0 5 5 5',
        layoutConfig:{
            animate:true
         },
        layout:'accordion',
        items: [nTreePanel,wTreePanel]
	});
	
	var centerPane = new Ext.grid.GridPanel({
		//autoWidth:true,
		autoHeight:true,
		border:false,
		frame:false,
		columnLines:true,
		selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
		viewConfig:{forceFit:true},
		store : new Ext.data.SimpleStore({data:data=[ [1, '张三', '台湾','134567890'],
		                                              [2, '李四', '三峡','134567890'],
		                                              [3, '王五', '西安','134567890'],
		                                              [4, '马六', '南京','134567890'] 
		                                            ],
			                                        fields:["id","name","organization","homepage"]}),
		colModel : new Ext.grid.ColumnModel({
			defaults:{width:80, sortable:true},
			columns:[
	  		new Ext.grid.RowNumberer(),
			{header: 'ID', dataIndex: 'id',hidden:true},
			{header:'姓名', sortable:true, dataIndex:'name'
			},
			{header:'线路', sortable:true, dataIndex:'organization'
			},
			{header:'备注', sortable:true, dataIndex:'homepage'}
		 ]})
	});
	westPane.render("westjg");
	centerPane.render("centerjg");
});

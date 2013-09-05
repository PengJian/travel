/*
 * 报名统计js
 * @author JianLeiXing
 * @Datetime 2012-08-04
 * @Class 
 * */
Ext.namespace("ITSUS.fnst.front");
Ext.onReady(function(){
	ITSUS.fnst.front.tongji = new Ext.Panel({
//		autoHeight:true,
		height:350,
		items:[{
			url: 'extjs3.0/resources/charts.swf',  
			xtype:'columnchart',
			frame:true,
			store:new Ext.data.JsonStore({
				    fields:['name','sales','views'],
				    data:[
				     {name:'厦门',sales:100000,views:100},
				     {name:'大连',sales:150000,views:100},
				     {name:'三峡',sales:160000,views:100},
				     {name:'海南',sales:140000,views:100},
				     {name:'泰国',sales:170000,views:100},
				     {name:'台湾',sales:146000,views:100},
				     {name:'新加坡',sales:150000,views:100},
				     {name:'香港',sales:155000,views:10}
				    ]
				}),
			xField:'name',
			yField:'sales'
		}]
	});

	ITSUS.fnst.front.tongji.render("tongji");
});

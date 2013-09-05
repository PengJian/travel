package com.fnst.travel.util;

public class SystemContext
{
   private static ThreadLocal<Integer> offset=new ThreadLocal<Integer>();
   private static ThreadLocal<Integer> pageSize=new ThreadLocal<Integer>();
   
   public static int getOffset()
   {
	   Integer os=offset.get();
	   if(os==null)
		   return 0;
	   return os.intValue();
   }
   
   public static void setOffset(int offsetValue)
   {
	   offset.set(offsetValue);
   }
   
   public static void removeOffset()
   {
	   offset.remove();
   }
   
   public static int getPageSize()
   {
	   Integer ps=pageSize.get();
	   if(null==ps)
		   return Integer.MAX_VALUE;
	   return ps.intValue();
   }
   
   public static void setPageSize(int pageSizeValue)
   {
	   pageSize.set(pageSizeValue);
   }
   
   public static void removePageSize()
   {
	   pageSize.remove();
   }
}


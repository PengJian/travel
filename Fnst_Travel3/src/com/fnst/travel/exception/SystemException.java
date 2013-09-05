package com.fnst.travel.exception;

@SuppressWarnings("serial")
public class SystemException extends RuntimeException
{
	    private String message;
	    
		public String getMessage()
		{
			return message;
		}
		public void setMessage(String message)
		{
			this.message = message;
		}
		public SystemException() {
			super();
		}
		public SystemException(String message) {
			super(message);
			this.message=message;
			
		}
}

/*******************************************************************************
* KindEditor - WYSIWYG HTML Editor for Internet
* Copyright (C) 2006-2011 kindsoft.net
*
* @author Roddy <luolonghao@gmail.com>
* @site http://www.kindsoft.net/
* @licence http://www.kindsoft.net/license.php
*******************************************************************************/

KindEditor.plugin('insertfile', function(K) {
	var self = this, name = 'insertfile',
		allowFileUpload = K.undef(self.allowFileUpload, false),
		allowFileManager = K.undef(self.allowFileManager, false),
		lang = self.lang(name + '.');	
	self.plugin.fileDialog = function(options) {
		var fileUrl = K.undef(options.fileUrl, 'http://'),
			clickFn = options.clickFn;
		var html = [
			'<div style="padding:10px 20px;">',
			'<div class="ke-dialog-row">',
			'<label for="keUrl" style="width:60px;">' + lang.url + '</label>',
			'<input type="file" id="keUrl" name="url" class="ke-input-text" style="width:160px;" /> &nbsp;',
			'</div>',
			'</form>',
			'</div>'
			].join('');
		
		
		var dialog = self.createDialog({
			name : name,
			width : 450,
			height : 180,
			title : self.lang(name),
			body : html,
			yesBtn : {
				name : self.lang('yes'),
				click : function(e) {
					var url = K.trim(urlBox.val());
				//		title = titleBox.val();
					if (url == 'http://' || K.invalidUrl(url)) {
						alert(self.lang('invalidUrl'));
						urlBox[0].focus();
						return;
					}
				//	if (K.trim(title) === '') {
				//		title = url;
				//	}
				//	clickFn.call(self, url, title);	
					
					handleFiles();
					clickFn.call(self, url, 'file');	
					$(".ke-dialog-default").remove();
					$(".ke-dialog-mask").remove();
					
				}
			}
		});
		
		function bufferToString(buf) {
		    var view = new Uint8Array(buf);
		    return Array.prototype.join.call(view,",");
		}
		
		function handleFiles(){
			var inputElement = document.getElementById("keUrl");
			var files = inputElement.files;
			file = files[0];
			if(file.size<1024*1024*10){
				var reader = new FileReader();
				reader.onload = function(evt) {
				//	server._send("SEND::stt,孙婷婷::"+userInfo+"::file::"+file.name+"::"+file.type+"::"+file.size);	
				//	server._send(evt.target.result);
					
				};
				reader.readAsArrayBuffer(file);
			}else {
				alert('请选择小于10M的文件');
				return;
			}
			
		};
		div = dialog.div;

		var urlBox = K('[name="url"]', div),
			titleBox = K('[name="title"]', div);

		if (allowFileUpload) {
			var uploadbutton = K.uploadbutton({
				button : K('.ke-upload-button', div)[0],
				fieldName : 'imgFile',
				url : K.addParam(uploadJson, 'dir=file'),
				afterUpload : function(data) {
					dialog.hideLoading();
					if (data.error === 0) {
						var url = K.formatUrl(data.url, 'absolute');
						urlBox.val(url);
						if (self.afterUpload) {
							self.afterUpload.call(self, url);
						}
						alert(self.lang('uploadSuccess'));
					} else {
						alert(data.message);
					}
				},
				afterError : function(html) {
					dialog.hideLoading();
					self.errorDialog(html);
				}
			});
			uploadbutton.fileBox.change(function(e) {
				dialog.showLoading(self.lang('uploadLoading'));
				uploadbutton.submit();
			});
		} else {
			K('.ke-upload-button', div).hide();
			urlBox.width(250);
		}
		if (allowFileManager) {
			viewServerBtn.click(function(e) {
				/*self.loadPlugin('filemanager', function() {
					self.plugin.filemanagerDialog({
						viewType : 'LIST',
						dirName : 'file',
						clickFn : function(url, title) {
							if (self.dialogs.length > 1) {
								K('[name="url"]', div).val(url);
								self.hideDialog();
							}
						}
					});
				});*/
			});
		} else {
		//	viewServerBtn.hide();
		}
		urlBox.val(fileUrl);
	//	titleBox.val(fileTitle);
		urlBox[0].focus();
		urlBox[0].select();
	};
	self.clickToolbar(name, function() {
		self.plugin.fileDialog({
			clickFn : function(url, title) {
				var html = '<a href="' + url + '" data-ke-src="' + url + '" target="_blank">' + title + '</a>';
				self.insertHtml(html).hideDialog().focus();
			}
		});
	});
});

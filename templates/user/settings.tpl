<!DOCTYPE html>
<html lang='zh'>
    <head>
    <meta charset="utf-8">
    <title>更新个人设置</title>
	<link rel="stylesheet" href="../../static/css/common.css" type="text/css" />
    </head>
    <body>
		<div class="container content">
			<div class="row">
				<div class="columns twelve">
					<h1 id="page-title"> 更新个人设置 </h1>
				</div>
			</div>
		</div>
		<form action="settings.php" enctype="multipart/form-data" id="edit_user" method="post">
			<div class="row">
				<div class="columns nine settings" id="profile-info">
					<fieldset class="content-container clearfix">
						<div>
							<input type="hidden" id="user_id" name="user_id" value="{$user.id}" />
						<div>
						<div class="field profile-pic">
							<label for="user_picture">Picture</label>
							<div class="row">
								<div class="columns two">
									<div class="user-icon large">
									<img alt="Default-user-icon" src="//s3.amazonaws.com/lu-production-assets/images/default-user-icon.png">
								</div>
							</div>
							<div class="columns six">
								<div class="profile-pic-upload">
								<input id="user_picture" name="user_picture" type="file" accept="image/*">
								</div>
							</div>



							</div>
							</div>
							</div>
						
						
					</fieldset>
				</div>
			</div>
		</form>
        <script src="/static/js/jquery.js"></script>
        <script src="/static/js/common.js"></script>
        <script>
        $(function() {
            $(".field").change(function() {
                var field_name = $(this).attr('name');
                var field_value = $(this).val();
                $.ajax({
                    type:"POST",
                    url :"/user/settings.php",
                    data:   {
                        'field_name'  : field_name,
                        'field_value' : field_value,
                        'user_email'  : $('#user_email').val(),
                    },
                    dataType: "json",
                    timeout:120000, // 2min
                    success: function (obj) {
                        if(obj.errCode == 0 ){
                            toast("更新成功");
                        }else{
                            toast_err("出错["+ obj.errCode +"]: " + obj.errMsg);
                        }
                    },
                    error: function () {
                        toast_err("提交失败");
                    },
                });
            });
            $("#user_is_veteran").change(function() {
                if ($(this).val() == 1) {
                    $(this).val("0");
                } else {
                    $(this).val("1");
                }
                $.ajax({
                    type:"POST",
                    url :"/user/settings.php",
                    data:   {
                        'field_name'  : "user_is_veteran",
                        'field_value' : $("#user_is_veteran").val(),
                        'user_email'  : $('#user_email').val(),
                    },
                    dataType: "json",
                    timeout:120000, // 2min
                    success: function (obj) {
                        if(obj.errCode == 0 ){
                            toast("更新成功");
                        }else{
                            toast_err("出错["+ obj.errCode +"]: " + obj.errMsg);
                        }
                    },
                    error: function () {
                        toast_err("提交失败");
                    },
                });
            });
        });
        </script>
    </body>
</html>

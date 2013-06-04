<!DOCTYPE html>
<html lang='zh'>
    <head>
    <meta charset="utf-8">
    <title>更新个人设置</title>
	<link rel="stylesheet" href="../../static/css/common.css" type="text/css" />
    </head>
    <body id="user-settings">
		<div class="container content">
			<div class="row">
				<div class="columns twelve">
					<h1 id="page-title"> 更新个人设置 </h1>
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
										<a href="#" class="button white medium radius upload-button">Upload a picture</a>
										<div class="profile-pic-file-field">
											<input id="user_picture" name="user_picture" type="file" accept="image/*">
										</div>
										</div>
									</div>
								</div>
							</div>
							<div class="field nick">
								<label for="user_nick_name">昵称</label>
								<input id="user_nick_name" name="user_nick_name" value="{$user.nick_name}" size="30" type="text">
							</div>
							<div class="field name">
								<label for="user_real_name">真实姓名</label>
								<input id="user_real_name" name="user_real_name" value="{$user.real_name}" size="30" type="text">
							</div>
							<div class="field mobile">
								<label for="user_mobile">手机</label>
								<input id="user_mobile" name="user_mobile" value="{$user.mobile}" size="30" type="text">
							</div>
							<div class="field email">
								<label for="user_email">邮箱</label>
								<input id="user_email" name="user_email" value="{$user.email}" size="30" type="text">
								<a href="#">修改密码</a>
							</div>
							<div class="field zipcode">
								<label for="user_zipcode">邮政编码</label>
								<input id="user_zipcode" name="user_zipcode" value="{$user.zipcode}" size="30" type="text">
							</div>
							<div class="field profile-pic">
								<label for="user_resume">简历</label>
								<div class="profile-pic-upload">
									<a href="#" class="button white medium radius upload-button">Upload a resume</a>
									<div class="profile-pic-file-field">
										<input id="user_picture" name="user_picture" type="file"">
									</div>
									<div style="display:block;font-size:12.em;color:#666;">
										<input id="user_is_veteran" name="user_is_veteran" type="checkbox" value="{$user.is_veteran}"
										{if $user.is_veteran}
											checked
										{/if} style="width:2em;"/>
										<span>我是有经验的老手</span>
									</div>
								</div>
							</div>
							<div class="field">
								<label for="user_description">个人简介</label>
								<div class="field-container">
									<textarea cols="40" rows="5" id="user_description" name="user_description">{$user.description}</textarea>
								</div>
							</div>
							<div class="field">
								<label>空闲时间</label>
								<table id="availability">
									<thead>
										<tr>
											<th>周日</th>
											<th>周一</th>
											<th>周二</th>
											<th>周三</th>
											<th>周四</th>
											<th>周五</th>
											<th>周六</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>
											<input style="width:14px;height:14px;" type="checkbox" id="user_morning_sun" name="user[morning][sun]" />
											</td>
											<td>
											<input style="width:14px;height:14px;" type="checkbox" id="user_morning_mon" name="user[morning][mon]" />
											</td>
											<td>
											<input style="width:14px;height:14px;" type="checkbox" id="user_morning_tue" name="user[morning][tue]" />
											</td>
											<td>
											<input style="width:14px;height:14px;" type="checkbox" id="user_morning_wed" name="user[morning][wed]" />
											</td>
											<td>
											<input style="width:14px;height:14px;" type="checkbox" id="user_morning_thu" name="user[morning][thu]" />
											</td>
											<td>
											<input style="width:14px;height:14px;" type="checkbox" id="user_morning_fri" name="user[morning][fri]" />
											</td>
											<td>
											<input style="width:14px;height:14px;" type="checkbox" id="user_morning_sat" name="user[morning][sat]" />
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</fieldset>
					</div>
				</div>
				<div class="row">
					<div class="columns nine settings">
						<div class="action">
							<input class="button radius large" name="commit" type="submit" value="更新" />
						</div>
					</div>
				</div>
			</form>
		</div>
		<div id="page-footer">
			<div class="container">
				
			</div>
		</div>
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

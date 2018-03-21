<?= $header, $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-category" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary">
					<i class="fa fa-save"></i>
				</button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default">
					<i class="fa fa-reply"></i>
				</a>
			</div>
			<h1>
				<?= $heading_title; ?>
			</h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <li>
                        <a href="<?php echo $breadcrumb['href']; ?>">
                            <?php echo $breadcrumb['text']; ?>
						</a>
					</li>
				<?php } ?>
			</ul>
		</div>
	</div>
	
	<div class="container-fluid">
		<?php if ($warning) { ?>
            <div class="alert alert-danger">
                <i class="fa fa-exclamation-circle"></i>
                <?php echo $warning; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
		<?php } ?>
		
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<i class="fa fa-pencil"></i>
					<?php echo $text_form; ?>
				</h3>
			</div>
			<div class="panel-body">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-category" class="form-horizontal">
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="input-title">
							<?php echo $field_title; ?>
						</label>
						<div class="col-sm-10">
							<input type="text" name="title" value="<?php echo $title; ?>" placeholder="<?php echo $field_title; ?>" id="input-title"
							class="form-control" />
							<?php if($error_title) { ?>
                                <div class="text-danger">
                                    <?= $error_title; ?>
								</div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-status">
							<?php echo $field_status; ?>
						</label>
						<div class="col-sm-10">
							<select name="status" id="input-status" class="form-control">
								<?php if ($status) { ?>
                                    <option value="1" selected="selected">
                                        <?php echo $text_enabled; ?>
									</option>
                                    <option value="0">
                                        <?php echo $text_disabled; ?>
									</option>
                                    <?php } else { ?>
                                    <option value="1">
                                        <?php echo $text_enabled; ?>
									</option>
                                    <option value="0" selected="selected">
                                        <?php echo $text_disabled; ?>
									</option>
								<?php } ?>
							</select>
						</div>
					</div>
					
					<div class="form-group">
						
						<div class="col-xs-6 col-sm-5 col-md-3">
							<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
								<?php $i=0; foreach($menu_options as $type => $menu_option) { ?>
                                    <div class="panel panel-default">
                                        <div class="panel-heading" role="tab" id="heading<?= $i; ?>">
                                            <h4 class="panel-title">
                                                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<?= $i; ?>" aria-expanded="true" aria-controls="collapse<?= $i; ?>">
                                                    <?= $type; ?>
												</a>
											</h4>
										</div>
                                        <div id="collapse<?= $i; ?>" class="panel-collapse collapse <?php if(!$i) echo 'in'; ?>" role="tabpanel" aria-labelledby="heading<?= $i; ?>">
                                            <div class="panel-body">
                                                <div class="list">
                                                    <?php foreach($menu_option as $index => $list){ ?>
														<label>
															<input type="checkbox" data-route="<?= $list['route']; ?>" data-query="<?= $list['query']; ?>" data-indent="<?= $list['indent']; ?>" />
															<?= $list['name']; ?>
														</label>
														<br/>
													<?php } ?>
												</div>
                                                <hr/>
                                                <a class="btn btn-primary btn-menu">Add to Menu</a>
											</div>
										</div>
									</div>
								<?php $i++; } ?>
							</div>
						</div>
						
						<div class="col-xs-6 col-sm-7 col-md-9">
							<div class="panel panel-default">
								<div class="panel-heading">
									<h4 class="panel-title">Menu Structure</h4>
								</div>
								<div class="panel-body menuDrag-body">
									<p>Drag each item into the order you prefer.</p>
									<div class="menuDrag parent" data-nesting="0" >									
										<?php foreach($menus as $index => $menu){ ?>
                                            <div class="dragable drag-container <?= $menu['class']; ?>" >												
                                                <div class="removeBtn" onclick="$(this).parent().remove();">
                                                    <i class="fa fa-times-circle-o" aria-hidden="true"></i>
												</div>
                                                <div>
                                                    <?= $menu['title']; ?>
												</div>
                                                <input type="hidden" name="menus[route][]" value="<?= $menu['route']; ?>" readonly />
                                                <input type="hidden" name="menus[query][]" value="<?= $menu['query']; ?>" readonly />
                                                <input type="hidden" name="menus[indent][]" value="<?= $menu['indent']; ?>" readonly />
												<!-- <div class='menuDrag' data-nesting="1" ></div> -->
											</div>
										<?php } ?>
									</div>
								</div>
							</div>
						</div>
						
					</div>
					
				</form>
			</div>
			
			
		</div>
		
	</div>
</div>
<style>
	
	.btn-group.left{
	margin-right: 12px;
	}
	
	#accordion .panel-body .list {
	max-height: 300px;
	overflow: auto;
	}
	
	#accordion h4 a {
	margin: -10px -15px;
	padding: 10px 15px;
	width: 100%;
	display: block;
	}
	
	#accordion input {
	position: relative;
	margin-right: 3px;
	top: 2px
	}
	
	#accordion label {
	cursor: pointer;
	width: 100%;
	padding: 2px;
	}
	
	#accordion hr {
	margin: 10px 0px;
	}
	
	.btn-menu {
	cursor: pointer;
	}
	
	.menuDrag-body {
	position: relative;
	overflow: auto;
	}
	
	.drag-container.second { 
		width: 280px;
	}
	.drag-container {
	cursor: all-scroll;
	display: table;
	width: 1px;
	border: 1px solid #A4AE3B;
	padding: 6px 8px 6px 14px;
	white-space: nowrap;
	font-size: 14px;
	width: 300px;
	background: #fff;
	border-left-width: 7px !important;
	position: relative;
	
	}
	
	.second {border: 1px solid #02779C; margin-left: 20px;}
	.third {border: 1px solid #3A1D3C;}
	.forth {border: 1px solid #880F20;}
	.fifth {border: 1px solid #C13A27;}
	.sixth {border: 1px solid #D78C27;}
	
	.drag-container+.drag-container {
	margin-top: 8px;
	}
	
	.drag-container .removeBtn {
	float: right;
	cursor: pointer;
	font-size: 24px;
	line-height: 24px;
	color: rgb(119, 34, 34);
	}
	
	.drag-container>div {
	display: inline-block;
	vertical-align: middle;
	}
	
	.drag-container.ui-sortable-placeholder {
	background: #f1f1f1 !important;
	visibility: visible !important;
	border: 0px !important;
	}
	
	.menuDrag.parent {
	margin-bottom: 30px;
	}
	
	.menuDrag.parent .menuDrag {  
	padding: 3px;
	border: 1px dashed #ccc;
	min-width: 100%;
	display: table;
	margin-top: 12px;
	min-height: 30px;
	position: relative;
	}
	
	.menuDrag.parent .menuDrag::before{
	content: 'Sub-menu Area';
	font-size: 13px;
	display: block;
	position: absolute;
	color: #a1a1a1;
	top: 4px;
	left: 3px; 
	z-index: 0;
	}
</style>
<script type="text/javascript">
	listenSortable();
	
	$(".btn-menu").click(function (e) {
		e.preventDefault();
		
		$("#accordion input[type='checkbox']:checked").each(function () {
			var removeBtn =
			'<div class="removeBtn" onclick="$(this).parent().remove();" ><i class="fa fa-times-circle-o" aria-hidden="true"></i></div>';
			var dragableHtml =
			"<div class='dragable drag-container first'>dynamic <div class='menuDrag' data-nesting='1' ></div> </div>";
			var div = "<div>dynamic</div>";
			var inputHtml = "<input type='hidden' name='menus[dynamic][]' value='' />";
			var input = $(this);
			
			label = insert(div, input.parent().text());
			route = insert(inputHtml, input.data('route'), 'route');
			query = insert(inputHtml, input.data('query'), 'query'); 
			indent = insert(inputHtml, 0, 'indent');
			
			var html = insert(dragableHtml, removeBtn + label + route + query + indent);
			
			$(".menuDrag.parent").append(html);
			
			input.prop('checked', false);
		});
		
		listenSortable();
	});
	
	var insert = function (format, replace, name) {
		if (format && replace) {
			if (name) {
				return format.replace('dynamic', name).replace('dynamic', replace);
			}
			return format.replace('dynamic', replace);
		}
		
		return '';
	};
	
	var indent = 20;
	
	function listenSortable() {
		$(function () {
			$(".menuDrag").sortable({
				scroll: false,				
				connectWith: ".menuDrag",
				sort: function(event, ui){ 
					if(ui.offset.left > indent && ui.helper.prev().hasClass("first")){
						var pos;
						if(ui.helper.hasClass('second')){
							pos = ui.position.left+20; 
							$('#cursor').text(ui.position.left+20);
						}
						else{
							pos = ui.position.left; 
							$('#cursor').text(ui.position.left);  
						}
						
						if(pos >= 32 && !ui.helper.hasClass('second')){
							ui.placeholder.removeClass('placeholder');
							ui.placeholder.addClass('placeholder-sub');
							ui.helper.addClass('second');
							
							ui.helper.find("input[name='menus[indent][]']").val(1);
						}
						else if(pos < 25 && ui.helper.hasClass('second')){
							ui.placeholder.removeClass('placeholder-sub');
							ui.placeholder.addClass('placeholder');
							ui.helper.removeClass('second');
							
							ui.helper.find("input[name='menus[indent][]']").val(0);
						}
						
					}
				}
			});
			
			$(".menuDrag").disableSelection();
		});
	}
</script>
<?= $footer; ?>
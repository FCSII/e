<?= $header; ?>
<div class="container">
	<ul class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<li><a href="<?= $breadcrumb['href']; ?>"><?= $breadcrumb['text']; ?></a></li>
		<?php } ?>
	</ul>
	<div class="row"><?= $column_left; ?>
		<?php if ($column_left && $column_right) { ?>
			<?php $class = 'col-sm-6'; ?>
			<?php } elseif ($column_left || $column_right) { ?>
			<?php $class = 'col-sm-9'; ?>
			<?php } else { ?>
			<?php $class = 'col-sm-12'; ?>
		<?php } ?>
		<div id="content" class="<?= $class; ?>"><?= $content_top; ?>
			<h1><?= $heading_title; ?></h1>
			<h3><?= $text_location; ?></h3>
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row">
						<div class="col-xs-12">
						<?php if ($geocode || $google_map) { ?>
							<div data-id="gmap_contact" data-toggle="gmap" class="gmap"
								<?php if($google_map){ ?>
									data-lat="<?= $google_map['lat']; ?>" 
									data-lng="<?= $google_map['lng']; ?>" 
									data-store="<?= $google_map['store']; ?>" 
									data-address="<?= $google_map['address']; ?>" 
								<?php } ?>
								data-geo="<?= $geocode; ?>"
							>
								<div id="gmap_contact"></div>
							</div>
						<?php } ?>
						</div>
						<div class="col-sm-3"><strong><?= $store; ?></strong><br />
							<address>
								<?= $address; ?>
							</address>
						</div>
						<div class="col-sm-3"><strong><?= $text_telephone; ?></strong><br>
							<?= $telephone; ?><br />
							<br />
							<?php if ($fax) { ?>
								<strong><?= $text_fax; ?></strong><br>
								<?= $fax; ?>
							<?php } ?>
						</div>
						<div class="col-sm-3">
							<?php if ($open) { ?>
								<strong><?= $text_open; ?></strong><br />
								<?= $open; ?><br />
								<br />
							<?php } ?>
							<?php if ($comment) { ?>
								<strong><?= $text_comment; ?></strong><br />
								<?= $comment; ?>
							<?php } ?>
						</div>
					</div>
				</div>
			</div>
			<?php if ($locations) { ?>
				<h3><?= $text_store; ?></h3>
				<div class="panel-group" id="accordion">
					<?php foreach ($locations as $index => $location) { ?>
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">
									<a href="#collapse-location<?= $location['location_id']; ?>" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" >
										<?= $location['name']; ?> <i class="fa fa-caret-down"></i>
									</a>
								</h4>
							</div>
							<div class="panel-collapse collapse" id="collapse-location<?= $location['location_id']; ?>" >
								<div class="panel-body">
									<div class="row">
										    <?php if ($location['geocode'] || $location['google_map']) { ?> 
												<div class="col-sm-12">
													<div data-id="gmap<?= $index; ?>" data-toggle="gmap" class="gmap"
														<?php if($location['google_map']){ ?>
															data-lat="<?= $location['google_map']['lat']; ?>" 
															data-lng="<?= $location['google_map']['lng']; ?>" 
															data-store="<?= $location['google_map']['store']; ?>" 
															data-address="<?= $location['google_map']['address']; ?>" 
														<?php } ?>
													>
													<div id="gmap<?= $index; ?>" ></div>
													</div>
												</div>
											<?php } ?>
										
										<?php if ($location['image']) { ?>
											<div class="col-sm-3"><img src="<?= $location['image']; ?>" alt="<?= $location['name']; ?>" title="<?= $location['name']; ?>" class="img-thumbnail" /></div>
										<?php } ?>
										<div class="col-sm-3"><strong><?= $location['name']; ?></strong><br />
											<address>
												<?= $location['address']; ?>
											</address>
											<?php if ($location['geocode']) { ?>
												<a href="https://maps.google.com/maps?q=<?= urlencode($location['geocode']); ?>&hl=<?= $geocode_hl; ?>&t=m&z=15" target="_blank" class="btn btn-info"><i class="fa fa-map-marker"></i> <?= $button_map; ?></a>
											<?php } ?>
										</div>
										<div class="col-sm-3"> <strong><?= $text_telephone; ?></strong><br>
											<?= $location['telephone']; ?><br />
											<br />
											<?php if ($location['fax']) { ?>
												<strong><?= $text_fax; ?></strong><br>
												<?= $location['fax']; ?>
											<?php } ?>
										</div>
										<div class="col-sm-3">
											<?php if ($location['open']) { ?>
												<strong><?= $text_open; ?></strong><br />
												<?= $location['open']; ?><br />
												<br />
											<?php } ?>
											<?php if ($location['comment']) { ?>
												<strong><?= $text_comment; ?></strong><br />
												<?= $location['comment']; ?>
											<?php } ?>
										</div>
									</div>
								</div>
							</div>
						</div>
					<?php } ?>
				</div>
				
			<?php } ?>
			<form action="<?= $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
				<fieldset>
					<legend><?= $text_contact; ?></legend>
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="input-name"><?= $entry_name; ?></label>
						<div class="col-sm-10">
							<input type="text" name="name" value="<?= $name; ?>" id="input-name" class="form-control" />
							<?php if ($error_name) { ?>
								<div class="text-danger"><?= $error_name; ?></div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="input-email"><?= $entry_email; ?></label>
						<div class="col-sm-10">
							<input type="text" name="email" value="<?= $email; ?>" id="input-email" class="form-control" />
							<?php if ($error_email) { ?>
								<div class="text-danger"><?= $error_email; ?></div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="input-enquiry"><?= $entry_enquiry; ?></label>
						<div class="col-sm-10">
							<textarea name="enquiry" rows="10" id="input-enquiry" class="form-control"><?= $enquiry; ?></textarea>
							<?php if ($error_enquiry) { ?>
								<div class="text-danger"><?= $error_enquiry; ?></div>
							<?php } ?>
						</div>
					</div>
					<?= $captcha; ?>
				</fieldset>
				<div class="buttons">
					<div class="pull-right">
						<input class="btn btn-primary" type="submit" value="<?= $button_submit; ?>" />
					</div>
				</div>
			</form>
		<?= $content_bottom; ?></div>
	<?= $column_right; ?></div>
</div>
<?= $footer; ?>

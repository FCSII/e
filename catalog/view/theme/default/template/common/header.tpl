<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?=$direction; ?>" lang="<?=$lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?=$direction; ?>" lang="<?=$lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?=$direction; ?>" lang="<?=$lang; ?>">
<!--<![endif]-->

<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title data-min-length="60" data-max-length="70">
		<?=$title; ?>
	</title>
	<base href="<?=$base; ?>" />
	<?php if(isset($extra_tags)) { foreach($extra_tags as $extra_tag) { ?>
	<meta <?php echo ($extra_tag[ 'name']) ? 'name="' . $extra_tag[ 'name'] . '" ' : ''; ?>
	<?php echo (!in_array($extra_tag['property'], array("noprop", "noprop1", "noprop2", "noprop3", "noprop4"))) ? 'property="' . $extra_tag['property'] . '" ' : ''; ?> content="
	<?php echo addslashes($extra_tag['content']); ?>" />
	<?php } } ?>
	<?php if ($description) { ?>
	<meta name="description" content="<?=$description; ?>" data-max-length="155" />
	<?php } ?>
	<?php if ($keywords) { ?>
	<meta name="keywords" content="<?=$keywords; ?>" />
	<?php } ?>

	<!-- Schema.org markup for Google+ -->
	<meta itemprop="name" content="<?=$title; ?>" />
	<meta itemprop="description" content="<?=$description; ?>" />
	<meta itemprop="image" content="<?= $gp_img; ?>" />

	<!-- Twitter Card data -->
	<meta name="twitter:card" content="<?= $store_name; ?>" />
	<!-- <meta name="twitter:site" content="@publisher_handle"/> -->
	<meta name="twitter:title" content="<?=$title; ?>" />
	<meta name="twitter:description" content="<?=$description; ?>" data-length="200" />
	<!-- <meta name="twitter:creator" content="@author_handle"/> -->
	<!-- Twitter summary card with large image must be at least 280x150px -->
	<meta name="twitter:image:src" content="<?= $tw_img; ?>" />

	<!-- Open Graph data -->
	<meta property="og:title" content="<?=$title; ?>" />
	<meta property="og:type" content="<?= $content_type; ?>" />
	<meta property="og:url" content="<?= $current_page; ?>" />
	<meta property="og:image" content="<?= $fb_img; ?>" />
	<meta property="og:description" content="<?=$description; ?>" />
	<meta property="og:site_name" content="<?= $store_name; ?>" />
	<!-- <meta property="fb:admins" content="Facebook numberic ID" /> -->

	<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
	<link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
	<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="//fonts.googleapis.com/css?family=Open+Sans:400,400i,300,700" rel="stylesheet" type="text/css" />
	<link href="catalog/view/theme/default/stylesheet/stylesheet.css" rel="stylesheet">
	<link href="catalog/view/theme/default/stylesheet/alpha.min.css" rel="stylesheet">
	<link href="catalog/view/theme/default/stylesheet/helper.min.css" rel="stylesheet">
	<?php foreach ($styles as $style) { ?>
	<link href="<?=$style['href']; ?>" type="text/css" rel="<?=$style['rel']; ?>" media="<?=$style['media']; ?>" />
	<?php } ?>
	<script src="catalog/view/javascript/quantityincrementdecrement.js" type="text/javascript"></script>
	<script src="catalog/view/javascript/common.js" type="text/javascript"></script>
	<script src="catalog/view/javascript/alpha.js" type="text/javascript"></script>
	<?php foreach ($links as $link) { ?>
	<link href="<?=$link['href']; ?>" rel="<?=$link['rel']; ?>" />
	<?php } ?>
	<?php foreach ($scripts as $script => $defer) { ?>
	<script <?php if($defer){ ?>
		defer = "defer"
		<?php } ?>
		src = "<?=$script; ?>"
		type = "text/javascript" >
	</script>
	<?php } ?>
	<?php foreach ($analytics as $analytic) { ?>
	<?=$analytic; ?>
		<?php } ?>
</head>

<body class="<?=$class; ?>">
	<nav id="top">
		<div class="container">
			<?=$currency; ?>
				<?=$language; ?>
					<div id="top-links" class="nav pull-right">
						<ul class="list-inline">
							<li>
								<a href="<?=$contact; ?>">
									<i class="fa fa-phone"></i>
								</a>
								<span class="hidden-xs hidden-sm hidden-md">
									<?=$telephone; ?>
								</span>
							</li>

							<?php if ($logged) { ?>
							<li class="dropdown">
								<a href="<?=$account; ?>" title="<?=$text_account; ?>" class="dropdown-toggle" data-toggle="dropdown">
									<i class="fa fa-user"></i>
									<span class="hidden-xs hidden-sm hidden-md">
										<?=$text_account; ?>
									</span>
									<span class="caret"></span>
								</a>
								<ul class="dropdown-menu dropdown-menu-right">
									<li>
										<a href="<?=$account; ?>">
											<?=$text_account; ?>
										</a>
									</li>
									<li>
										<a href="<?=$order; ?>">
											<?=$text_order; ?>
										</a>
									</li>
									<li>
										<a href="<?=$transaction; ?>">
											<?=$text_transaction; ?>
										</a>
									</li>
									<li>
										<a href="<?=$download; ?>">
											<?=$text_download; ?>
										</a>
									</li>
									<li>
										<a href="<?=$logout; ?>">
											<?=$text_logout; ?>
										</a>
									</li>
								</ul>
							</li>
							<?php }else { ?>
							<li class="quick-login">
								<a class="quick_signup">
									<i class="fa fa-user"></i>
									<span class="hidden-xs hidden-sm hidden-md">
										<?=$signin_or_register ?>
									</span>
								</a>
							</li>
							<?php } ?>
							<li>
								<a href="<?=$wishlist; ?>" id="wishlist-total" title="<?=$text_wishlist; ?>">
									<i class="fa fa-heart"></i>
									<span class="hidden-xs hidden-sm hidden-md">
										<?=$text_wishlist; ?>
									</span>
								</a>
							</li>
							<li>
								<a href="<?=$shopping_cart; ?>" title="<?=$text_shopping_cart; ?>">
									<i class="fa fa-shopping-cart"></i>
									<span class="hidden-xs hidden-sm hidden-md">
										<?=$text_shopping_cart; ?>
									</span>
								</a>
							</li>
							<li>
								<a href="<?=$checkout; ?>" title="<?=$text_checkout; ?>">
									<i class="fa fa-share"></i>
									<span class="hidden-xs hidden-sm hidden-md">
										<?=$text_checkout; ?>
									</span>
								</a>
							</li>
						</ul>
					</div>
		</div>
	</nav>
	<header>
		<div class="container">
			<div class="row">
				<div class="col-sm-4">
					<div id="logo">
						<?php if ($logo) { ?>
						<a href="<?=$home; ?>">
							<img src="<?=$logo; ?>" title="<?=$name; ?>" alt="<?=$name; ?>" class="img-responsive" />
						</a>
						<?php } else { ?>
						<h1>
							<a href="<?=$home; ?>">
								<?=$name; ?>
							</a>
						</h1>
						<?php } ?>
					</div>
				</div>
				<div class="col-sm-5">
					<?=$search; ?>
				</div>
				<div class="col-sm-3">
					<?=$cart; ?>
				</div>
			</div>
		</div>
	</header>
	<?=$quicksignup; ?>
		<?php if ($menu) { ?>
		<div class="container">
			<nav id="menu" class="navbar">
				<div class="navbar-header">
					<span id="category" class="visible-xs">
						<?=$text_category; ?>
					</span>
					<button type="button" class="btn btn-navbar navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
						<i class="fa fa-bars"></i>
					</button>
				</div>
				<div class="collapse navbar-collapse navbar-ex1-collapse">
					<ul class="nav navbar-nav">
						<?php foreach ($menu as $each) { ?>
						<li>
							<a href="<?= $each['href']; ?>" class="<?= $each['active']; ?>" >
								<?= $each['name']; ?>
							</a>
						</li>
						<?php } ?>
					</ul>
				</div>
			</nav>
		</div>
		<?php } ?>
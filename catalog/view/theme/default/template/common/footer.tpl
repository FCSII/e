<footer>
	<div class="container">
		<div class="row">
			<?php if ($informations) { ?>
				<div class="col-sm-3">
					<h5><?= $text_information; ?></h5>
					<ul class="list-unstyled">
						<?php foreach ($informations as $information) { ?>
							<li><a href="<?= $information['href']; ?>"><?= $information['title']; ?></a></li>
						<?php } ?>
					</ul>
				</div>
			<?php } ?>
			<div class="col-sm-3">
				<h5><?= $text_service; ?></h5>
				<ul class="list-unstyled">
					<li><a href="<?= $contact; ?>"><?= $text_contact; ?></a></li>
					<li><a href="<?= $testimonial['href']; ?>"><?= $testimonial['title']; ?></a></li>
					<li><a href="<?= $return; ?>"><?= $text_return; ?></a></li>
					<li><a href="<?= $sitemap; ?>"><?= $text_sitemap; ?></a></li>
				</ul>
			</div>
			<div class="col-sm-3">
				<h5><?= $text_extra; ?></h5>
				<ul class="list-unstyled">
					<li><a href="<?= $manufacturer; ?>"><?= $text_manufacturer; ?></a></li>
					<li><a href="<?= $voucher; ?>"><?= $text_voucher; ?></a></li>
					<li><a href="<?= $affiliate; ?>"><?= $text_affiliate; ?></a></li>
					<li><a href="<?= $special; ?>"><?= $text_special; ?></a></li>
					<li><a href="<?php echo $blog_url; ?>"><?php echo $blog_name; ?></a></li>
				</ul>
			</div>
			<div class="col-sm-3">
				<h5><?= $text_account; ?></h5>
				<ul class="list-unstyled">
					<li><a href="<?= $account; ?>"><?= $text_account; ?></a></li>
					<li><a href="<?= $order; ?>"><?= $text_order; ?></a></li>
					<li><a href="<?= $wishlist; ?>"><?= $text_wishlist; ?></a></li>
					<li><a href="<?= $newsletter; ?>"><?= $text_newsletter; ?></a></li>
				</ul>
			</div>
		</div>
		<hr>
		
		
		<div class="row">
			<div class="col-xs-12 col-sm-6">
				<?= $powered; ?>
			</div>
			<div class="col-xs-12 col-sm-6 text-right-sm">
				<?= $text_fcs; ?>
			</div>
		</div>
		
		<p>&nbsp;</p>
	</div>
</footer>
<div id="ToTopHover" ></div>

<?php if ($live_search_ajax_status):?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/live_search.css" />
<script type="text/javascript"><!--
	var live_search = {
		selector: '#search input[name=\'search\']',
		text_no_matches: '<?= $text_empty; ?>',
		height: '<?= (int)$live_search_image_height + 10; ?>px'
	}
	
	$(document).ready(function() {
		var html = '';
		html += '<div class="live-search">';
		html += '	<ul>';
		html += '	</ul>';
		html += '<div class="result-text"></div>'; 
		html += '</div>';
		
		//$(live_search.selector).parent().closest('div').after(html);
		$(live_search.selector).after(html);
		
		$(live_search.selector).autocomplete({
			'source': function(request, response) { 
				var filter_name = $(live_search.selector).val();
				var live_search_min_length = '<?= (int)$live_search_min_length; ?>';
				if (filter_name.length < live_search_min_length) {
					$('.live-search').css('display','none');
				}
				else{
					var html = '';
					html += '<li style="text-align: center;height:10px;">';
					html +=	'<img class="loading" src="catalog/view/theme/default/image/loading.gif" />';
					html +=	'</li>';
					$('.live-search ul').html(html);
					$('.live-search').css('display','block');
					
					$.ajax({
						url: 'index.php?route=product/live_search&filter_name=' +  encodeURIComponent(filter_name),
						dataType: 'json',
						success: function(result) {
							var products = result.products;
							$('.live-search ul li').remove();
							$('.result-text').html('');
							if (!$.isEmptyObject(products)) {
								var show_image = <?= $live_search_show_image;?>;
								var show_price = <?= $live_search_show_price;?>;
								var show_description = <?= $live_search_show_description;?>;
								$('.result-text').html('<a href="<?= $live_search_href;?>'+filter_name+'" class="view-all-results"><?= $text_view_all_results;?> ('+result.total+')</a>');
								
								$.each(products, function(index,product) {
									var html = '';
									
									html += '<li>';
									html += '<a href="' + product.url + '" title="' + product.name + '">';
									if(product.image && show_image){
										html += '	<div class="product-image"><img alt="' + product.name + '" src="' + product.image + '"></div>';
									}
									html += '	<div class="product-name">' + product.name ;
									if(show_description){
										html += '<p>' + product.extra_info + '</p>';
									}
									html += '</div>';
									if(show_price){
										if (product.special) {
											html += '	<div class="product-price"><span class="special">' + product.price + '</span><span class="price">' + product.special + '</span></div>';
											} else {
											html += '	<div class="product-price"><span class="price">' + product.price + '</span></div>';
										}
									}
									html += '<span style="clear:both"></span>';
									html += '</a>';
									html += '</li>';
									$('.live-search ul').append(html);
								});
								} else {
								var html = '';
								html += '<li style="text-align: center;height:10px;">';
								html +=	live_search.text_no_matches;
								html +=	'</li>';
								
								$('.live-search ul').html(html);
							}
							$('.live-search ul li').css('height',live_search.height);
							$('.live-search').css('display','block');
							return false;
						}
					});
				}
			},
			'select': function(product) {
				$(live_search.selector).val(product.name);
			}
		});
		
		$(document).bind( "mouseup touchend", function(e){
			var container = $('.live-search');
			if (!container.is(e.target) && container.has(e.target).length === 0)
			{
				container.hide();
			}
		});
	});
//--></script>
<?php endif;?>
<?php echo $mailchimp_integration; ?>
</body></html>
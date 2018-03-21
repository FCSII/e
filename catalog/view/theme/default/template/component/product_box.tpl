<div class="product-layout col-lg-3 col-md-3 col-sm-6 col-xs-12">
    <div class="product-thumb transition">
        <div class="image">
            <a href="<?php echo $href; ?>">
                <img src="<?php echo $thumb; ?>" alt="<?php echo $name; ?>" title="<?php echo $name; ?>" class="img-responsive" />
			</a>
		</div>
        <div class="caption">
            <h4>
                <a href="<?php echo $href; ?>">
                    <?php echo $name; ?>
				</a>
			</h4>
            <p>
                <?php echo $description; ?> 
			</p>
            <?php if ($rating) { ?>
				<div class="rating">
					<?php for ($i = 1; $i <= 5; $i++) { ?>
						<?php if ($rating < $i) { ?>
							<span class="fa fa-stack">
								<i class="fa fa-star-o fa-stack-2x"></i>
							</span>
							<?php } else { ?>
							<span class="fa fa-stack">
								<i class="fa fa-star fa-stack-2x"></i>
								<i class="fa fa-star-o fa-stack-2x"></i>
							</span>
						<?php } ?>
					<?php } ?>
				</div>
			<?php } ?>
            <?php if ($price) { ?>
				<p class="price">
					<?php if (!$special) { ?>
						<?php echo $price; ?>
						<?php } else { ?>
						<span class="price-new">
							<?php echo $special; ?>
						</span>
						<span class="price-old">
							<?php echo $price; ?>
						</span>
					<?php } ?>
					<?php if ($tax) { ?>
						<span class="price-tax">
							<?php echo $text_tax; ?>
							<?php echo $tax; ?>
						</span>
					<?php } ?>
				</p>
			<?php } ?>
		</div>
		
		<?php if($quantityincrementdecrement_status){ ?>
		<div class="caption min-height-0" >
			<div class="input-group" style="margin-bottom:10px;">
				<span class="input-group-btn">
					<button type="button" class="btn btn-default btn-number" data-type="minus" data-field="qty-<?php echo $product_id; ?>" onclick="descrement($(this).parent().parent())")>
						<span class="glyphicon glyphicon-minus"></span>
					</button>
				</span>
				<input type="text" name="quantity" class="form-control input-number integer" id="qty-<?php echo $product_id; ?>" value="1">
				<span class="input-group-btn">
					<button type="button" class="btn btn-default btn-number" data-type="plus" data-field="qty-<?php echo $product_id; ?>" onclick="increment($(this).parent().parent())">
						<span class="glyphicon glyphicon-plus"></span>
					</button>
				</span>
			</div>
		</div>
		<?php } ?>
		
		<?php if($quantityincrementdecrement_status){ ?>
			<div class="button-group">
				<button type="button" onclick="cart.add('<?php echo $product_id; ?>', $('#qty-<?php echo $product_id; ?>').val());" >
					<i class="fa fa-shopping-cart"></i>
					<span class="hidden-xs hidden-sm hidden-md">
						<?php echo $button_cart; ?>
					</span>
				</button>
				<button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product_id; ?>');">
					<i class="fa fa-heart"></i>
				</button>
				<button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product_id; ?>');">
					<i class="fa fa-exchange"></i>
				</button>
			</div>
			<?php }else{ ?>
			<div class="button-group">
				<button type="button" onclick="cart.add('<?php echo $product_id; ?>');">
					<i class="fa fa-shopping-cart"></i>
					<span class="hidden-xs hidden-sm hidden-md">
						<?php echo $button_cart; ?>
					</span>
				</button>
				<button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product_id; ?>');">
					<i class="fa fa-heart"></i>
				</button>
				<button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product_id; ?>');">
					<i class="fa fa-exchange"></i>
				</button>
			</div>
		<?php } ?>
		
	</div>
</div>
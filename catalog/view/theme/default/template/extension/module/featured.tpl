<h3>
  <?php echo $heading_title; ?>
</h3>
<div class="row">
  <?php foreach ($products as $product) { ?>
    <?php echo html($product); ?>
  <?php } ?> 
</div>
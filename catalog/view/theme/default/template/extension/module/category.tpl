<div class="list-group">
  <?php foreach ($categories as $index=> $category) { ?>
  <div class="input-group">
    <a href="<?php echo $category['href']; ?>" class="level-1 list-group-item <?php echo $category['active']; ?>">
      <?php echo $category['name']; ?>
    </a>
    <?php if($category['children']){ ?>
    <button class="input-group-addon" id="child-<?php echo $category['category_id']; ?>" data-level="level-2" data-parent="level-1" ></button>
    <?php } ?>
  </div>

  <?php foreach ($category['children'] as $child_index=> $child) { ?>
  <div class="level-2 input-group list-child child-<?php echo $category['category_id']; ?> <?php echo $category['active']?'open':''; ?> ">
    <a href="<?php echo $child['href']; ?>" class="list-group-item item-child <?php echo $child['active']; ?>">&nbsp;&nbsp;&nbsp;-
      <?php echo $child['name']; ?>
    </a>
    <?php if($child['child']){ ?>
    <button class="input-group-addon" id="child-<?php echo $child['category_id']; ?>" data-level="level-3" data-parent="level-2" ></button>
    <?php } ?>
  </div>

  <?php foreach ($child['child'] as $grand_child) { ?>
  <div class="level-3 input-group list-grand-child  child-<?php echo $child['category_id']; ?> <?php echo $child['active']?'open':''; ?>">
    <a href="<?php echo $grand_child['href']; ?>" class="list-group-item item-grand-child <?php echo $grand_child['active']; ?>">&nbsp;&nbsp;&nbsp;-
      <?php echo $child['name']; ?>
    </a>
  </div>
  <?php } ?>

  <?php } ?>

  <?php } ?>
</div>
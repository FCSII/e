<div class="max-offset">
  <div id="slideshow<?= $module; ?>" class="owl-carousel" style="opacity: 1;">
    <?php foreach ($banners as $banner) { ?>
    <div class="item">
      <img src="<?= $banner['image']; ?>" alt="<?= $banner['title']; ?>" class="img-responsive hidden-xs" />
      <img src="<?= $banner['mobile_image']; ?>" alt="<?= $banner['title']; ?>" class="img-responsive visible-xs" />
      <div class="owl_description ">
        <div class="container <?= $banner['theme']; ?> <?= $banner['mobile_theme']; ?>">
          <div class="owl_title">
            <?= $banner['title']; ?>
          </div>
          <div class="owl_desc">
            <?= $banner['description']; ?>
            <?php if ($banner['link']) { ?>
              <a href="<?= $banner['link']; ?>">
                <?= $banner['link_text']; ?>
              </a>
            <?php } ?>
          </div>
        </div>
      </div>
    </div>
    <?php } ?>
  </div>
  
  <script type="text/javascript">
    <!--
      $('#slideshow<?= $module; ?>').owlCarousel({
        items: 1,
        loop: true,
        autoPlay: true,
        autoPlayTimeout: 3000,
        nav: false,
        //navText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],
        dots: false
      });
    -->
  </script>
</div>
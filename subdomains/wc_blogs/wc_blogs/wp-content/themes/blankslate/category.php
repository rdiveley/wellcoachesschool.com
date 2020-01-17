<?php get_header(); ?>

<section id="content" role="main">

  <header class="header">
    <h1 class="entry-title">
      <?php _e( 'Filtered by Category: ', 'blankslate' ); ?>
      <a class="filter" href=""><?php single_cat_title(); ?></a>
      <a class="showall" href="<?php echo esc_url( home_url( '/' ) ); ?>">Show All</a>
    </h1>
    
    <?php if ( '' != category_description() ) echo apply_filters( 'archive_meta', '<div class="archive-meta">' . category_description() . '</div>' ); ?>
  </header>
  
  <?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
  	<?php get_template_part( 'entry' ); ?>
    
  <?php endwhile; endif; ?>
  <?php get_template_part( 'nav', 'below' ); ?>
</section>

<?php get_footer(); ?>

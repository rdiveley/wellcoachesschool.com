<section class="entry-summary">
<?php if ( is_singular() ) { echo '<h1>'; } else { echo '<h2 class="entry-title">'; } ?><a href="<?php the_permalink(); ?>" title="<?php the_title_attribute(); ?>" rel="bookmark"><?php the_title(); ?></a><?php if ( is_singular() ) { echo '</h1>'; } else { echo '</h2>'; } ?> <?php edit_post_link(); ?>
<?php if ( !is_search() ) get_template_part( 'entry', 'meta' ); ?>
<?php 
		
		the_excerpt(); 
		echo  '<a class="continue_reading" href="'. get_permalink($post->ID) . '"><br />Continue Reading »</a>';
		
?>
<?php if( is_search() ) { ?><div class="entry-links"><?php wp_link_pages(); ?></div><?php } ?>
</section>
<div style="clear: both;"></div>
<?php get_header(); ?>

  <?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
	
	<?php get_template_part( 'entry' ); ?>
  	
	<?php comments_template(); ?>

  <?php endwhile; endif; ?>
<?php 
	$total_pages = $wp_query->max_num_pages;
	if($total_pages > 1){
		echo '<div id="page_btns">';
				posts_nav_link('|','« Prev Page ','Next Page »');
		echo '</div>';
		
		echo '<div id="pagination">';
			 $args = array('prev_text'    => __('« '),'next_text'    => __(' »'));
			 echo paginate_links( $args ); 
		echo '</div>';
	}
	?>

<?php get_footer(); ?>
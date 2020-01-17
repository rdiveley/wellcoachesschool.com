<div id="container">
<?php
	add_filter( 'post_thumbnail_html', 'remove_thumbnail_dimensions', 10, 3 );

	function remove_thumbnail_dimensions( $html, $post_id, $post_image_id ) {
    		$html = preg_replace( '/(width|height)=\"\d*\"\s/', "", $html );
    		return $html;
	} 
?>
			<div id="left_column">
				<a class="blog_home" href="<?php echo esc_url( home_url( '/' ) ); ?>" title="<?php esc_attr_e( get_bloginfo( 'name' ), 'blankslate' ); ?>">&#8592;&nbsp;&nbsp;Blog Home</a>
				<div class="indiv_byline">
					<p>author</p> 
					<!-- <a href="<?php the_author_link(); ?>"><?php the_author_posts_link(); ?></a> -->
					<!-- the_author_posts_link() automatically generates the entire link from <a to </a> -->
					<?php  the_author_posts_link(); ?>
					<p>date</p>
					<a href="<?php echo get_day_link(get_post_time('Y'), get_post_time('m'), get_post_time('j')); ?>"><?php the_time( get_option( 'date_format' ) ); ?></a>
					<p>category</p>
					<a href="?cat=<?php $category = get_the_category(); echo $category[0]->cat_ID; ?>"><?php $category = get_the_category(); echo $category[0]->cat_name; ?></a>
				</div>
			</div>

			<div id="right_column" style="position:relative;top:-10px;">
				<div id="blog_post" >
                	<h1><?php echo get_the_title( $ID ); ?></h1>
                    
					<div style="clear: both;"></div>
                    	<?php if ( has_post_thumbnail() ) { the_post_thumbnail($size='post-thumbnail'); } ?> 
						
                        <?php
						   ob_start();
						   the_content('Read the full post',true);
						   $postOutput = ob_get_contents();
						   ob_end_clean();
						   echo $postOutput;
						  ?>
                                            </div>

				<div id="comments">
					<?php comments_template(); ?>
				</div>
				<div id="related_posts">
                
					<?php
						$orig_post = $post;
						global $post;
						$tags = wp_get_post_tags($post->ID);
				 
						if ($tags) {
							echo '<h3>Also on wellcoaches blog</h3>';
							$tag_ids = array();
						foreach($tags as $individual_tag) $tag_ids[] = $individual_tag->term_id;
							$args=array(
								'tag__in' => $tag_ids,
								'post__not_in' => array($post->ID),
								'posts_per_page'=>4, // Number of related posts to display.
								'caller_get_posts'=>1
							);
				 
						$my_query = new wp_query( $args );
				 
						while( $my_query->have_posts() ) {
							$my_query->the_post();
						?>
				 
						<div class="related_post">
							<a href="<?php the_permalink() ?>" title="Permanent Link to <?php the_title_attribute(); ?>"><?php the_title(); ?></a>
							<?php 
							the_excerpt(); ?>
							</a>
						</div>
				 
						<?php }
						}
						$post = $orig_post;
						wp_reset_query();
						?>
    </div>
                
                </div>
				
			</div>

			<div style="clear: both;"></div>
		
	</div>
<div class="blog_post_preview" id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
<div style="float:left;padding:20px">
<?php 
$image = wp_get_attachment_image_src( get_post_thumbnail_id( $post->ID ), 'thumbnail' ); 

if ($image) : ?>
    <img src="<?php echo $image[0]; ?>" alt="" />
<?php endif; ?> 
</div>

<?php	if (is_home()) {
		get_template_part( 'entry-summary');
		
	}else{
		
		get_template_part( 'entry', ( is_archive() || is_search() ? 'summary' : 'content' ));
	}
		
?>

</div>

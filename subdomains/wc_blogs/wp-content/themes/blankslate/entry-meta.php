<div class="byline">
	author <a href="<?php the_author_link(); ?> "><?php the_author_posts_link(); ?></a>&nbsp&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp&nbspdate 
    <a href="<?php echo get_day_link(get_post_time('Y'), get_post_time('m'), get_post_time('j')); ?>"><?php the_time( get_option( 'date_format' ) ); ?></a>&nbsp&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp&nbspcategory 
    <a href="?cat=<?php $category = get_the_category(); echo $category[0]->cat_ID; ?>"><?php $category = get_the_category(); echo $category[0]->cat_name; ?></a>
</div>


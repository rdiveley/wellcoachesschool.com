<div class="byline">
	<a class="blog_home" href="<?php echo esc_url( home_url( '/' ) ); ?>">&#8592;&nbsp;&nbsp;Blog Home</a>
   
    <p>author</p> 
     <a href="<?php the_author_link(); ?> "><?php the_author_posts_link(); ?></a>
    <p>date</p>
    <a href="<?php echo get_day_link(get_post_time('Y'), get_post_time('m'), get_post_time('j')); ?>"><?php the_time( get_option( 'date_format' ) ); ?></a>
    <p>category</p>
    <a href="?cat=<?php $category = get_the_category(); echo $category[0]->cat_ID; ?>"><?php $category = get_the_category(); echo $category[0]->cat_name; ?></a>
</div>
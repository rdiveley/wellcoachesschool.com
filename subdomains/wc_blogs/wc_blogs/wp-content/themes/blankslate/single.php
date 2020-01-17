<?php get_header(); ?>
<section id="content" role="main">
<?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
<?php get_template_part( 'wc_single' ); ?>



<?php endwhile; endif; ?>
<footer class="footer">
<?php /*?><?php get_template_part( 'nav', 'below-single' ); ?><?php */?>
</footer>
</section>

<?php get_footer(); ?>

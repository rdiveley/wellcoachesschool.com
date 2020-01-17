<?php
/**
 * The Header template for our theme
 *
 * Displays all of the <head> section and everything up till <div id="main">
 *
 * @package WordPress
 * @subpackage Twenty_Thirteen
 * @since Twenty Thirteen 1.0
 */
?><!DOCTYPE html>
<!--[if IE 7]>
<html class="ie ie7" <?php language_attributes(); ?>>
<![endif]-->
<!--[if IE 8]>
<html class="ie ie8" <?php language_attributes(); ?>>
<![endif]-->
<!--[if !(IE 7) & !(IE 8)]><!-->
<html <?php language_attributes(); ?>>
<!--<![endif]-->
<head>
	<meta charset="<?php bloginfo( 'charset' ); ?>">
	<meta name="viewport" content="width=device-width">
	<title><?php wp_title( '|', true, 'right' ); ?></title>
	<link rel="pingback" href="<?php bloginfo( 'pingback_url' ); ?>">
	<!--[if lt IE 9]>
	<script src="<?php echo get_template_directory_uri(); ?>/js/html5.js"></script>
	<![endif]-->
	<?php wp_head(); ?>
</head>
<div id="header_container">
		<div id="header">
			<div class="left">
				<a class="home-link" href="<?php echo esc_url( home_url( '/' ) ); ?>" title="<?php echo esc_attr( get_bloginfo( 'name', 'display' ) ); ?>" rel="home"><img src="../img/wellcoaches.gif" /></a>
			</div>
			<div class="right">
				<p class="page_title"><?php bloginfo( 'name' ); ?></p>
				<p class="page_desc"><?php bloginfo( 'description' ); ?></p>
			</div>
		</div>
        
        
	</div>
    

	<div style="clear: both;"></div>
    <div id="filter_container">
		<div id="filters">
			<?php wp_dropdown_categories( $args ); ?>
			<?php wp_dropdown_users( $args ); ?> 
			<?php get_search_form(); ?>
		</div>
	</div>
    
    <div id="left_column">
				<a class="blog_home" href="">&#8592;&nbsp;&nbsp;Blog Home</a>
				<div class="indiv_byline">
					<?php twentythirteen_entry_meta(); ?>
				</div>
	</div>
<body <?php body_class(); ?>>


		<div id="main" class="site-main">

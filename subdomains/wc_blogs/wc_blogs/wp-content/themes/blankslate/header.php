



<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
<meta charset="<?php bloginfo( 'charset' ); ?>" />
<meta name="viewport" content="width=device-width" />
<title>
<?php wp_title( ' | ', true, 'right' ); ?>
</title>
<link rel="stylesheet" type="text/css" href="<?php echo get_stylesheet_uri(); ?>" />
<?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
<div id="wrapper" class="hfeed">
<div id="header_container">
	<div id="header">
		<div class="left">
			<a href="http://www.wellcoachesschool.com" rel="home"><img src="../img/wellcoaches.gif" border="0" /></a>
		</div>
		<div class="right">
			<p class="page_title"><?php echo esc_html( get_bloginfo( 'name' ) ); ?></p>
			<p class="page_desc"><?php bloginfo( 'description' ); ?></p>
		</div>
	</div>
</div>

	<div style="clear: both;"></div>

	<div id="filter_container" class="group">
		<div id="filters" class="group">
			<!--<div>
				<?php wp_dropdown_categories( 'show_option_none=CATEGORY NAME' ); ?>
				<script type="text/javascript">
                    <!--
                    var dropdown = document.getElementById("cat");
                    function onCatChange() {
                        if ( dropdown.options[dropdown.selectedIndex].value > 0 ) {
                            location.href = "<?php echo esc_url( home_url( '/' ) ); ?>?cat="+dropdown.options[dropdown.selectedIndex].value;
                        }else{
							  location.href = "<?php echo esc_url( home_url( '/' ) ); ?>";
                       
						}
                    }
                    dropdown.onchange = onCatChange;
                </script>
             </div>-->
             
             <!-- Categories Filter -->
             <div class="blog-filter first-filter" id="blog-filter">
                 <div class="blog-filter-inner">
                     <div class="blog-filter-button">
                            Browse by Category
                            <?php
                            $args = array(
                              'orderby' => 'name',
                              'parent' => 0
                              );
                            $categories = get_categories( $args );
                            foreach ( $categories as $category ) {
                            	echo '<a href="' . get_category_link( $category->term_id ) . '">' . $category->name . '</a>';
                            }
                            ?>
                     </div> 
                 </div>
            </div>
            
            <!-- Authors Filter -->
            <div class="blog-filter second-filter" id="blog-filter">
                <div class="blog-filter-inner">
                    <div class="blog-filter-button">
                        Browse by Author
                        <?php
                        $args2 = array(
                          'orderby' => 'name',
                          'order' => 'ASC'
                          );
                        $authors = wp_list_authors( $args2 );
                        ?>
                    </div>
                </div>
            </div>
                
            <!--
             <?php $args = array(
			 	'include_selected' => true,
				'show_option_none' => 'AUTHOR',
				'include_selected' => true
				);
			  ?>
             <?php wp_dropdown_users($args ); ?>
				<script type="text/javascript">
                    <!--
                    var dropdownAuthor = document.getElementById("user");
                    function onUserChange() {
                        if ( this.options[dropdownAuthor.selectedIndex].value > 0 ) {
                            location.href = "<?php echo esc_url( home_url( '/' ) ); ?>?author="+dropdownAuthor.options[dropdownAuthor.selectedIndex].value;
                        }
                    }
					
                    dropdownAuthor.onchange = onUserChange;
                </script>
                -->
			<div class="blog-filter last-filter"><?php get_search_form($args); ?></div>

		</div>
	</div>
	<div style="clear:both;"></div>
<div id="container" class="group"> 

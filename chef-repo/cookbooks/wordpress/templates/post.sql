USE wordpress;
UPDATE `wp_posts` SET `post_content` = '<!-- wp:paragraph -->\r\n<p>Bienvenido al WordPress de Adrián Pérez, Beatriz Serrano y Juan José Hernández. Esta es su primera entrada para la actividad.</p>\r\n<!-- /wp:paragraph -->', `post_title` = '¡Hola, Mundo DevOps!', `post_name` = 'hola-mundo-devops' WHERE `wp_posts`.`ID` = 1;

# la manera más adecuada de soportar diversas plataformas con diferentes nombres de paquetes desde Chef es mediante la utilización de la función de ayuda value_for_platform que, a partir de una estructura de datos, nos devuelve un valor correspondiente a la plataforma sobre la que ejecuta la receta. 

#Así, en función de este valor, podremos determinar los paquetes que deberemos instalar en cada plataforma

vim_base_pkgs = value_for_platform({
    ["ubuntu","debian","arch"]  => {"default" => ["vim"]}, 
    ["redhat","centos","fedora","scientific"] => {"default"=> ["vim-minimal","vim-enhanced"]},
    "default"=> ["vim"]})

vim_base_pkgs.each do |vim_base_pkg| 
    package vim_base_pkg
end

node['vim']['extra_packages'].each do |vimpkg| 
    package vimpkg
end
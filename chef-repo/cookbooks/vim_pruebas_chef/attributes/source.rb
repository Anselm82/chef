default['vim']['source']['version']       = '8.2'
default['vim']['source']['checksum']      = 'f087f821831b4fece16a0461d574ccd55a8279f64d635510a1e10225966ced3b'
default['vim']['source']['prefix']        = '/usr/local'
default['vim']['source']['configuration'] = "--without-x --enable-pythoninterp --enable-rubyinterp --enable-tclinterp --enable-luainterp --enable-perlinterp --enable-cscope  --with-features=huge --prefix=#{default['vim']['source']['prefix']}"

default['vim']['source']['dependencies'] = 
    if platform_family? 'rhel', 'fedora'
        %w( ctags
            gcc
            lua-devel
            make
            ncurses-devel
            perl-devel
            perl-ExtUtils-CBuilder
            perl-ExtUtils-Embed
            perl-ExtUtils-ParseXS
            python-devel
            ruby-devel
            tcl-devel
            bzip2
        )
    elsif platform_family?('suse')
        %w( ctags
            gcc
            lua-devel
            make
            ncurses-devel
            perl
            python-devel
            ruby-devel
            tcl-devel
            tar
        )
    else
        %w( exuberant-ctags
            gcc
            libncurses5-dev
            libperl-dev
            lua5.1
            make
            python-dev
            ruby-dev
            tcl-dev
            bzip2
       )
end

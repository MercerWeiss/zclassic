package=libgmp
$(package)_version=2.7.2
$(package)_download_path=http://www.mpir.org/
$(package)_file_name=mpir-$($(package)_version).tar.bz2
$(package)_sha256_hash=a7d4c33595b4f781a51c92d5d139ec2efb3cf1bf101dfc3eef5b40c54e6f45ec
$(package)_dependencies=
$(package)_config_opts=--enable-cxx --disable-shared --enable-gmpcompat ABI=64 --with-system-yasm=yes

define $(package)_config_cmds
HOST=$(host)  $($(package)_autoconf) 
endef

define $(package)_build_cmds
  $(MAKE) CPPFLAGS='-fPIC' --host=$(host) --build=$(build)
endef

define $(package)_stage_cmds
  $(MAKE) DESTDIR=$($(package)_staging_dir) install ; echo '=== staging find for $(package):' ; find $($(package)_staging_dir)
endef

package=libsnark
$(package)_download_path=https://github.com/radix42/$(package)/archive/
$(package)_file_name=$(package)-$($(package)_git_commit).tar.gz
$(package)_download_file=$($(package)_git_commit).tar.gz

$(package)_sha256_hash=a8eea4bc3cff9aaa9ff6480f9d5af2964efd61f561afb3df9c63669f9426b3bf
$(package)_git_commit=e12fbb45b590319181dd4ed1a86dc14b3c927ff7

$(package)_dependencies=libgmp libsodium

define $(package)_build_cmds
  CXX="x86_64-w64-mingw32-g++-posix" CXXFLAGS="-DBINARY_OUTPUT -DPTW32_STATIC_LIB -DSTATICLIB -DNO_PT_COMPRESSION=1 -fopenmp" $(MAKE) lib DEPINST=$(host_prefix) CURVE=ALT_BN128 MULTICORE=1 NO_PROCPS=1 NO_GTEST=1 NO_DOCS=1 STATIC=1 NO_SUPERCOP=1 FEATUREFLAGS=-DMONTGOMERY_OUTPUT OPTFLAGS="-O2 -march=x86-64"
endef

define $(package)_stage_cmds
  $(MAKE) install STATIC=1 DEPINST=$(host_prefix) PREFIX=$($(package)_staging_dir)$(host_prefix) CURVE=ALT_BN128 NO_SUPERCOP=1
endef

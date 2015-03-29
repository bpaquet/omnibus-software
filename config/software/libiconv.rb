#
# Copyright 2012-2014 Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "libiconv"
default_version "1.14"

source url: "https://github.com/bpaquet/ppc64le/raw/e4eb605b0f76b0fe15b57d98c901a21f38a14d8f/libiconv-#{version}.tar.gz",
       md5: '5fa50d38c72bbae60563b734c65cfa25'

relative_path "libiconv-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  configure_command = "./configure" \
                      " --prefix=#{install_dir}/embedded"
  if aix?
    patch_env = env.dup
    patch_env['PATH'] = "/opt/freeware/bin:#{env['PATH']}"
    patch source: 'libiconv-1.14_srclib_stdio.in.h-remove-gets-declarations.patch', env: patch_env
  else
    patch source: 'libiconv-1.14_srclib_stdio.in.h-remove-gets-declarations.patch'
  end

  command configure_command, env: env

  make "-j #{workers}", env: env
  make "-j #{workers} install-lib" \
          " libdir=#{install_dir}/embedded/lib" \
          " includedir=#{install_dir}/embedded/include", env: env
end

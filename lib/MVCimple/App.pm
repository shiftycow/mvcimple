#!/usr/bin/perl
use strict;
package MVCimple::App;
#
#    This file is part of MVCimple.
#
#    MVCimple is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    MVCimple is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with MVCimple.  If not, see <http://www.gnu.org/licenses/>. 
#
#

# wrapper for including necessary modules for a MVCimple web application

#system includes
use XML::Simple;

#local includes
use MVCimple::BaseModel;
use MVCimple::DBConnect;
use MVCimple::Config;
use MVCimple::RenderView;
use MVCimple::GenSQL;

1;

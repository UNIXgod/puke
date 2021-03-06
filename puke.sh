#!/bin/sh
##########################################################################
# Title      :  puke - The Cucumber Feature Dump
# Author     :  Stuart Gerstein <stu@rubyprogrammer.net>
# Date       :  2013-04-27
# Requires   :  Ruby Cucumber 
# Category   :  Development Utilities
# License    :  BSD (See COPYING file)                  
##########################################################################
# Description
#    o  "puke" simply pukes out the step definitions for redirection to
#       the step file and leave traps and poison for mice near the console
#    o  NOTES: puke currently only works as a simple filter hack.               
#       This script was created for educational purposes                
#	Don't blame be for your problems. When in doubt noclobber
# Examples:
#       puke > features/step_definitions/puked_steps.rb
##########################################################################

puke=/tmp/$0.$$
mkfifo $puke

cleanup() {
	# TODO:set some traps
	rm $puke
}

flatulate() {
	cucumber > $puke&
}

tac() {
	awk '{a[i++]=$0} END{for (j=i-1; j>=0;) print a[j--] }'
} #cargo

vomit() {
	flatulate
	s2n='/^Feature:.*Feature$/,/^You.*snippets:$/d;/^If.*,$/,/^exists.*\.$/d;'
	sed $s2n <$puke | tac | tail -n +3 | tac # sed '1d;$d'
}
vomit 
cleanup

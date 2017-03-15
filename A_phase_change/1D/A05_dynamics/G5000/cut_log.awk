#!/usr/bin/awk -f

BEGIN {i = 0;}
{
	if( $1 == "EDGE"){
		i++;
	}
	if( i == 100){
		exit 0
	}
	print $0;
}

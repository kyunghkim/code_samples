package AllocationDepartment;

use strict;
use warnings;

use Data::Dumper;

use AllocationEmployee;

sub new {
	my $class = shift;
	my %attrs = @_;
	my $self = {};
	$self->{employees} = $attrs{employees} if $attrs{employees}; #aryref
	bless( $self, $class );
	$self->{expense_allocation} = $self->expense_allocation;
	return $self;
}

sub expense_allocation {
	my $self = shift;
	my $total_allocation;
	# TODO - create next_employee method	
	for my $emp( @{$self->{employees}} ) {
		my $emp_obj = AllocationEmployee->new( %$emp );
		$total_allocation += $emp_obj->expense_allocation;	
	}	
	return $total_allocation;
}	

1;

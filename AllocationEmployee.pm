package AllocationEmployee;

use strict;
use warnings;

use Data::Dumper;

sub new {
	my $class = shift;
	my %attr = @_;
	my $self = {};
	for my $attr_name( qw/ function allocation / ) {
		die "Required employee attribute $attr_name has not been specified\n" unless
			$attr{ $attr_name };
		$self->{$attr_name} = $attr{$attr_name};
	}		
	$self->{assigned_employees} = $attr{assigned_employees} if $attr{assigned_employees};
	bless( $self, $class );
	$self->{expense_allocation} = $self->expense_allocation;
	return $self;
}

sub function {
	my $self = shift;
	return $self->{function};
}

sub allocation {
	my $self = shift;
	return $self->{allocation};
}

sub expense_allocation {
	my $self = shift;
	my $assigned_employee_allocation = $self->_assigned_employee_allocation;
	return $self->{allocation} + $assigned_employee_allocation;
}

sub _assigned_employee_allocation {
	my $self = shift;
	my $total_allocation = 0;
	if( $self->{assigned_employees} ) {
		my @assigned_employees = @{$self->{assigned_employees}};
		HIERICHY: while( 1 ) {
			my @hierichical_employees;
			for my $emp( @assigned_employees ) {
				$total_allocation += $emp->{allocation};
				push @hierichical_employees, @{$emp->{assigned_employees}} if $emp->{assigned_employees};
			}
			last HIERICHY unless @hierichical_employees;
			@assigned_employees = @hierichical_employees;
		}		
	}
	return $total_allocation;
}

1;

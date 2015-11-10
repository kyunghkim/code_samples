#!/usr/bin/perl

use strict;
use warnings;

use AllocationEmployee;
use AllocationDepartment;

use Test::More;
use Data::Dumper;

my $manager_allocation   = 300;
my $developer_allocation = 1000;
my $qa_tester_allocation = 500;

my $employee_obj = AllocationEmployee->new( &employee_test_data );
my $expected_function = 'Developer';
ok( $employee_obj->function eq $expected_function, "Expected employee function is $expected_function" ); 
ok( $employee_obj->function ne 'fake_position', "Unexpected employee function failed test" );
ok( $employee_obj->allocation eq $developer_allocation, "Expected employee allocation is $developer_allocation" );
ok( $employee_obj->allocation ne 100_000_000, "Unexpected employee allocation failed test" );

my $manager_obj = AllocationEmployee->new( &manager_test_data );
my $manager_expense_allocation = 1800;
ok( $manager_obj->expense_allocation == $manager_expense_allocation, "Manager expense allocation is $manager_expense_allocation" );
ok( $manager_obj->expense_allocation != 1, "Unexpected manager expense allocation test failed" );

my $dept_obj = AllocationDepartment->new( &department_test_data );
my $expected_department_expense_allocation = 6900;
ok( $dept_obj->expense_allocation == $expected_department_expense_allocation, "Expected department expense allocation is $expected_department_expense_allocation" );
ok( $dept_obj->expense_allocation != 1, "Unexpected department expense allocation test failed" );

done_testing();

exit;

sub employee_test_data {
	return (
		function => 'Developer',
		allocation => $developer_allocation,
	);
}

sub department_test_data {
	return (
		employees => [
			{
				function => 'Developer',
				allocation => $developer_allocation,
			},
			{
				function => 'QaTester',
				allocation => $qa_tester_allocation,
			},
			{
				function => 'Manager',
				allocation => $manager_allocation,
				assigned_employees => [
					{
						function => 'QaTester',
						allocation => $qa_tester_allocation,	
					},
					{
						function => 'Developer',
						allocation => $developer_allocation,
					},
					{
						function => 'Manager',
						allocation => $manager_allocation,
						assigned_employees => [
							{
								function => 'QaTester',
								allocation => $qa_tester_allocation,
							},
							{
								function => 'Developer',
								allocation => $developer_allocation,
							},
						],
					},
				],
			},
			{
				function => 'Manager',
				allocation => $manager_allocation,
				assigned_employees => [
					{
						function => 'Developer',
						allocation => $developer_allocation,
					},
					{
						function => 'QaTester',
						allocation => $qa_tester_allocation,
					},
				],
			},
		],
	);
}

sub manager_test_data {
	return (
    	function => 'Manager',
	    allocation => $manager_allocation,
		assigned_employees => [
			{
				function => 'QaTester',
				allocation => $qa_tester_allocation,
			},
			{
				function => 'Developer',
				allocation => $developer_allocation,
			},
		],
	);
}

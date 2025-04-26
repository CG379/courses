#include <stdio.h>

int main() {
	int year = 2025;
	const int currentYear = 2023;

	int isLeapYear;

	// boolean logic:
	isLeapYear = (year % 4 == 0) || ((year % 100 != 0) && 
    (year % 400 == 0));

	// printing the result:
    if (isLeapYear) {
    	printf("The year %d will be a leap year.\n", year);
    } else {
    	printf("The year %d will not be a leap year.\n", year);
    }
	return 0;
}
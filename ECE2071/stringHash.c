#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int is_prime(int num) {
  if (num < 2) {
    return 0;
  }
  for (int i = 2; i * i <= num; i++) {
    if (num % i == 0) {
      return 0;
    }
  }
  return 1;
}

int get_next_prime(int num) {
  while (!is_prime(++num)) {
  }
  return num;
}

int string_hash(char *string_1, int starting_value) {
  int accumulator = 0;
  int current_prime = get_next_prime(starting_value);

  for (int i = 0; i < strlen(string_1); i++) {
    accumulator += string_1[i] * current_prime;
    current_prime = get_next_prime(current_prime);
  }

  return accumulator;
}

int main(void) {
  char string_1[100];
    int starting_value;
    char filename[100];

    // Step 1: Scan string_1 and starting_value from the user
    printf("Enter a string: ");
    scanf("%99s", string_1);
    printf("Enter an integer starting value: ");
    scanf("%d", &starting_value);

    // Step 2: Call string_hash function
    int accumulator = string_hash(string_1, starting_value);

    // Step 3: Scan filename from the user
    printf("Enter a filename: ");
    scanf("%99s", filename);

    // Step 4: Open the file in append mode and write the data
    FILE* file = fopen(filename, "a");
    if (file == NULL) {
        printf("Failed to open the file.\n");
        return 1;
    }

    fprintf(file, "%s %d - %d\n", string_1, starting_value, accumulator);
    fclose(file);

    printf("Data appended to the file successfully.\n");
  return 0;
}
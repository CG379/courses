#include <cs50.h>
#include <math.h>
#include <stdio.h>

int main(void)
{
    // Declare and initialize a variable and ask for user input.
    long cardnumber = 0;

    // Ask for credit card number as long as it is above 0

    do
    {
      cardnumber = get_long("Number: ");
    }
    while (cardnumber < 0);

    // Check digit count to se if it is valid
    int count = 0;
    long long digits = cardnumber;
    while (digits > 0)
    {
        digits = digits/10;
        count++;
    }
    //if it isn't the right count it will print invalid
    if ((count != 13) && (count != 15) && (count != 16))
    {
        printf("INVALID\n");
    }

    int number[count];
    //separates each number into an array
    for (int i = 0; i < count; i++)
    {
        number[i] = cardnumber % 10;
        cardnumber = cardnumber / 10;
    }
    //creates another array that can be changed while still keeping the old one
    int originalnumber[count];
    for (int i = 1; i < count; i++)
    {
        originalnumber[i] = number[i];
    }
    //Step 1: times every second number by 2
    for (int i = 1; i < count; i+=2)
    {
        number[i] = number[i] * 2;
    }

    int v = 0;
    int temp;

    if (count == 13)
    {
      //add all the multiplied numbers together and add then to the rest of the numbers
      for (int i = 0; i < count; i++)
      {
        temp = (number[i] % 10) + (number[i] / 10 % 10);
        v = v + temp;
      }
      if (originalnumber[12] == 4 && v % 10 == 0)
      {
        printf("VISA\n");
      }
      else
      {
        printf("INVALID\n");
      }
    }
    if (count == 15)
    {
      //add all the multiplied numbers together and add then to the rest of the numbers]
      for (int i = 0; i < count; i++)
      {
        temp = (number[i] % 10) + (number[i] / 10 % 10);
        v = v + temp;
      }
    if (originalnumber[14] == 3 && v % 10 == 0 && (originalnumber[13] == 4 || originalnumber[13] == 7))
  {
    printf("AMEX\n");
  }
     else
    {
      printf("INVALID\n");
    }
    }
    if (count == 16)
    {
      //add all the multip[lied numbers together and add then to the rest of the numbers
    for (int i = 0; i < count; i++)
  {
    temp = (number[i] % 10) + (number[i] / 10 % 10);
    v = v + temp;
   }
   //VISA check
      if (originalnumber[15] == 4 && v % 10 == 0)
    {
    printf("VISA\n");
    }
    //MASTERCARD chekc
  else if (originalnumber[15] == 5 && v % 10 == 0 && (originalnumber[14] == 1 || originalnumber[14] == 2 || originalnumber[14] == 3
  || originalnumber[14] == 4 || originalnumber[14] == 5))
        {
            printf("MASTERCARD\n");
        }
else
{
printf("INVALID\n");
}
}
}
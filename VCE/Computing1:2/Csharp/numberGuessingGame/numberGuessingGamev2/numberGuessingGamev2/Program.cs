using System;

namespace numberGuessingGamev2
{
    class Program
    {
        static void Main(string[] args)
        {
            int counter = 0;
            int value;
            Console.WriteLine("This is a game to let the computer guess a number.");
            Console.WriteLine("To tell the computer it is too high or to low enter up arrow or down arrow");
            Console.WriteLine("If it is correct, enter '='");
            Console.WriteLine("Enter a number between 1 and 100 for the computer to guess:");
            value = Convert.ToInt32(Console.ReadLine());
            while (value > 1 || value > 100) 
            {
                if (value > 100)
                {
                    Console.WriteLine("Number has to be less than 100.");
                }
                if (value < 1) 
                {
                    Console.WriteLine("Number has to be greater than 1.");
                }
            }

            Console.WriteLine("The computer will now try to guess:");

            Random randomNumber = new Random;
            int guess = randomNumber.Next(1, 100);
            Console.WriteLine("It the number {0}?", guess);
            char sign;
            do
            {
                if (sign == ) { int guess2 = randomNumber.Next(1, guess);
                    Console.WriteLine("It the number {0}?", guess2);
                }
                if (sign == ) { int guess2 = randomNumber.Next(guess, 100);
                    Console.WriteLine("It the number {0}?", guess2);
                }
                if (sign == ) { break; }

            } while (counter < 100 || value != guess);

            }
    }
}

using System;

namespace numberGuessingGame
{
    class Program
    {
        static void Main(string[] args)
        {
            bool run = true;
            int maxTrys = 5;
            Random random = new Random();

            while (run)
            {
                int rnd = random.Next(1, 51); 

                Console.WriteLine("I am thinking of a number between 1 and 50, can you guess it?");
                int counter = 0;
                bool solved = false;
                while (!solved && counter < maxTrys)
                {
                    counter++;
                    int guess;
                    bool numericGuess;
                    do
                    {
                        numericGuess = int.TryParse(Console.ReadLine(), out guess);
                        if (!numericGuess)
                        {
                            Console.WriteLine("Please enter a number");
                        }
                    } while (!numericGuess);

                    if (guess > rnd)
                    {
                        Console.WriteLine("The number is lower than {0}, guess again.", guess);
                    }
                    else if (guess < rnd)
                    {
                        Console.WriteLine("The number is higher than {0}, guess again.", guess);
                    }
                    else if (guess == rnd)
                    {
                        solved = true;
                        Console.WriteLine("{0} is the right answer and you only needed {1} trys", rnd, counter);
                    }
                }
                if (!solved)
                {
                    Console.Clear();
                    Console.WriteLine("The actual number of {0}. You failed!", rnd);
                }

            }
            Console.Clear();
            Console.WriteLine("Thanks for playing see you next time!");
            Console.ReadLine();
        }
    }
}


